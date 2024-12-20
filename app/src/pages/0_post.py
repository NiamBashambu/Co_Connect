import logging
import streamlit as st
import requests
from datetime import datetime
from modules.nav import SideBarLinks

# Set up logging
logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

BASE_URL = "http://web-api:4000/p/posts"

# Set page layout to wide
st.set_page_config(layout="wide", page_title="Post Feed", page_icon="💬")

# Custom CSS for fancy styling
st.markdown(
    """
    <style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f7fb;
        margin: 0;
    }
    .post-container {
        background-color: #ffffff;
        border-radius: 15px;
        padding: 25px;
        margin-bottom: 30px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease-in-out;
    }
    .post-container:hover {
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        transform: translateY(-5px);
    }
    .post-header {
        font-weight: 600;
        font-size: 18px;
        color: #333;
        margin-bottom: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .post-header span {
        font-size: 14px;
        color: #888;
    }
    .post-content {
        font-size: 16px;
        color: #555;
        line-height: 1.8;
        margin-bottom: 20px;
    }
    .post-footer {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 10px;
    }
    .action-button {
        background-color: #007bff;
        color: white;
        padding: 8px 15px;
        border-radius: 20px;
        font-size: 14px;
        cursor: pointer;
        border: none;
        transition: background-color 0.3s ease;
    }
    .action-button:hover {
        background-color: #0056b3;
    }
    .add-post-btn {
        background-color: #28a745;
        color: white;
        font-size: 28px;
        border-radius: 50%;
        width: 60px;
        height: 60px;
        display: flex;
        justify-content: center;
        align-items: center;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .add-post-btn:hover {
        background-color: #218838;
    }
    .form-container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        margin-top: 50px;
        max-width: 800px;
        margin-left: auto;
        margin-right: auto;
    }
    .form-container input, .form-container textarea {
        width: 100%;
        padding: 12px;
        margin-bottom: 20px;
        border-radius: 10px;
        border: 1px solid #ddd;
        font-size: 16px;
        transition: border-color 0.3s ease;
    }
    .form-container input:focus, .form-container textarea:focus {
        border-color: #007bff;
        outline: none;
    }
    .form-container .submit-btn {
        background-color: #007bff;
        color: white;
        padding: 12px 20px;
        border-radius: 30px;
        font-size: 18px;
        cursor: pointer;
        border: none;
        width: 100%;
    }
    .form-container .submit-btn:hover {
        background-color: #0056b3;
    }
    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    .header-container h1 {
        font-size: 32px;
        color: #333;
    }
    .profile-icon {
        background-color: #007bff;
        color: white;
        font-size: 24px;
        border-radius: 50%;
        width: 50px;
        height: 50px;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .profile-icon:hover {
        background-color: #0056b3;
    }
    </style>
    """,
    unsafe_allow_html=True,
)

# Sidebar links (if any)
SideBarLinks()

# Title for the Streamlit app
st.markdown("<div class='header-container'>", unsafe_allow_html=True)
st.title("💬 Post Feed")
st.markdown("</div>", unsafe_allow_html=True)

# Display the user's first name if authenticated
if st.session_state.get("authenticated"):
    user_name = st.session_state.get('name', 'Guest')
    st.write(f"Hello, {user_name}! 👋 Welcome to the Post Feed")

# Fetch Posts Automatically from the API
posts = requests.get(BASE_URL).json()
try:
    posts = sorted(posts, key=lambda x: datetime.strptime(x["PostDate"], "%a, %d %b %Y %H:%M:%S %Z"), reverse=True)
except ValueError as e:
    st.error(f"Error parsing date: {e}")

# Add a button to add a post
with st.container():
    if "show_form" not in st.session_state:
        st.session_state["show_form"] = False

    def toggle_form():
        st.session_state["show_form"] = not st.session_state["show_form"]

    # Plus button to toggle form visibility
    st.button("➕ Create Post", key="toggle_form", on_click=toggle_form, use_container_width=True)

# Display the post creation form if the state is toggled
if st.session_state["show_form"]:
    st.write("### ✍️ Create a New Post")
    with st.form(key="create_post", clear_on_submit=True):
        # Automatically pre-fill the Student Name field with the logged-in user's name
        student_name = st.session_state.get("name", "Guest")
        student_id = st.text_input("Student ID", placeholder="Enter your Student ID")
        content = st.text_area("Content", placeholder="What's on your mind?")
        post_date = st.date_input("Post Date", value=datetime.now().date())
        category = st.text_input("Category", placeholder="Enter a category (e.g., News, Updates)")

        # Pre-fill name field
        st.text_input("Student Name", value=student_name, disabled=True)
    
        submit_button = st.form_submit_button(label="Post", use_container_width=True)
        if submit_button:
            post_data = {
                "StudentId": student_id,
                "Content": content,
                "PostDate": str(post_date),
                "Category": category,
                "Name": student_name  # Pass the logged-in user's name with the post
            }
            response = requests.post(BASE_URL, json=post_data)
            if response.status_code == 201:
                st.success("Your post has been created successfully!")
                st.session_state["show_form"] = False  # Hide form after successful submission
            else:
                st.error("Failed to create the post. Please try again.")

# Display posts if available
if posts:
    for post in posts:
        post_id = post.get("PostId")
        student_name = post.get("Name")
        content = post.get("Content")
        post_date = post.get("PostDate")
        category = post.get("Category")
            
        # Wrap everything inside the post container
        with st.container():
            
            
            # Post Header: Student Info and Post Category
            st.markdown(
                f"""
                <div class="post-container">
                    <div class="post-header">
                        <span><b>{student_name}</b> </span>
                        <span>{category}</span>
                    </div>
                    <div style='color: #888; font-size: 14px;'>📅 {post_date}</div>
                    <div class="post-content">
                        {content}
                    </div>
                    
                </div>
                """,
                unsafe_allow_html=True,
            )
            
            # Action Buttons (like delete, edit etc.)
            st.markdown("<div class='post-footer'>", unsafe_allow_html=True)
            delete_button = st.button(f"Delete Post {post_id}", key=f"delete_{post_id}")
            if delete_button:
                confirm = st.radio(
                    "Are you sure you want to delete this post?",
                    ["No", "Yes"], key=f"confirm_{post_id}")
                if confirm == "Yes":
                    response = requests.delete(f"{BASE_URL}/{post_id}")
                    if response.status_code == 200:
                        st.success(f"Post {post_id} has been deleted successfully!")
                    else:
                        st.error("Failed to delete the post. Please try again.")
            st.markdown("</div>", unsafe_allow_html=True)
            
else:
    st.write("No posts found.")

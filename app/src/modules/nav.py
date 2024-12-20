# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st


#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About Us", icon="🧠")


#### ------------------------ Examples for Role of ------------------------


# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=True):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in.
    """

    # add a logo to the sidebar always
    st.sidebar.image("assets/logo2.png", width=500)

    # If there is no logged in user, redirect to the Home (Landing) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # Show World Bank Link and Map Demo Link if the user is a political strategy advisor role.
        if st.session_state["role"] == "employer":
            st.sidebar.page_link(
                "pages/3_joblistings.py", label="Job Listing", icon="📚"
            )
            st.sidebar.page_link(
                "pages/12_updatejoblistings.py", label="Update Job Listings", icon="👔"
            ) 
            st.sidebar.page_link(
                "pages/5_viewpost.py", label="Posts", icon="📧"
            )
            st.sidebar.page_link(
                "pages/1_allstudentsprofile.py", label="Student Profiles", icon="🏫"
            )
            st.sidebar.page_link(
                "pages/9_allresumes.py", label="Student Resumes", icon="📝"
            )
            st.sidebar.page_link(
                "pages/10_employerprofile.py", label="Profile", icon="👤"
            ) 
            
            

        # If the user role is usaid worker, show the Api Testing page
        if st.session_state["role"] == "student_searching":
            st.sidebar.page_link(
                "pages/4_viewjoblistings.py", label="Job Listing", icon="📚"
            )
            st.sidebar.page_link(
                "pages/0_post.py", label="Posts", icon="📧"
            )
            
            st.sidebar.page_link(
                "pages/7_employmentstatus.py", label="Employment Status", icon="💼"
            )
            st.sidebar.page_link(
                "pages/11_uploadresume.py", label="Upload Resume", icon="📝"
            )
            st.sidebar.page_link(
                "pages/2_studentprofile.py", label="Profile", icon="👤"
            )
            


        if st.session_state["role"] == "student_exploring":
            st.sidebar.page_link(
                "pages/4_viewjoblistings.py", label="Job Listing", icon="📚"
            )
            st.sidebar.page_link(
                "pages/5_viewpost.py", label="Posts", icon="📧"
            )
            st.sidebar.page_link(
                "pages/7_employmentstatus.py", label="Employment Status", icon="💼"
            )
            st.sidebar.page_link(
                "pages/11_uploadresume.py", label="Upload Resume", icon="📝"
            )
            st.sidebar.page_link(
                "pages/8_exploringstudent.py", label="Profile", icon="👤"
            )
            
        
        if st.session_state["role"] == "advisor":
            st.sidebar.page_link(
                "pages/4_viewjoblistings.py", label="Job Listing", icon="📚"
            )
            st.sidebar.page_link(
                "pages/5_viewpost.py", label="Posts", icon="📧"
            )
            st.sidebar.page_link(
                "pages/1_allstudentsprofile.py", label="All Students", icon="🏫"
            )
            st.sidebar.page_link(
                "pages/9_allresumes.py", label="Student Resumes", icon="📝"
            )
            st.sidebar.page_link(
                "pages/6_advisorprofile.py", label="Profile", icon="👤"
            )


    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")

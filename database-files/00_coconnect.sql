
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP DATABASE IF EXISTS coconnect;

CREATE DATABASE IF NOT EXISTS coconnect ;

grant all privileges on coconnect.* to 'root'@'%';
flush privileges;

USE coconnect;



-- Create the CoOp Advisor table
CREATE TABLE CoOpAdvisor (
    CoopAdvisorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Field VARCHAR(50)
);

-- Create the Student table
CREATE TABLE Student (
    StudentId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    YOG YEAR, -- Year of Graduation
    Major VARCHAR(50),
    Advisor INT,
    FOREIGN KEY (Advisor) REFERENCES CoOpAdvisor(CoopAdvisorID)
);

-- Create the Resume table
CREATE TABLE Resume (
    ResumeId INT AUTO_INCREMENT PRIMARY KEY,
    StudentId INT,
    Content TEXT,
    LastUpdated DATE,
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
);

-- Create the Student Searching table
CREATE TABLE StudentSearching (
    StudentId INT AUTO_INCREMENT PRIMARY KEY ,
    ResumeId INT,
    EmployStatus VARCHAR(20),
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId),
    FOREIGN KEY (ResumeId) REFERENCES Resume(ResumeId)
);

-- Create the Student Exploring Fields table
CREATE TABLE StudentExploringFields (
    StudentId INT AUTO_INCREMENT PRIMARY KEY ,
    Interest VARCHAR(50),
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
);

-- Create the Posts table
CREATE TABLE Posts (
    PostId INT AUTO_INCREMENT PRIMARY KEY,
    StudentId INT,
    Content TEXT,
    PostDate DATE,
    Category VARCHAR(50),
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
);

-- Create the Company table
CREATE TABLE Company (
    CompanyId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    State VARCHAR(50),
    City VARCHAR(50)
);

-- Create the Job Listing table
CREATE TABLE JobListing (
    JobId INT AUTO_INCREMENT PRIMARY KEY,
    Position VARCHAR(100),
    CompanyId INT,
    Department VARCHAR(50),
    Description TEXT,
    Location VARCHAR(100),
    PostDate DATE,
    FOREIGN KEY (CompanyId) REFERENCES Company(CompanyId)
);


-- Create the Notification table
CREATE TABLE Notification (
    NotifId INT AUTO_INCREMENT PRIMARY KEY,
    PostId INT,
    JobId INT,
    StudentId INT,
    TimeStamp DATETIME,
    Content TEXT,
    FOREIGN KEY (PostId) REFERENCES Posts(PostId)
                          ON DELETE CASCADE,
    FOREIGN KEY (JobId) REFERENCES JobListing(JobId),
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
);




-- Create the Employer table
CREATE TABLE Employer (
    EmployerId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    CompanyId INT,
    FOREIGN KEY (CompanyId) REFERENCES Company(CompanyId)
);
-- CoOp Advisors
INSERT INTO CoOpAdvisor (Name, Department, Field) VALUES
('Advisor_Alice', 'CS', 'AI'),
('Advisor_Bob', 'ECE', 'Robotics'),
('Advisor_Charlie', 'ME', 'Networking'),
('Advisor_Dave', 'Bio', 'Data Science'),
('Advisor_Eve', 'CS', 'AI'),
('Advisor_Frank', 'ECE', 'Robotics'),
('Advisor_Grace', 'ME', 'Networking'),
('Advisor_Hank', 'Bio', 'Data Science'),
('Advisor_Ivy', 'CS', 'AI'),
('Advisor_Jack', 'ECE', 'Robotics'),
('Advisor_Kate', 'ME', 'Networking'),
('Advisor_Liam', 'Bio', 'Data Science'),
('Advisor_Mia', 'CS', 'AI'),
('Advisor_Noah', 'ECE', 'Robotics'),
('Advisor_Olivia', 'ME', 'Networking'),
('Advisor_Peter', 'Bio', 'Data Science'),
('Advisor_Quinn', 'CS', 'AI'),
('Advisor_Rachel', 'ECE', 'Robotics'),
('Advisor_Sam', 'ME', 'Networking'),
('Advisor_Tyler', 'Bio', 'Data Science'),
('Advisor_Ursula', 'CS', 'AI'),
('Advisor_Victor', 'ECE', 'Robotics'),
('Advisor_Wendy', 'ME', 'Networking'),
('Advisor_Xander', 'Bio', 'Data Science'),
('Advisor_Yasmine', 'CS', 'AI'),
('Advisor_Zane', 'ECE', 'Robotics'),
('Advisor_Aaron', 'ME', 'Networking'),
('Advisor_Ben', 'Bio', 'Data Science'),
('Advisor_Carl', 'CS', 'AI'),
('Advisor_Daniel', 'ECE', 'Robotics'),
('Advisor_Ella', 'ME', 'Networking'),
('Advisor_Fiona', 'Bio', 'Data Science'),
('Advisor_George', 'CS', 'AI'),
('Advisor_Hannah', 'ECE', 'Robotics'),
('Advisor_Ian', 'ME', 'Networking'),
('Advisor_Julia', 'Bio', 'Data Science'),
('Advisor_Kyle', 'CS', 'AI'),
('Advisor_Lisa', 'ECE', 'Robotics'),
('Advisor_Mark', 'ME', 'Networking'),
('Advisor_Nina', 'Bio', 'Data Science'),
('Advisor_Oscar', 'CS', 'AI'),
('Advisor_Paula', 'ECE', 'Robotics'),
('Advisor_Quincy', 'ME', 'Networking'),
('Advisor_Rita', 'Bio', 'Data Science'),
('Advisor_Steve', 'CS', 'AI'),
('Advisor_Tina', 'ECE', 'Robotics');

-- Students
INSERT INTO Student (Name, Email, Phone, YOG, Major, Advisor) VALUES
('John Doe', 'johndoe@example.com', '+1234567890', 2024, 'CS', 1),
('Jane Smith', 'janesmith@example.com', '+9876543210', 2025, 'ECE', 2),
('Alex Johnson', 'alexjohnson@example.com', '+5555555555', 2026, 'ME', 3),
('Emily Davis', 'emilydavis@example.com', '+4444444444', 2027, 'Bio', 4),
('Mark Miller', 'markmiller@example.com', '+3333333333', 2024, 'CS', 5),
('Laura Wilson', 'laurawilson@example.com', '+2222222222', 2025, 'ECE', 6),
('Sophia Brown', 'sophiabrown@example.com', '+1111111111', 2026, 'ME', 7),
('Liam Taylor', 'liamtaylor@example.com', '+8888888888', 2027, 'Bio', 8),
('Olivia Moore', 'oliviamoore@example.com', '+9999999999', 2024, 'CS', 9),
('Lucas Anderson', 'lucasanderson@example.com', '+1010101010', 2025, 'ECE', 10),
('Isabella Martinez', 'isabellamartinez@example.com', '+1212121212', 2026, 'ME', 11),
('Mason Jackson', 'masonjackson@example.com', '+1313131313', 2027, 'Bio', 12),
('Charlotte White', 'charlottewhite@example.com', '+1414141414', 2024, 'CS', 13),
('Aiden Harris', 'aidenharris@example.com', '+1515151515', 2025, 'ECE', 14),
('Amelia Clark', 'ameliaclark@example.com', '+1616161616', 2026, 'ME', 15),
('James Rodriguez', 'jamesrodriguez@example.com', '+1717171717', 2027, 'Bio', 16),
('Mia Walker', 'miawalker@example.com', '+1818181818', 2024, 'CS', 17),
('Elijah Lewis', 'elijahlewis@example.com', '+1919191919', 2025, 'ECE', 18),
('Harper Lee', 'harperlee@example.com', '+2020202020', 2026, 'ME', 19),
('Benjamin Young', 'benjaminyoung@example.com', '+2121212121', 2027, 'Bio', 20),
('Ethan King', 'ethanking@example.com', '+2222222222', 2024, 'CS', 21),
('Sebastian Scott', 'sebastianscott@example.com', '+2323232323', 2025, 'ECE', 22),
('Zoe Adams', 'zoeadams@example.com', '+2424242424', 2026, 'ME', 23),
('Ella Nelson', 'ellanelson@example.com', '+2525252525', 2027, 'Bio', 24),
('Jackson Carter', 'jacksoncarter@example.com', '+2626262626', 2024, 'CS', 25),
('Madison Perez', 'madisonperez@example.com', '+2727272727', 2025, 'ECE', 26),
('Samuel Robinson', 'samuelrobinson@example.com', '+2828282828', 2026, 'ME', 27),
('Grace Martinez', 'gracemartinez@example.com', '+2929292929', 2027, 'Bio', 28),
('Henry Clark', 'henryclark@example.com', '+3030303030', 2024, 'CS', 29),
('Victoria Lewis', 'victorialewis@example.com', '+3131313131', 2025, 'ECE', 30),
('Oliver Walker', 'oliverwalker@example.com', '+3232323232', 2026, 'ME', 31),
('Layla Hall', 'laylahall@example.com', '+3333333333', 2027, 'Bio', 32),
('Jack Turner', 'jackturner@example.com', '+3434343434', 2024, 'CS', 33),
('Scarlett Allen', 'scarlettallen@example.com', '+3535353535', 2025, 'ECE', 34),
('Wyatt Lee', 'wyattlee@example.com', '+3636363636', 2026, 'ME', 35),
('Lucy Walker', 'lucywalker@example.com', '+3737373737', 2027, 'Bio', 36),
('Daniel Green', 'danielgreen@example.com', '+3838383838', 2024, 'CS', 37),
('Chloe King', 'chloeking@example.com', '+3939393939', 2025, 'ECE', 38),
('Henry Thompson', 'henrythompson@example.com', '+4040404040', 2026, 'ME', 39),
('Samantha White', 'samanthawhite@example.com', '+4141414141', 2027, 'Bio', 40),
('Gabriel Hernandez', 'gabrielhernandez@example.com', '+4242424242', 2024, 'CS', 41),
('Lily Scott', 'lilyscott@example.com', '+4343434343', 2025, 'ECE', 42),
('David Brown', 'davidbrown@example.com', '+4444444444', 2026, 'ME', 43),
('Avery Green', 'averygreen@example.com', '+4545454545', 2027, 'Bio', 44),
('Sophie Martinez', 'sophiemartinez@example.com', '+4646464646', 2024, 'CS', 45),
('Oliver Carter', 'olivercarter@example.com', '+4747474747', 2025, 'ECE', 46),
('Sebastian Taylor', 'sebastiantaylor@example.com', '+4848484848', 2026, 'ME', 47),
('Maya Walker', 'maya@example.com', '+4949494949', 2027, 'Bio', 48),
('Jacob Collins', 'jacobcollins@example.com', '+5050505050', 2024, 'CS', 49),
('Charlotte White', 'charlottewhite@example.com', '+5151515151', 2025, 'ECE', 50),
('Olivia Garcia', 'oliviagarcia@example.com', '+5242425151', 2027, 'CS/BA', 30),
('Will Jones', 'willjones@example.com', '+8692091238', 2028, 'ME', 32);

-- Resumes
INSERT INTO Resume (StudentId, Content, LastUpdated) VALUES
(1, 'Resume content for John Doe', '2024-01-15'),
(2, 'Resume content for Jane Smith', '2025-03-20'),
(3, 'Resume content for Alex Johnson', '2026-06-10'),
(4, 'Resume content for Emily Davis', '2027-09-25'),
(5, 'Resume content for Mark Miller', '2024-02-10'),
(6, 'Resume content for Laura Wilson', '2025-04-15'),
(7, 'Resume content for Sophia Brown', '2026-07-20'),
(8, 'Resume content for Liam Taylor', '2027-10-05'),
(9, 'Resume content for Olivia Moore', '2024-01-05'),
(10, 'Resume content for Lucas Anderson', '2025-03-30'),
(11, 'Resume content for Isabella Martinez', '2026-06-15'),
(12, 'Resume content for Mason Jackson', '2027-09-10'),
(13, 'Resume content for Charlotte White', '2024-02-25'),
(14, 'Resume content for Aiden Harris', '2025-04-30'),
(15, 'Resume content for Amelia Clark', '2026-07-05'),
(16, 'Resume content for James Rodriguez', '2027-10-25'),
(17, 'Resume content for Mia Walker', '2024-01-10'),
(18, 'Resume content for Elijah Lewis', '2025-03-10'),
(19, 'Resume content for Harper Lee', '2026-06-20'),
(20, 'Resume content for Benjamin Young', '2027-09-15'),
(21, 'Resume content for Ethan King', '2024-02-05'),
(22, 'Resume content for Sebastian Scott', '2025-04-10'),
(23, 'Resume content for Zoe Adams', '2026-07-30'),
(24, 'Resume content for Ella Nelson', '2027-10-15'),
(25, 'Resume content for Jackson Carter', '2024-03-20'),
(26, 'Resume content for Madison Perez', '2025-05-25'),
(27, 'Resume content for Samuel Robinson', '2026-08-10'),
(28, 'Resume content for Grace Martinez', '2027-11-05'),
(29, 'Resume content for Henry Clark', '2024-02-28'),
(30, 'Resume content for Victoria Lewis', '2025-06-15'),
(31, 'Resume content for Oliver Walker', '2026-08-25'),
(32, 'Resume content for Layla Hall', '2027-11-20'),
(33, 'Resume content for Jack Turner', '2024-04-10'),
(34, 'Resume content for Scarlett Allen', '2025-07-05'),
(35, 'Resume content for Wyatt Lee', '2026-09-05'),
(36, 'Resume content for Lucy Walker', '2027-12-01'),
(37, 'Resume content for Daniel Green', '2024-05-25'),
(38, 'Resume content for Chloe King', '2025-08-15'),
(39, 'Resume content for Henry Thompson', '2026-10-20'),
(40, 'Resume content for Samantha White', '2027-12-15'),
(41, 'Resume content for Gabriel Hernandez', '2024-06-01'),
(42, 'Resume content for Lily Scott', '2025-09-20'),
(43, 'Resume content for David Brown', '2026-11-25'),
(44, 'Resume content for Avery Green', '2027-12-30'),
(45, 'Resume content for Sophie Martinez', '2024-07-10'),
(46, 'Resume content for Oliver Carter', '2025-10-15'),
(47, 'Resume content for Sebastian Taylor', '2026-12-10'),
(48, 'Resume content for Maya Walker', '2027-01-05'),
(49, 'Resume content for Jacob Collins', '2024-08-20'),
(50, 'Resume content for Charlotte White', '2025-11-25');

-- Student Searching
INSERT INTO StudentSearching (StudentId, ResumeId, EmployStatus) VALUES
(1, 1, 'Searching'),
(2, 2, 'Not Searching'),
(3, 3, 'Employed'),
(4, 4, 'Searching'),
(5, 5, 'Searching'),
(6, 6, 'Not Searching'),
(7, 7, 'Searching'),
(8, 8, 'Employed'),
(9, 9, 'Searching'),
(10, 10, 'Not Searching'),
(11, 11, 'Searching'),
(12, 12, 'Employed'),
(13, 13, 'Searching'),
(14, 14, 'Not Searching'),
(15, 15, 'Searching'),
(16, 16, 'Employed'),
(17, 17, 'Searching'),
(18, 18, 'Not Searching'),
(19, 19, 'Searching'),
(20, 20, 'Employed'),
(21, 21, 'Searching'),
(22, 22, 'Not Searching'),
(23, 23, 'Searching'),
(24, 24, 'Employed'),
(25, 25, 'Searching'),
(26, 26, 'Not Searching'),
(27, 27, 'Searching'),
(28, 28, 'Employed'),
(29, 29, 'Searching'),
(30, 30, 'Not Searching'),
(31, 31, 'Searching'),
(32, 32, 'Employed'),
(33, 33, 'Searching'),
(34, 34, 'Not Searching'),
(35, 35, 'Searching'),
(36, 36, 'Employed'),
(37, 37, 'Searching'),
(38, 38, 'Not Searching'),
(39, 39, 'Searching'),
(40, 40, 'Employed'),
(41, 41, 'Searching'),
(42, 42, 'Not Searching'),
(43, 43, 'Searching'),
(44, 44, 'Employed'),
(45, 45, 'Searching'),
(46, 46, 'Not Searching'),
(47, 47, 'Searching'),
(48, 48, 'Employed'),
(49, 49, 'Searching'),
(50, 50, 'Not Searching');

-- Student Exploring Fields
INSERT INTO StudentExploringFields (StudentId, Interest) VALUES
(1, 'AI'),
(2, 'Robotics'),
(3, 'Networking'),
(4, 'Data Science'),
(5, 'Machine Learning'),
(6, 'Embedded Systems'),
(7, 'Cybersecurity'),
(8, 'Data Analytics'),
(9, 'Software Development'),
(10, 'Bioinformatics'),
(11, 'Cloud Computing'),
(12, 'Quantum Computing'),
(13, 'Blockchain'),
(14, 'Augmented Reality'),
(15, 'Virtual Reality'),
(16, 'Natural Language Processing'),
(17, 'Autonomous Systems'),
(18, 'IoT'),
(19, 'Deep Learning'),
(20, 'Medical Imaging'),
(21, 'Robotics Process Automation'),
(22, 'Computer Vision'),
(23, 'Digital Health'),
(24, 'AI Ethics'),
(25, 'Big Data'),
(26, 'Network Security'),
(27, 'Cloud Security'),
(28, 'DevOps'),
(29, 'Database Management'),
(30, 'Distributed Systems'),
(31, 'Human-Computer Interaction'),
(32, 'Software Engineering'),
(33, 'Game Development'),
(34, 'E-Commerce Development'),
(35, 'Computational Neuroscience'),
(36, 'Data Mining'),
(37, 'Data Science for Social Good'),
(38, 'Agricultural Technology'),
(39, 'Smart Cities'),
(40, 'Health Informatics'),
(41, 'Biotechnology'),
(42, 'Energy Systems'),
(43, 'Green Technologies'),
(44, 'Autonomous Vehicles'),
(45, 'Blockchain for Healthcare'),
(46, 'Genomic Data Analysis'),
(47, 'Mobile App Development'),
(48, 'Computational Biology'),
(49, 'Speech Recognition'),
(50, 'Smart Manufacturing');

-- Posts
INSERT INTO Posts (StudentId, Content, PostDate, Category) VALUES
(1, 'Announcement: Career fair this Friday!', '2024-02-10', 'Announcement'),
(2, 'Job Opportunity: Full-time software engineer', '2025-04-15', 'Job Opportunity'),
(3, 'Event: Join our coding bootcamp!', '2026-07-20', 'Event'),
(4, 'New research opportunity in Bio field', '2027-10-05', 'Announcement'),
(5, 'Networking Event: Meet industry leaders!', '2024-03-25', 'Event'),
(6, 'Job Opportunity: Junior data scientist', '2025-06-30', 'Job Opportunity'),
(7, 'Webinar: The future of AI in healthcare', '2026-09-15', 'Event'),
(8, 'Call for papers: Machine Learning conference', '2027-12-01', 'Announcement'),
(9, 'Job Opportunity: Cloud developer at CloudX', '2024-04-10', 'Job Opportunity'),
(10, 'Workshop: Introduction to blockchain technology', '2025-07-05', 'Event'),
(11, 'Research funding opportunity for CS majors', '2026-11-01', 'Announcement'),
(12, 'Job Opportunity: AI researcher', '2027-05-10', 'Job Opportunity'),
(13, 'Event: Hackathon on robotics innovation', '2024-05-20', 'Event'),
(14, 'Workshop: Building a career in cybersecurity', '2025-09-25', 'Event'),
(15, 'Career fair this week, don’t miss out!', '2026-02-05', 'Announcement'),
(16, 'Job Opportunity: Data analyst at DataCo', '2027-08-15', 'Job Opportunity'),
(17, 'Event: Coding bootcamp for beginners', '2024-07-12', 'Event'),
(18, 'Networking: Join us for a tech meetup', '2025-08-20', 'Event'),
(19, 'Job Opportunity: Full-stack developer at DevTech', '2026-04-05', 'Job Opportunity'),
(20, 'New bioengineering course available', '2027-03-15', 'Announcement'),
(21, 'Research opportunity: Neural networks project', '2024-10-01', 'Announcement'),
(22, 'Job Opportunity: Robotics engineer at RoboTech', '2025-02-10', 'Job Opportunity'),
(23, 'Event: Virtual reality demo this weekend', '2026-06-12', 'Event'),
(24, 'Research funding for AI startups', '2027-01-10', 'Announcement'),
(25, 'Job Opportunity: Data scientist at InnovateTech', '2024-09-20', 'Job Opportunity'),
(26, 'Event: Digital health conference', '2025-10-10', 'Event'),
(27, 'Job Opportunity: Junior software engineer at SoftTech', '2026-11-25', 'Job Opportunity'),
(28, 'Call for papers: AI ethics symposium', '2027-04-25', 'Announcement'),
(29, 'Event: Smart city innovations conference', '2024-06-15', 'Event'),
(30, 'Job Opportunity: Network engineer at NetTech', '2025-12-01', 'Job Opportunity'),
(31, 'Workshop: Robotics and automation in manufacturing', '2026-08-25', 'Event'),
(32, 'Job Opportunity: Backend developer at CodeSpace', '2027-02-05', 'Job Opportunity'),
(33, 'Event: Smart tech exhibition', '2024-05-15', 'Event'),
(34, 'Job Opportunity: Full-stack developer at CodeForge', '2025-03-20', 'Job Opportunity'),
(35, 'Hackathon: AI for good causes', '2026-10-05', 'Event'),
(36, 'Research: Biotech startups incubator program', '2027-09-01', 'Announcement'),
(37, 'Event: AI workshop on deep learning', '2024-04-25', 'Event'),
(38, 'Job Opportunity: Cybersecurity analyst at SecureNet', '2025-07-30', 'Job Opportunity'),
(39, 'New course: Building decentralized apps', '2026-12-10', 'Announcement'),
(40, 'Job Opportunity: Data scientist at DataHive', '2027-06-20', 'Job Opportunity'),
(41, 'Event: Virtual hackathon for social good', '2024-11-01', 'Event'),
(42, 'Job Opportunity: Software engineer at CodeLab', '2025-01-15', 'Job Opportunity'),
(43, 'Event: AI and data science for healthcare', '2026-03-10', 'Event'),
(44, 'New internship program at TechCorp', '2027-05-25', 'Announcement'),
(45, 'Research opportunity: Next-gen wireless tech', '2024-09-10', 'Announcement'),
(46, 'Job Opportunity: Network administrator at NetWorks', '2025-06-05', 'Job Opportunity'),
(47, 'Workshop: The basics of machine learning', '2026-07-30', 'Event'),
(48, 'Career fair next week, be prepared!', '2027-10-10', 'Announcement'),
(49, 'Job Opportunity: Robotics programmer at RoboWorks', '2024-02-20', 'Job Opportunity'),
(50, 'Event: Build your AI project this weekend', '2025-08-30', 'Event');
-- Companies
INSERT INTO Company (Name, State, City) VALUES
('TechCorp', 'CA', 'Los Angeles'),
('BioTech Inc.', 'NY', 'New York'),
('Code Labs', 'TX', 'Austin'),
('Innovate Health', 'FL', 'Miami'),
('MedTech Solutions', 'CA', 'San Francisco'),
('GreenTech Innovations', 'TX', 'Dallas'),
('CyberSecure', 'CO', 'Denver'),
('HealthPlus', 'FL', 'Orlando'),
('Smart Systems', 'CA', 'San Diego'),
('NextGen Robotics', 'TX', 'Houston'),
('CloudX', 'WA', 'Seattle'),
('FutureTech', 'NY', 'Brooklyn'),
('DataWorks', 'AZ', 'Phoenix'),
('SecureNet', 'TX', 'Austin'),
('RoboTech', 'CO', 'Boulder'),
('BioInnovations', 'MA', 'Boston'),
('TechX', 'NY', 'New York'),
('CloudTech', 'IL', 'Chicago'),
('Quantum Solutions', 'CA', 'Los Angeles'),
('Robotics Pro', 'TX', 'Dallas'),
('SoftTech', 'FL', 'Miami'),
('GreenTech Labs', 'CO', 'Boulder'),
('AeroTech', 'WA', 'Spokane'),
('DeepTech', 'NY', 'Albany'),
('DataForge', 'CA', 'Santa Clara'),
('SmartHealth', 'FL', 'Tampa'),
('AppWorks', 'TX', 'Austin'),
('InnovateLabs', 'CA', 'San Francisco'),
('TechSpace', 'NY', 'New York'),
('Secure Systems', 'VA', 'Arlington'),
('RoboX', 'CA', 'Los Angeles'),
('MachineWorks', 'TX', 'Austin'),
('DataHub', 'CO', 'Denver'),
('BioLabs', 'IL', 'Chicago'),
('CodeForge', 'CA', 'San Francisco'),
('SecureData', 'TX', 'Houston'),
('HealthNet', 'NY', 'New York'),
('IoT Labs', 'CA', 'San Jose'),
('CloudForge', 'WA', 'Seattle'),
('RoboWorks', 'TX', 'Dallas'),
('NextLevel Robotics', 'FL', 'Orlando'),
('GreenWave', 'TX', 'Austin'),
('MachineSpace', 'WA', 'Spokane'),
('CloudXperts', 'CA', 'San Diego'),
('FutureWorks', 'CO', 'Denver'),
('SmartCore', 'NY', 'Brooklyn'),
('DataVenture', 'TX', 'Austin'),
('BioTech Labs', 'MA', 'Boston');


-- Job Listings
INSERT INTO JobListing (Position, CompanyId, Department, Description, Location, PostDate) VALUES
('Software Engineer', 1, 'CS', 'Develop cutting-edge applications', 'Los Angeles', '2024-03-15'),
('Bioinformatics Analyst', 2, 'Bio', 'Analyze genetic data', 'New York', '2025-05-20'),
('Network Engineer', 3, 'ECE', 'Build network infrastructure', 'Austin', '2026-08-25'),
('Health Data Analyst', 4, 'ME', 'Optimize health data management', 'Miami', '2027-11-30'),
('Data Scientist', 5, 'CS', 'Analyze large data sets', 'San Francisco', '2024-04-10'),
('Robotics Engineer', 6, 'Robotics', 'Develop robotic systems', 'Dallas', '2025-09-15'),
('AI Researcher', 7, 'AI', 'Conduct research in AI applications', 'Denver', '2026-02-05'),
('Medical Device Developer', 8, 'Bio', 'Design innovative medical devices', 'Orlando', '2027-10-15'),
('Embedded Systems Engineer', 9, 'ECE', 'Develop embedded software', 'San Diego', '2024-06-20'),
('Blockchain Developer', 10, 'CS', 'Develop decentralized applications', 'Houston', '2025-11-01'),
('Cloud Architect', 11, 'Cloud', 'Design cloud computing systems', 'Seattle', '2026-04-10'),
( 'Data Engineer', 12, 'CS', 'Build scalable data pipelines', 'Brooklyn', '2027-03-25'),
( 'Software Engineer', 13, 'CS', 'Work on software development projects', 'Phoenix', '2024-07-05'),
( 'Security Analyst', 14, 'Security', 'Perform security audits', 'Austin', '2025-02-25'),
( 'Bioinformatics Data Analyst', 15, 'Bio', 'Perform data analysis for biotech', 'Boulder', '2026-09-10'),
( 'Software Tester', 16, 'CS', 'Test and validate software products', 'Los Angeles', '2027-01-15'),
( 'AI Software Developer', 17, 'AI', 'Develop AI-powered applications', 'Chicago', '2024-11-10'),
( 'Network Administrator', 18, 'Networking', 'Manage network systems', 'Dallas', '2025-08-01'),
( 'Robotics Software Engineer', 19, 'Robotics', 'Develop software for robotics systems', 'San Francisco', '2026-12-01'),
( 'Full Stack Developer', 20, 'CS', 'Develop full-stack web applications', 'Houston', '2027-02-10'),
( 'Cybersecurity Specialist', 21, 'Cybersecurity', 'Monitor security threats', 'Chicago', '2024-12-15'),
( 'Bio Data Scientist', 22, 'Bio', 'Analyze biological data', 'New York', '2025-04-25'),
( 'Cloud Security Engineer', 23, 'Cloud', 'Implement cloud security measures', 'Seattle', '2026-05-15'),
( 'Blockchain Engineer', 24, 'CS', 'Work on blockchain technologies', 'Miami', '2027-09-01'),
( 'AI Engineer', 25, 'AI', 'Develop AI models and systems', 'Denver', '2024-05-25'),
( 'Robotic Process Automation Developer', 26, 'RPA', 'Automate business processes', 'Los Angeles', '2025-03-10'),
( 'IoT Engineer', 27, 'IoT', 'Develop IoT systems and networks', 'Austin', '2026-08-20'),
( 'Data Analyst', 28, 'Data', 'Analyze health-related data', 'Tampa', '2027-06-05'),
( 'BioTech Software Engineer', 29, 'Bio', 'Develop software for biotech applications', 'San Francisco', '2024-09-30'),
( 'Game Developer', 30, 'Gaming', 'Develop gaming applications', 'Chicago', '2025-10-01'),
( 'Mobile App Developer', 31, 'CS', 'Develop mobile applications', 'Dallas', '2026-07-25'),
( 'Full Stack Web Developer', 32, 'Web', 'Develop full-stack web apps', 'Phoenix', '2027-02-20'),
( 'Tech Consultant', 33, 'Consulting', 'Provide tech solutions to clients', 'Miami', '2024-11-05'),
( 'Health Data Analyst', 34, 'Health', 'Analyze health data for innovation', 'Boulder', '2025-04-05'),
( 'Software Engineer', 35, 'CS', 'Develop software solutions', 'San Francisco', '2026-09-20'),
( 'Machine Learning Engineer', 36, 'ML', 'Develop ML models and systems', 'Tampa', '2027-08-30'),
( 'Cybersecurity Engineer', 37, 'Security', 'Protect networks and data', 'Chicago', '2024-06-05'),
( 'AI Software Developer', 38, 'AI', 'Create AI-powered solutions', 'San Diego', '2025-02-15'),
( 'Embedded Developer', 39, 'Robotics', 'Develop embedded software for robots', 'Austin', '2026-03-15'),
( 'Network Support Specialist', 40, 'Networking', 'Support network systems', 'Orlando', '2027-07-25'),
( 'Blockchain Architect', 41, 'CS', 'Design blockchain-based solutions', 'Dallas', '2024-10-20'),
( 'Software Engineer Intern', 42, 'CS', 'Assist in software development projects', 'Los Angeles', '2025-05-10'),
( 'Research Scientist', 43, 'Research', 'Conduct AI research for healthcare', 'Miami', '2026-04-25'),
( 'Full Stack Developer Intern', 44, 'CS', 'Internship in web development', 'Seattle', '2027-01-05'),
( 'Data Engineer', 45, 'CS', 'Build and maintain data pipelines', 'Phoenix', '2024-07-15'),
( 'Embedded Systems Architect', 46, 'Embedded', 'Design embedded systems', 'Houston', '2025-06-01'),
( 'IoT Developer', 47, 'IoT', 'Develop IoT applications', 'Denver', '2026-02-10'),
( 'Machine Learning Specialist', 48, 'ML', 'Work on advanced machine learning models', 'San Diego', '2027-11-20'),
( 'Game Developer Intern', 49, 'Gaming', 'Assist in the development of games', 'Chicago', '2024-11-30'),
( 'DevOps Engineer', 50, 'DevOps', 'Manage deployment pipelines', 'Seattle', '2025-01-10');

-- Notifications
INSERT INTO Notification (PostId, JobId, StudentId, TimeStamp, Content) VALUES
(1, 1, 1, NOW(), 'New job listing for Software Engineer at TechCorp'),
(2, 2, 2, NOW(), 'New research position available at BioTech Inc.'),
(3, 3, 3, NOW(), 'Join our coding bootcamp in Austin!'),
(4, 4, 4, NOW(), 'Career fair this Friday - do not miss it!'),
(5, 5, 5, NOW(), 'Join the upcoming networking event in San Francisco!'),
(6, 6, 6, NOW(), 'New job opening for Junior Data Scientist at DataWorks'),
(7, 7, 7, NOW(), 'AI healthcare workshop tomorrow!'),
(8, 8, 8, NOW(), 'Important: Call for papers for Machine Learning Research'),
(9, 9, 9, NOW(), 'Software engineer job opening at CloudX'),
(10, 10, 10, NOW(), 'Blockchain developer position at Code Forge!'),
(11, 11, 11, NOW(), 'Job opening: Cloud architect at CloudXperts'),
(12, 12, 12, NOW(), 'Data engineer position at DataForge'),
(13, 13, 13, NOW(), 'Join the robotics research hackathon this weekend'),
(14, 14, 14, NOW(), 'Security analyst role at SecureNet is open'),
(15, 15, 15, NOW(), 'Bioinformatics data analyst needed at BioTech Labs'),
(16, 16, 16, NOW(), 'Software tester position open at CodeForge'),
(17, 17, 17, NOW(), 'AI Software Developer position at DataHub'),
(18, 18, 18, NOW(), 'Join the network engineering team at CloudX!'),
(19, 19, 19, NOW(), 'Robotics Software Engineer at Robotics Pro'),
(20, 20, 20, NOW(), 'Backend Developer job at SmartSystems'),
(21, 21, 21, NOW(), 'Cybersecurity Specialist role available at SecureData'),
(22, 22, 22, NOW(), 'Bio Data Scientist job at BioHealth Labs'),
(23, 23, 23, NOW(), 'Cloud security engineer needed at CyberSecure'),
(24, 24, 24, NOW(), 'Blockchain developer opportunity at TechX'),
(25, 25, 25, NOW(), 'AI engineer job at DataMind'),
(26, 26, 26, NOW(), 'Robotic Process Automation Developer needed'),
(27, 27, 27, NOW(), 'IoT Engineer needed at FutureTech'),
(28, 28, 28, NOW(), 'Data Analyst role at HealthPlus'),
(29, 29, 29, NOW(), 'BioTech software engineer opportunity at BioLab'),
(30, 30, 30, NOW(), 'Game developer position open at GameWorks'),
(31, 31, 31, NOW(), 'Mobile App Developer needed at AppWorks'),
(32, 32, 32, NOW(), 'Full Stack Web Developer Intern at CodeForge'),
(33, 33, 33, NOW(), 'Join us for the upcoming career fair at SmartCore'),
(34, 34, 34, NOW(), 'Research funding opportunities available'),
(35, 35, 35, NOW(), 'Software Engineer role at InnovateHealth'),
(36, 36, 36, NOW(), 'Machine learning job opening at Quantum'),
(37, 37, 37, NOW(), 'Cybersecurity engineer needed at Secure Systems'),
(38, 38, 38, NOW(), 'AI Software Developer opening at DeepTech'),
(39, 39, 39, NOW(), 'Embedded developer job at TechX'),
(40, 40, 40, NOW(), 'Network Support Specialist role available'),
(41, 41, 41, NOW(), 'Blockchain architect position at TechCorp'),
(42, 42, 42, NOW(), 'Software engineering internship available'),
(43, 43, 43, NOW(), 'Research scientist position open at BioLab'),
(44, 44, 44, NOW(), 'Full-stack web developer intern opportunity'),
(45, 45, 45, NOW(), 'Data engineer position at DataWorks'),
(46, 46, 46, NOW(), 'Embedded systems architect needed at SecureData'),
(47, 47, 47, NOW(), 'IoT developer job at TechSpace'),
(48, 48, 48, NOW(), 'Machine learning specialist position available'),
(49, 49, 49, NOW(), 'Game Developer Intern at FutureGames'),
(50, 50, 50, NOW(), 'DevOps engineer role at CloudTech');

-- Employers
INSERT INTO Employer (Name, Email, Phone, CompanyId) VALUES
('Sarah Johnson', 'sarahj@example.com', '+12125551212', 1),
('Mark Taylor', 'markt@example.com', '+14155551234', 2),
('Linda Green', 'lindag@example.com', '+16125551256', 3),
('Daniel Lee', 'daniel@example.com', '+18155551278', 4),
('James Smith', 'james.smith@techcorp.com', '+19155551489', 5),
('Anna Lopez', 'anna.lopez@roboticsnext.com', '+14175554812', 6),
('George White', 'george.white@greenwave.com', '+16175552112', 7),
('Rachel Clark', 'rachel.clark@machinespace.com', '+18175553124', 8),
('Benjamin Miller', 'ben.miller@cloudxperts.com', '+14175553235', 9),
('Sophia Taylor', 'sophia.taylor@futureworks.com', '+12175556345', 10),
('William Evans', 'william.evans@smartcore.com', '+16175557899', 11),
('Emma Robinson', 'emma.robinson@dataventure.com', '+19175558912', 12),
('Daniela Garcia', 'daniela.garcia@biotechlabs.com', '+12175559523', 13),
('Matthew Lewis', 'matthew.lewis@biohealthtech.com', '+14175561034', 14),
('Olivia Harris', 'olivia.harris@cloudsecurity.com', '+16175561234', 15),
('Noah Allen', 'noah.allen@blockchainforge.com', '+18175562345', 16),
('Isabella Wright', 'isabella.wright@datascienceworks.com', '+12175563567', 17),
('Lucas Scott', 'lucas.scott@cloudsystems.com', '+14175564878', 18),
('Charlotte Young', 'charlotte.young@healthsolutions.com', '+16175565489', 19),
('Ethan King', 'ethan.king@securedata.com', '+18175566590', 20),
('Amelia Green', 'amelia.green@techventures.com', '+12175567701', 21),
('Jackson Nelson', 'jackson.nelson@blockchainlabs.com', '+14175568802', 22),
('Mason Carter', 'mason.carter@quantumtech.com', '+16175569413', 23),
('Ava Mitchell', 'ava.mitchell@roboticspro.com', '+18175570624', 24),
('Liam Perez', 'liam.perez@smartcityinnovations.com', '+12175571035', 25),
('Mia Hall', 'mia.hall@securecloudsystems.com', '+14175572346', 26),
('Evan White', 'evan.white@healthplus.com', '+16175573257', 27),
('Jackson Wright', 'jackson.wright@iotexperts.com', '+18175574068', 28),
('Avery Adams', 'avery.adams@cloudmax.com', '+12175575179', 29),
('Chloe Brown', 'chloe.brown@fullstacksolutions.com', '+14175576490', 30),
('Sebastian Lee', 'sebastian.lee@roboticscreators.com', '+16175577901', 31),
('Harper Harris', 'harper.harris@aiinnovations.com', '+18175578812', 32),
('Jack Carter', 'jack.carter@cloudtechsolutions.com', '+12175579523', 33),
('Lily Thomas', 'lily.thomas@iotconnect.com', '+14175580834', 34),
('Leo Wilson', 'leo.wilson@datasciencegen.com', '+16175581845', 35),
('Grace Evans', 'grace.evans@nextgenai.com', '+18175582756', 36),
('Jayden King', 'jayden.king@biotechpro.com', '+12175583567', 37),
('Zoe Harris', 'zoe.harris@roboengineering.com', '+14175584878', 38),
('Samuel Miller', 'samuel.miller@techspace.com', '+16175585889', 39),
('Daniel Young', 'daniel.young@techshift.com', '+18175586890', 40),
('Ella Moore', 'ella.moore@blockchaininnovators.com', '+12175587501', 41),
('Michael Brown', 'michael.brown@securevision.com', '+14175588412', 42),
('Grace Clark', 'grace.clark@datasphere.com', '+16175589523', 43),
('David Thomas', 'david.thomas@cloudsolutionsinc.com', '+18175590534', 44),
('Chloe Miller', 'chloe.miller@iotventures.com', '+12175591245', 45),
('Samuel Perez', 'samuel.perez@biotechresearchers.com', '+14175592156', 46),
('Jack Evans', 'jack.evans@cybersecurenetworks.com', '+16175593467', 47),
('Lily Johnson', 'lily.johnson@techsolutionsgroup.com', '+18175594578', 48),
('Wyatt Wilson', 'wyatt.wilson@airobotics.com', '+12175595389', 49),
('Mason Taylor', 'mason.taylor@dataforge.com', '+14175596290', 50),
('John Doe', 'doe.john@dataforge.com', '+14175496290', 44);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
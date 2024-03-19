-- Drop database
DROP DATABASE IF EXISTS ProbationSystem;

-- Create database
CREATE DATABASE ProbationSystem;

-- Select database
USE ProbationSystem;

-- Create tables
CREATE TABLE studentMaster (
	studentID VARCHAR(7) PRIMARY KEY,
	studentFirstName VARCHAR(100) NOT NULL,
	studentSurname VARCHAR(100) NOT NULL, 
	studentEmail VARCHAR(100) NOT NULL,
	studentSchool VARCHAR(100) NOT NULL,
	studentProgramme VARCHAR(100) NOT NULL
);

CREATE TABLE moduleMaster (
	moduleCode VARCHAR(7) PRIMARY KEY,
    moduleName VARCHAR(100),
	numOfCredits INT NOT NULL
);

CREATE TABLE letterGrades (
    letterGrade char(2) PRIMARY KEY,
    gradeValue decimal(3, 2) NOT NULL
);

CREATE TABLE moduleDetails (
	moduleCode VARCHAR(7),
	moduleYear YEAR NOT NULL,
	semester VARCHAR(1) NOT NULL,
	studentID VARCHAR(7),
	grade char(2) NOT NULL,
	FOREIGN KEY (studentID) REFERENCES studentMaster(studentID),
	FOREIGN KEY (moduleCode) REFERENCES moduleMaster(moduleCode),
    FOREIGN KEY (grade) REFERENCES letterGrades(letterGrade)
);

-- Insert data
INSERT INTO studentMaster (studentID, studentFirstName, studentSurname, studentEmail, studentSchool, studentProgramme) VALUES
('1903372', 'Alicia', 'Simpson', 'alsimpson45@yahoo.com', 'School of Business Administration', 'Bachelor of Business Administration '),
('1907632', 'Victoria', 'Hughs', 'vickyhughs@gmail.com', 'Faculty of Law', 'Bachelor of Laws'),
('2001472', 'Philip', 'Smith', 'philsmith@gmail.com', 'School of Oral Health Sciences', 'Bachelor of Science in Dental Hygiene'),
('2007621', 'Daniel', 'Brown', 'danielbrown@outlook.com', 'School of Building and Land Management', 'Bachelor of Science in Land Surveying and Geographic Information Sciences'),
('2022675', 'John', 'Doe', 'johnnydoe23@gmail.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2102761', 'Maya', 'Bishop', 'mayabish@yahoo.com', 'School of Computing and Information Technology', 'Bachelor of Science in Computer Networking and Security'),
('2102762', 'Emma', 'Johnson', 'emmajohnson@gmail.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2102763', 'Michael', 'Williams', 'michaelwilliams@outlook.com', 'Faculty of Law', 'Bachelor of Laws'),
('2102764', 'Sophia', 'Brown', 'sophiabrown@gmail.com', 'School of Oral Health Sciences', 'Bachelor of Science in Dental Hygiene'),
('2102765', 'James', 'Miller', 'jamesmiller@gmail.com', 'School of Building and Land Management', 'Bachelor of Science in Land Surveying and Geographic Information Sciences'),
('2102766', 'Olivia', 'Davis', 'oliviadavis@gmail.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2102767', 'William', 'Garcia', 'williamgarcia@outlook.com', 'School of Computing and Information Technology', 'Bachelor of Science in Computer Networking and Security'),
('2102768', 'Amelia', 'Rodriguez', 'ameliarodriguez@icloud.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2102769', 'Benjamin', 'Martinez', 'benjaminmartinez@outlook.com', 'Faculty of Law', 'Bachelor of Laws'),
('2102770', 'Isabella', 'Lopez', 'isabellalopez@outlook.com', 'School of Oral Health Sciences', 'Bachelor of Science in Dental Hygiene'),
('2102771', 'Jacob', 'Hernandez', 'jacobhernandez@icloud.com', 'School of Building and Land Management', 'Bachelor of Science in Land Surveying and Geographic Information Sciences'),
('2102772', 'Mia', 'Gonzalez', 'miagonzalez@outlook.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2102773', 'Ethan', 'Wilson', 'ethanwilson@outlook.com', 'School of Computing and Information Technology', 'Bachelor of Science in Computer Networking and Security'),
('2102774', 'Charlotte', 'Anderson', 'charlotteanderson@icloud.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2102775', 'Alexander', 'Taylor', 'alexandertaylor@outlook.com', 'Faculty of Law', 'Bachelor of Laws'),
('2102776', 'Harper', 'Thomas', 'harperthomas@protonmail.com', 'School of Oral Health Sciences', 'Bachelor of Science in Dental Hygiene'),
('2102777', 'Daniel', 'Hernandez', 'danielhernandez@icloud.com', 'School of Building and Land Management', 'Bachelor of Science in Land Surveying and Geographic Information Sciences'),
('2102778', 'Madison', 'Moore', 'madisonmoore@icloud.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2102779', 'Aiden', 'Jackson', 'aidenjackson@protonmail.com', 'School of Computing and Information Technology', 'Bachelor of Science in Computer Networking and Security'),
('2102780', 'Liam', 'White', 'liamwhite@protonmail.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2102781', 'Evelyn', 'Harris', 'evelynharris@icloud.com', 'Faculty of Law', 'Bachelor of Laws'),
('2102782', 'Ella', 'Martin', 'ellamartin@gmail.com', 'School of Oral Health Sciences', 'Bachelor of Science in Dental Hygiene'),
('2102783', 'Carter', 'Thompson', 'carterthompson@gmail.com', 'School of Building and Land Management', 'Bachelor of Science in Land Surveying and Geographic Information Sciences'),
('2102784', 'Scarlett', 'Garcia', 'scarlettgarcia@gmail.com', 'School of Business Administration', 'Bachelor of Business Administration'),
('2202001', 'Emma', 'Johnson', 'emma.johnson@gmail.com', 'School of Health Sciences', 'Nursing'),
('2202002', 'Daniel', 'Martinez', 'daniel.martinez@outlook.com', 'School of Business', 'Marketing'),
('2202003', 'Sophia', 'Garcia', 'sophia.garcia@icloud.com', 'School of Engineering', 'Civil Engineering'),
('2202004', 'Aiden', 'Brown', 'aiden.brown@protonmail.com', 'School of Computing and Information Technology', 'Computer Science'),
('2202005', 'Olivia', 'Jones', 'olivia.jones@gmail.com', 'School of Health Sciences', 'Physical Therapy'),
('2202006', 'William', 'Davis', 'william.davis@outlook.com', 'School of Business', 'Accounting'),
('2202007', 'Isabella', 'Martinez', 'isabella.martinez@icloud.com', 'School of Engineering', 'Mechanical Engineering'),
('2202008', 'James', 'Lopez', 'james.lopez@protonmail.com', 'School of Computing and Information Technology', 'Information Technology'),
('2202009', 'Ethan', 'Wilson', 'ethan.wilson@gmail.com', 'School of Health Sciences', 'Nursing'),
('2202010', 'Amelia', 'Anderson', 'amelia.anderson@outlook.com', 'School of Business', 'Finance'),
('2202011', 'Liam', 'Rodriguez', 'liam.rodriguez@icloud.com', 'School of Engineering', 'Electrical Engineering'),
('2202012', 'Mia', 'Martinez', 'mia.martinez@protonmail.com', 'School of Computing and Information Technology', 'Computer Science'),
('2202013', 'Noah', 'Taylor', 'noah.taylor@gmail.com', 'School of Health Sciences', 'Physical Therapy'),
('2202014', 'Charlotte', 'Garcia', 'charlotte.garcia@outlook.com', 'School of Business', 'Marketing'),
('2202015', 'Sophia', 'Rodriguez', 'sophia.rodriguez@icloud.com', 'School of Engineering', 'Civil Engineering'),
('2202016', 'Logan', 'Hernandez', 'logan.hernandez@protonmail.com', 'School of Computing and Information Technology', 'Information Technology'),
('2202017', 'Oliver', 'Gonzalez', 'oliver.gonzalez@gmail.com', 'School of Health Sciences', 'Nursing'),
('2202018', 'Ava', 'Lopez', 'ava.lopez@outlook.com', 'School of Business', 'Accounting'),
('2202019', 'Elijah', 'Perez', 'elijah.perez@icloud.com', 'School of Engineering', 'Mechanical Engineering'),
('2202020', 'Harper', 'Lee', 'harper.lee@protonmail.com', 'School of Computing and Information Technology', 'Computer Science');

INSERT INTO moduleMaster (moduleCode, moduleName, numOfCredits) VALUES
('COM1024', 'Academic Literacy for Undergraduates', 3),
('ANP1001', 'Anatomy and Physiology', 4),
('MAT2003', 'Calculus I', 3),
('MAT1044', 'College Mathematics 1A', 4),
('MAT1047', 'College Mathematics 1B', 4),
('CMP1005', 'Computer Logic and Digital Design', 3),
('CMP1026', 'Computer Networks 1', 3),
('LLB1006', 'Constitutional Law', 3),
('LLB1002', 'Criminal Law I', 3),
('COM2016', 'Critical Thinking, Reading and Writing', 3),
('CMP2018', 'Database Design', 3),
('DHT1012', 'Dental Hygiene Theory and Techniques 1', 4),
('MAT1008', 'Discrete Mathematics', 3),
('ENS3001', 'Environmental Studies', 3),
('MIB1001', 'General Microbiology', 3),
('HPS1001', 'Health Psychology', 3),
('IMM2002', 'Immunology', 2),
('INT1001', 'Information Technology', 3),
('COT1019', 'Introduction to Construction Technology', 3),
('MAN1006', 'Introduction to Management', 3),
('CIT4024', 'IT Project Management', 3),
('LLB1001', 'Law and Legal Systems ', 3),
('LLB1004', 'Law of Contract I', 3),
('LLB1008', 'Law of Tort I', 3),
('LLB1003', 'Legal Methods, Research and Writing', 3),
('OHP1021', 'Oral Health Promotion 1', 2),
('PHS1019', 'Physics for Computer Science', 4),
('SGI1001', 'Plane Surveying I', 4),
('PSY1002', 'Introduction to Psychology', 3),
('SGI1005', 'Surveying Practicum I', 3);

INSERT INTO LetterGrades (letterGrade, gradeValue) VALUES
('A+', 4.3),
('A', 4.0),
('A-', 3.67),
('B+', 3.33),
('B', 3.0),
('B-', 2.67),
('C+', 2.33),
('C', 2.29),
('D+', 1.67),
('D', 1.3),
('E', 0.86),
('U', 0.0);

INSERT INTO moduleDetails (moduleCode, moduleYear, semester, studentID, grade) VALUES
('COM1024', 2019, '1', '1903372', 'A+'),
('MAT1044', 2019, '1', '1903372', 'A-'),
('INT1001', 2019, '1', '1903372', 'B'),
('MAN1006', 2019, '1', '1903372', 'B+'),
('ENS3001', 2019, '2', '1903372', 'A-'),
('COM2016', 2019, '2', '1903372', 'A+'),
('CIT4024', 2019, '2', '1903372', 'B+'),
('MAT2003', 2019, '2', '1903372', 'A+'),
('COM1024', 2020, '1', '2001472', 'A'),
('ANP1001', 2020, '1', '2001472', 'A-'),
('HPS1001', 2020, '1', '2001472', 'A+'),
('MIB1001', 2020, '1', '2001472', 'B+'),
('COM2016', 2021, '2', '2001472', 'A'),
('MAT1044', 2021, '2', '2001472', 'A-'),
('IMM2002', 2021, '2', '2001472', 'B+'),
('INT1001', 2021, '2', '2001472', 'A'),
('COM1024', 2019, '1', '1907632', 'A'),
('MAT1044', 2019, '1', '1907632', 'A-'),
('LLB1002', 2019, '1', '1907632', 'A+'),
('LLB1004', 2019, '1', '1907632', 'A'),
('LLB1008', 2019, '1', '1907632', 'A+'),
('COM1024', 2019, '1', '2102762', 'A-'),
('MAT1044', 2019, '1', '2102762', 'B'),
('CMP2018', 2019, '1', '2102762', 'A-'),
('MAN1006', 2019, '1', '2102762', 'A'),
('ENS3001', 2019, '2', '2102762', 'A+'),
('COM2016', 2020, '2', '2102762', 'A-'),
('CIT4024', 2020, '2', '2102762', 'A'),
('MAT2003', 2020, '2', '2102762', 'A-'),
('COM1024', 2020, '1', '2102763', 'A-'),
('ANP1001', 2020, '1', '2102763', 'A'),
('HPS1001', 2020, '1', '2102763', 'A-'),
('MIB1001', 2020, '1', '2102763', 'A'),
('COM2016', 2021, '2', '2102763', 'A'),
('MAT1044', 2021, '2', '2102763', 'A+'),
('IMM2002', 2021, '2', '2102763', 'B-'),
('INT1001', 2021, '2', '2102763', 'A'),
('COM1024', 2019, '1', '2102764', 'A'),
('MAT1044', 2019, '1', '2102764', 'A-'),
('LLB1002', 2019, '1', '2102764', 'A+'),
('LLB1004', 2019, '1', '2102764', 'A'),
('LLB1008', 2019, '1', '2102764', 'A+'),
('COM1024', 2019, '1', '2102765', 'B'),
('MAT1044', 2019, '1', '2102765', 'B-'),
('CMP2018', 2019, '1', '2102765', 'A-'),
('MAN1006', 2019, '1', '2102765', 'A'),
('ENS3001', 2019, '2', '2102765', 'A'),
('COM2016', 2020, '2', '2102765', 'A-'),
('CIT4024', 2020, '2', '2102765', 'B'),
('MAT2003', 2020, '2', '2102765', 'A-'),
('COM1024', 2020, '1', '2102766', 'A'),
('ANP1001', 2020, '1', '2102766', 'A+'),
('HPS1001', 2020, '1', '2102766', 'A-'),
('MIB1001', 2020, '1', '2102766', 'A-'),
('COM2016', 2021, '2', '2102766', 'A'),
('MAT1044', 2021, '2', '2102766', 'A+'),
('IMM2002', 2021, '2', '2102766', 'B-'),
('INT1001', 2021, '2', '2102766', 'A'),
('COM1024', 2019, '1', '2102767', 'A-'),
('MAT1044', 2019, '1', '2102767', 'B-'),
('LLB1002', 2019, '1', '2102767', 'A-'),
('LLB1004', 2019, '1', '2102767', 'A'),
('LLB1008', 2019, '1', '2102767', 'A-'),
('COM1024', 2019, '1', '2102778', 'A-'),
('MAT1044', 2019, '1', '2102778', 'B'),
('CMP2018', 2019, '1', '2102778', 'A-'),
('MAN1006', 2019, '1', '2102778', 'A'),
('ENS3001', 2019, '2', '2102778', 'A+'),
('COM2016', 2020, '2', '2102778', 'A-'),
('CIT4024', 2020, '2', '2102778', 'U'),
('MAT2003', 2020, '2', '2102778', 'A-'),
('COM1024', 2020, '1', '2102779', 'A-'),
('ANP1001', 2020, '1', '2102779', 'A'),
('HPS1001', 2020, '1', '2102779', 'A-'),
('MIB1001', 2020, '1', '2102779', 'A'),
('COM2016', 2021, '2', '2102779', 'A'),
('MAT1044', 2021, '2', '2102779', 'A+'),
('IMM2002', 2021, '2', '2102779', 'B-'),
('INT1001', 2021, '2', '2102779', 'A'),
('COM1024', 2019, '1', '2102780', 'A'),
('MAT1044', 2019, '1', '2102780', 'A-'),
('LLB1004', 2019, '1', '2102780', 'A'),
('LLB1008', 2019, '1', '2102780', 'A+'),
('COM1024', 2019, '1', '2102781', 'B-'),
('MAT1044', 2019, '1', '2102781', 'C'),
('CMP2018', 2019, '1', '2102781', 'A-'),
('MAN1006', 2019, '1', '2102781', 'A'),
('ENS3001', 2019, '2', '2102781', 'A'),
('COM2016', 2020, '2', '2102781', 'A+'),
('CIT4024', 2020, '2', '2102781', 'B-'),
('MAT2003', 2020, '2', '2102781', 'A-'),
('COM1024', 2020, '1', '2102782', 'A-'),
('ANP1001', 2020, '1', '2102782', 'A'),
('HPS1001', 2020, '1', '2102782', 'A-'),
('MIB1001', 2020, '1', '2102782', 'A-'),
('COM2016', 2021, '2', '2102782', 'A-'),
('MAT1044', 2021, '2', '2102782', 'A'),
('IMM2002', 2021, '2', '2102782', 'B-'),
('INT1001', 2021, '2', '2102782', 'A'),
('COM1024', 2019, '1', '2102783', 'A-'),
('MAT1044', 2019, '1', '2102783', 'B-'),
('LLB1002', 2019, '1', '2102783', 'A-'),
('LLB1004', 2019, '1', '2102783', 'A'),
('LLB1008', 2019, '1', '2102783', 'A-'),
('COM1024', 2019, '1', '2102784', 'B-'),
('MAT1044', 2019, '1', '2102784', 'C'),
('CMP2018', 2019, '1', '2102784', 'A-'),
('MAN1006', 2019, '1', '2102784', 'A'),
('ENS3001', 2019, '2', '2102784', 'A+'),
('COM2016', 2020, '2', '2102784', 'U'),
('CIT4024', 2020, '2', '2102784', 'E'),
('MAT2003', 2020, '2', '2102784', 'A-'),
('COM1024', 2021, '1', '2102765', 'A'),
('MAT1044', 2021, '1', '2102765', 'A-'),
('PHS1019', 2021, '1', '2102765', 'B+'),
('CMP1026', 2021, '1', '2102765', 'B'),
('MIB1001', 2021, '1', '2102765', 'B-'),
('COM1024', 2021, '1', '2102766', 'A'),
('MAT1044', 2021, '1', '2102766', 'A-'),
('PHS1019', 2021, '1', '2102766', 'B+'),
('CMP1026', 2021, '1', '2102766', 'B'),
('MIB1001', 2021, '1', '2102766', 'B-'),
('COM1024', 2021, '1', '2102767', 'A'),
('MAT1044', 2021, '1', '2102767', 'A-'),
('PHS1019', 2021, '1', '2102767', 'B+'),
('CMP1026', 2021, '1', '2102767', 'B'),
('MIB1001', 2021, '1', '2102767', 'B-'),
('COM1024', 2021, '1', '2102768', 'A'),
('MAT1044', 2021, '1', '2102768', 'A-'),
('PHS1019', 2021, '1', '2102768', 'B+'),
('CMP1026', 2021, '1', '2102768', 'B'),
('MIB1001', 2021, '1', '2102768', 'B-'),
('COM1024', 2021, '1', '2102769', 'A'),
('MAT1044', 2021, '1', '2102769', 'A-'),
('PHS1019', 2021, '1', '2102769', 'B+'),
('CMP1026', 2021, '1', '2102769', 'B'),
('MIB1001', 2021, '1', '2102769', 'B-'),
('COM1024', 2021, '1', '2102770', 'A'),
('MAT1044', 2021, '1', '2102770', 'A-'),
('PHS1019', 2021, '1', '2102770', 'B+'),
('CMP1026', 2021, '1', '2102770', 'B'),
('MIB1001', 2021, '1', '2102770', 'B-'),
('COM1024', 2021, '1', '2102771', 'A'),
('MAT1044', 2021, '1', '2102771', 'A-'),
('PHS1019', 2021, '1', '2102771', 'B+'),
('CMP1026', 2021, '1', '2102771', 'B'),
('MIB1001', 2021, '1', '2102771', 'B-'),
('COM1024', 2021, '1', '2102772', 'A'),
('MAT1044', 2021, '1', '2102772', 'A-'),
('PHS1019', 2021, '1', '2102772', 'B+'),
('CMP1026', 2021, '1', '2102772', 'B'),
('MIB1001', 2021, '1', '2102772', 'B-'),
('COM1024', 2021, '1', '2102773', 'A'),
('MAT1044', 2021, '1', '2102773', 'A-'),
('PHS1019', 2021, '1', '2102773', 'B+'),
('CMP1026', 2021, '1', '2102773', 'B'),
('MIB1001', 2021, '1', '2102773', 'B-'),
('COM1024', 2021, '1', '2102774', 'A'),
('MAT1044', 2021, '1', '2102774', 'A-'),
('PHS1019', 2021, '1', '2102774', 'B+'),
('CMP1026', 2021, '1', '2102774', 'B'),
('MIB1001', 2021, '1', '2102774', 'B-'),
('COM1024', 2021, '1', '2102775', 'A'),
('MAT1044', 2021, '1', '2102775', 'A-'),
('PHS1019', 2021, '1', '2102775', 'B+'),
('CMP1026', 2021, '1', '2102775', 'B'),
('MIB1001', 2021, '1', '2102775', 'B-'),
('COM1024', 2021, '1', '2102776', 'A'),
('MAT1044', 2021, '1', '2102776', 'A-'),
('PHS1019', 2021, '1', '2102776', 'B+'),
('CMP1026', 2021, '1', '2102776', 'B'),
('MIB1001', 2021, '1', '2102776', 'B-'),
('COM1024', 2019, '1', '1903372', 'A+'),
('MAT1044', 2019, '1', '1903372', 'A-'),
('INT1001', 2019, '1', '1903372', 'B'),
('MAN1006', 2019, '1', '1903372', 'B+'),
('ENS3001', 2019, '1', '1903372', 'U'),
('COM1024', 2019, '1', '1907632', 'A'),
('MAT1044', 2019, '1', '1907632', 'A-'),
('LLB1002', 2019, '1', '1907632', 'A+'),
('LLB1004', 2019, '1', '1907632', 'A'),
('LLB1008', 2019, '1', '1907632', 'A+'),
('COM1024', 2020, '1', '2001472', 'A'),
('ANP1001', 2020, '1', '2001472', 'A-'),
('HPS1001', 2020, '1', '2001472', 'A+'),
('MIB1001', 2020, '1', '2001472', 'B+'),
('COM1024', 2020, '1', '2007621', 'B'),
('MAT1044', 2020, '1', '2007621', 'B-'),
('LLB1002', 2020, '1', '2007621', 'C+'),
('LLB1004', 2020, '1', '2007621', 'A-'),
('LLB1008', 2020, '1', '2007621', 'B+'),
('COM1024', 2020, '1', '2022675', 'A-'),
('MAT1044', 2020, '1', '2022675', 'B+'),
('LLB1002', 2020, '1', '2022675', 'A'),
('LLB1004', 2020, '1', '2022675', 'A-'),
('LLB1008', 2020, '1', '2022675', 'B'),
('COM1024', 2021, '1', '2102761', 'B+'),
('MAT1044', 2021, '1', '2102761', 'B'),
('LLB1002', 2021, '1', '2102761', 'A-'),
('LLB1004', 2021, '1', '2102761', 'B+'),
('LLB1008', 2021, '1', '2102761', 'A'),
('COM1024', 2021, '1', '2102762', 'A'),
('MAT1044', 2021, '1', '2102762', 'A+'),
('LLB1002', 2021, '1', '2102762', 'A-'),
('LLB1004', 2021, '1', '2102762', 'A'),
('LLB1008', 2021, '1', '2102762', 'A+'),
('COM1024', 2021, '1', '2102763', 'B'),
('MAT1044', 2021, '1', '2102763', 'B-'),
('LLB1002', 2021, '1', '2102763', 'C+'),
('LLB1004', 2021, '1', '2102763', 'B'),
('LLB1008', 2021, '1', '2102763', 'B+'),
('COM1024', 2021, '1', '2102764', 'C'),
('MAT1044', 2021, '1', '2102764', 'B-'),
('LLB1002', 2021, '1', '2102764', 'A-'),
('LLB1004', 2021, '1', '2102764', 'C+'),
('LLB1008', 2021, '1', '2102764', 'B'),
('COM1024', 2021, '1', '2102781', 'A'),
('MAT1044', 2021, '1', '2102781', 'A-'),
('PHS1019', 2021, '1', '2102781', 'B+'),
('CMP1026', 2021, '1', '2102781', 'B'),
('MIB1001', 2021, '1', '2102781', 'B-'),
('COM1024', 2021, '1', '2102782', 'A'),
('MAT1044', 2021, '1', '2102782', 'A-'),
('PHS1019', 2021, '1', '2102782', 'B+'),
('CMP1026', 2021, '1', '2102782', 'B'),
('MIB1001', 2021, '1', '2102782', 'B-'),
('COM1024', 2021, '1', '2102783', 'A'),
('MAT1044', 2021, '1', '2102783', 'A-'),
('PHS1019', 2021, '1', '2102783', 'B+'),
('CMP1026', 2021, '1', '2102783', 'B'),
('MIB1001', 2021, '1', '2102783', 'B-'),
('COM1024', 2021, '1', '2102784', 'A'),
('MAT1044', 2021, '1', '2102784', 'A-'),
('PHS1019', 2021, '1', '2102784', 'B+'),
('CMP1026', 2021, '1', '2102784', 'B'),
('MIB1001', 2021, '1', '2102784', 'B-'),
('COM1024', 2021, '1', '2202001', 'A'),
('MAT1044', 2021, '1', '2202001', 'A-'),
('PHS1019', 2021, '1', '2202001', 'B+'),
('CMP1026', 2021, '1', '2202001', 'B'),
('MIB1001', 2021, '1', '2202001', 'B-'),
('COM1024', 2021, '1', '2202002', 'A'),
('MAT1044', 2021, '1', '2202002', 'A-'),
('PHS1019', 2021, '1', '2202002', 'B+'),
('CMP1026', 2021, '1', '2202002', 'B'),
('MIB1001', 2021, '1', '2202002', 'B-'),
('COM1024', 2021, '1', '2202003', 'A'),
('MAT1044', 2021, '1', '2202003', 'A-'),
('PHS1019', 2021, '1', '2202003', 'B+'),
('CMP1026', 2021, '1', '2202003', 'B'),
('MIB1001', 2021, '1', '2202003', 'B-'),
('COM1024', 2021, '1', '2202004', 'A'),
('MAT1044', 2021, '1', '2202004', 'A-'),
('PHS1019', 2021, '1', '2202004', 'B+'),
('CMP1026', 2021, '1', '2202004', 'B'),
('MIB1001', 2021, '1', '2202004', 'B-'),
('COM1024', 2021, '1', '2202005', 'A'),
('MAT1044', 2021, '1', '2202005', 'A-'),
('PHS1019', 2021, '1', '2202005', 'B+'),
('CMP1026', 2021, '1', '2202005', 'B'),
('MIB1001', 2021, '1', '2202005', 'B-'),
('COM1024', 2021, '1', '2202006', 'A'),
('MAT1044', 2021, '1', '2202006', 'A-'),
('PHS1019', 2021, '1', '2202006', 'B+'),
('CMP1026', 2021, '1', '2202006', 'B'),
('MIB1001', 2021, '1', '2202006', 'B-'),
('COM1024', 2021, '1', '2202007', 'A'),
('MAT1044', 2021, '1', '2202007', 'A-'),
('PHS1019', 2021, '1', '2202007', 'B+'),
('CMP1026', 2021, '1', '2202007', 'B'),
('MIB1001', 2021, '1', '2202007', 'B-'),
('COM1024', 2021, '1', '2202008', 'A'),
('MAT1044', 2021, '1', '2202008', 'A-'),
('PHS1019', 2021, '1', '2202008', 'B+'),
('CMP1026', 2021, '1', '2202008', 'B'),
('MIB1001', 2021, '1', '2202008', 'B-'),
('COM1024', 2021, '1', '2202009', 'A'),
('MAT1044', 2021, '1', '2202009', 'A-'),
('PHS1019', 2021, '1', '2202009', 'B+'),
('CMP1026', 2021, '1', '2202009', 'B'),
('MIB1001', 2021, '1', '2202009', 'B-'),
('COM1024', 2021, '1', '2202010', 'A'),
('MAT1044', 2021, '1', '2202010', 'A-'),
('PHS1019', 2021, '1', '2202010', 'B+'),
('CMP1026', 2021, '1', '2202010', 'B'),
('MIB1001', 2021, '1', '2202010', 'B-'),
('COM1024', 2021, '1', '2202011', 'A'),
('MAT1044', 2021, '1', '2202011', 'A-'),
('PHS1019', 2021, '1', '2202011', 'B+'),
('CMP1026', 2021, '1', '2202011', 'B'),
('MIB1001', 2021, '1', '2202011', 'B-'),
('COM1024', 2021, '1', '2202012', 'A'),
('MAT1044', 2021, '1', '2202012', 'A-'),
('PHS1019', 2021, '1', '2202012', 'B+'),
('CMP1026', 2021, '1', '2202012', 'B'),
('MIB1001', 2021, '1', '2202012', 'B-'),
('COM1024', 2021, '1', '2202013', 'A'),
('MAT1044', 2021, '1', '2202013', 'A-'),
('PHS1019', 2021, '1', '2202013', 'B+'),
('CMP1026', 2021, '1', '2202013', 'B'),
('MIB1001', 2021, '1', '2202013', 'B-'),
('COM1024', 2021, '1', '2202014', 'A'),
('MAT1044', 2021, '1', '2202014', 'A-'),
('PHS1019', 2021, '1', '2202014', 'B+'),
('CMP1026', 2021, '1', '2202014', 'B'),
('MIB1001', 2021, '1', '2202014', 'B-'),
('COM1024', 2021, '1', '2202015', 'A'),
('MAT1044', 2021, '1', '2202015', 'A-'),
('PHS1019', 2021, '1', '2202015', 'B+'),
('CMP1026', 2021, '1', '2202015', 'B'),
('MIB1001', 2021, '1', '2202015', 'B-'),
('COM1024', 2021, '1', '2202016', 'A'),
('MAT1044', 2021, '1', '2202016', 'A-'),
('PHS1019', 2021, '1', '2202016', 'B+'),
('CMP1026', 2021, '1', '2202016', 'B'),
('MIB1001', 2021, '1', '2202016', 'B-'),
('COM1024', 2021, '1', '2202017', 'A'),
('MAT1044', 2021, '1', '2202017', 'A-'),
('PHS1019', 2021, '1', '2202017', 'B+'),
('CMP1026', 2021, '1', '2202017', 'B'),
('MIB1001', 2021, '1', '2202017', 'B-'),
('COM1024', 2021, '1', '2202018', 'A'),
('MAT1044', 2021, '1', '2202018', 'A-'),
('PHS1019', 2021, '1', '2202018', 'B+'),
('CMP1026', 2021, '1', '2202018', 'B'),
('MIB1001', 2021, '1', '2202018', 'B-'),
('COM1024', 2021, '1', '2202019', 'A'),
('MAT1044', 2021, '1', '2202019', 'A-'),
('PHS1019', 2021, '1', '2202019', 'B+'),
('CMP1026', 2021, '1', '2202019', 'B'),
('MIB1001', 2021, '1', '2202019', 'B-'),
('COM1024', 2021, '1', '2202020', 'A'),
('MAT1044', 2021, '1', '2202020', 'A-'),
('PHS1019', 2021, '1', '2202020', 'B+'),
('CMP1026', 2021, '1', '2202020', 'B'),
('MIB1001', 2021, '1', '2202020', 'B-'),
('ANP1001', 2023, '1', '2202001', 'C'),
('HPS1001', 2023, '1', '2202001', 'D+'),
('PSY1002', 2023, '2', '2202001', 'D'),
('OHP1021', 2023, '2', '2202001', 'E'),
('MAN1006', 2023, '1', '2202002', 'C'),
('LLB1003', 2023, '1', '2202002', 'D+'),
('DHT1012', 2023, '2', '2202002', 'D'),
('ANP1001', 2023, '2', '2202002', 'E'),
('MAT1044', 2023, '1', '2202003', 'D'),
('COT1019', 2023, '1', '2202003', 'D+'),
('SGI1001', 2023, '2', '2202003', 'D'),
('SGI1005', 2023, '2', '2202003', 'E'),
('CMP1005', 2023, '1', '2202004', 'E'),
('CMP2018', 2023, '1', '2202004', 'D+'),
('CMP1026', 2023, '2', '2202004', 'D'),
('MAT1008', 2023, '2', '2202004', 'E'),
('MIB1001', 2023, '1', '2202005', 'C'),
('ENS3001', 2023, '1', '2202005', 'D+'),
('IMM2002', 2023, '2', '2202005', 'D'),
('PHS1019', 2023, '2', '2202005', 'E'),
('COM2016', 2023, '1', '2202006', 'U'),
('MAT1044', 2023, '1', '2202006', 'D+'),
('MAT2003', 2023, '2', '2202006', 'D'),
('MAT1047', 2023, '2', '2202006', 'E'),
('COM1024', 2023, '1', '2202007', 'C'),
('MAN1006', 2023, '1', '2202007', 'D+'),
('CIT4024', 2023, '2', '2202007', 'D'),
('INT1001', 2023, '2', '2202007', 'E'),
('CMP1026', 2023, '1', '2202008', 'C'),
('LLB1006', 2023, '1', '2202008', 'D+'),
('LLB1002', 2023, '2', '2202008', 'D'),
('LLB1008', 2023, '2', '2202008', 'E'),
('MAT2003', 2021, '2', '2102781', 'A-'),
('COM1024', 2021, '1', '2102782', 'A-'),
('ANP1001', 2021, '1', '2102782', 'A'),
('HPS1001', 2021, '1', '2102782', 'A-'),
('MIB1001', 2021, '1', '2102782', 'A-'),
('COM2016', 2022, '2', '2102782', 'A-'),
('MAT1044', 2022, '2', '2102782', 'A'),
('IMM2002', 2022, '2', '2102782', 'B-'),
('INT1001', 2022, '2', '2102782', 'A'),
('COM1024', 2022, '1', '2102783', 'A-'),
('MAT1044', 2020, '1', '2102783', 'B-'),
('LLB1002', 2020, '1', '2102783', 'A-'),
('LLB1004', 2020, '1', '2102783', 'A'),
('LLB1008', 2020, '1', '2102783', 'A-'),
('COM1024', 2020, '1', '2102784', 'B-'),
('MAT1044', 2020, '1', '2102784', 'C'),
('CMP2018', 2020, '1', '2102784', 'A-'),
('MAN1006', 2020, '1', '2102784', 'A'),
('ENS3001', 2020, '2', '2102784', 'A+'),
('COM2016', 2021, '2', '2102784', 'U'),
('CIT4024', 2021, '2', '2102784', 'E'),
('MAT2003', 2021, '2', '2102784', 'A-'),
('ANP1001', 2024, '1', '2202001', 'C'),
('HPS1001', 2024, '1', '2202001', 'D+'),
('PSY1002', 2024, '2', '2202001', 'D'),
('OHP1021', 2024, '2', '2202001', 'E'),
('MAN1006', 2024, '1', '2202002', 'C'),
('LLB1003', 2024, '1', '2202002', 'D+'),
('DHT1012', 2024, '2', '2202002', 'D'),
('ANP1001', 2024, '2', '2202002', 'E'),
('MAT1044', 2024, '1', '2202003', 'D'),
('COT1019', 2024, '1', '2202003', 'D+'),
('SGI1001', 2024, '2', '2202003', 'D'),
('SGI1005', 2024, '2', '2202003', 'E'),
('CMP1005', 2024, '1', '2202004', 'E'),
('CMP2018', 2024, '1', '2202004', 'D+'),
('CMP1026', 2024, '2', '2202004', 'D'),
('MAT1008', 2024, '2', '2202004', 'E'),
('MIB1001', 2024, '1', '2202005', 'C'),
('ENS3001', 2024, '1', '2202005', 'D+'),
('IMM2002', 2024, '2', '2202005', 'D'),
('PHS1019', 2024, '2', '2202005', 'E'),
('COM2016', 2024, '1', '2202006', 'U'),
('MAT1044', 2024, '1', '2202006', 'D+'),
('MAT2003', 2024, '2', '2202006', 'D'),
('MAT1047', 2024, '2', '2202006', 'E'),
('COM1024', 2024, '1', '2202007', 'C'),
('MAN1006', 2024, '1', '2202007', 'D+'),
('CIT4024', 2024, '2', '2202007', 'D'),
('INT1001', 2024, '2', '2202007', 'E'),
('CMP1026', 2024, '1', '2202008', 'C'),
('LLB1006', 2024, '1', '2202008', 'D+'),
('LLB1002', 2024, '2', '2202008', 'D'),
('LLB1008', 2024, '2', '2202008', 'E'),
('CMP2018', 2024, '1', '2202009', 'C'),
('ENS3001', 2024, '1', '2202009', 'D+'),
('COM2016', 2024, '2', '2202009', 'D'),
('MAN1006', 2024, '2', '2202009', 'E'),
('DHT1012', 2024, '1', '2202010', 'C'),
('OHP1021', 2024, '1', '2202010', 'D+'),
('HPS1001', 2024, '2', '2202010', 'D'),
('PSY1002', 2024, '2', '2202010', 'E'),
('COT1019', 2024, '1', '2202011', 'C'),
('SGI1001', 2024, '1', '2202011', 'D+'),
('SGI1005', 2024, '2', '2202011', 'D'),
('CMP1026', 2024, '2', '2202011', 'E'),
('CMP1005', 2024, '1', '2202012', 'C'),
('MAT1008', 2024, '1', '2202012', 'D+'),
('CMP2018', 2024, '2', '2202012', 'D'),
('CMP1026', 2024, '2', '2202012', 'E'),
('MAN1006', 2024, '1', '2202013', 'C'),
('LLB1003', 2024, '1', '2202013', 'D+'),
('DHT1012', 2024, '2', '2202013', 'D'),
('ANP1001', 2024, '2', '2202013', 'E'),
('ENS3001', 2024, '1', '2202014', 'C'),
('MIB1001', 2024, '1', '2202014', 'D+'),
('IMM2002', 2024, '2', '2202014', 'D'),
('PHS1019', 2024, '2', '2202014', 'E'),
('COM2016', 2024, '1', '2202015', 'C'),
('MAT1044', 2024, '1', '2202015', 'D+'),
('MAT2003', 2024, '2', '2202015', 'D'),
('MAT1047', 2024, '2', '2202015', 'E'),
('COM1024', 2024, '1', '2202016', 'C'),
('MAN1006', 2024, '1', '2202016', 'D+'),
('CIT4024', 2024, '2', '2202016', 'D'),
('INT1001', 2024, '2', '2202016', 'E'),
('CMP1026', 2024, '1', '2202017', 'U'),
('LLB1006', 2024, '1', '2202017', 'D+'),
('LLB1002', 2024, '2', '2202017', 'D'),
('LLB1008', 2024, '2', '2202017', 'E'),
('CMP2018', 2024, '1', '2202018', 'C'),
('ENS3001', 2024, '1', '2202018', 'D+'),
('COM2016', 2024, '2', '2202018', 'D'),
('MAN1006', 2024, '2', '2202018', 'E'),
('DHT1012', 2024, '1', '2202019', 'E'),
('OHP1021', 2024, '1', '2202019', 'D+'),
('HPS1001', 2024, '2', '2202019', 'D'),
('PSY1002', 2024, '2', '2202019', 'E');


-- Select data from tables
SELECT * FROM studentMaster;
SELECT * FROM moduleMaster;
SELECT * FROM moduleDetails;
SELECT * FROM letterGrades;

-- Identify students with no semester 1 data
SELECT DISTINCT student_id
FROM your_table_name
WHERE semester = '1';





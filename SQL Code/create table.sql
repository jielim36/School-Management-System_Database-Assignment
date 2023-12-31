CREATE DATABASE school_management_system;
USE school_management_system;


CREATE TABLE Staff(
	StaffID INT AUTO_INCREMENT,
	StaffName VARCHAR(50) NOT NULL,
	IC CHAR(14) NOT NULL UNIQUE DEFAULT '',
	Birthday DATE NOT NULL,
	Gender CHAR(1) NOT NULL DEFAULT '',
	Entry_Time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Position VARCHAR(50) NOT NULL DEFAULT '',
	Salary DOUBLE NOT NULL DEFAULT 0,
	PhoneNumber INT NOT NULL DEFAULT 0,
	Email VARCHAR(50) NOT NULL DEFAULT '',
	CHECK (gender='F' OR gender='M'),
	PRIMARY KEY (StaffID)
);


CREATE TABLE Faculty(
	FacultyID INT AUTO_INCREMENT,
	FacultyName VARCHAR(50) NOT NULL DEFAULT '',
	NumberTeacher INT NOT NULL DEFAULT 0,
	NumberStudent INT NOT NULL DEFAULT 0,
	DeanID INT NOT NULL DEFAULT 0,
	Contact VARCHAR(50) NOT NULL DEFAULT '',
	PRIMARY KEY (FacultyID),
	FOREIGN KEY (DeanID) REFERENCES Staff(StaffID)
);


CREATE TABLE StudentList(
	StudentID INT AUTO_INCREMENT,
	StudentName VARCHAR(50) NOT NULL,
	IC CHAR(14) NOT NULL UNIQUE DEFAULT '',
	Birthday DATE NOT NULL,
	gender CHAR(1) NOT NULL DEFAULT '',
	Entry_Time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FacultyID INT NOT NULL DEFAULT 0,-- references Table 'Faculty' (FacultyID)
	Qualifications VARCHAR(50) NOT NULL DEFAULT '',
	PhoneNumber INT NOT NULL DEFAULT 0,
	Email VARCHAR(50) NOT NULL DEFAULT '',
	CHECK (gender='F' OR gender='M'),
	PRIMARY KEY (StudentID),
	FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

CREATE TABLE StudentUnion(
	StudentID INT NOT Null,
	StudentName VARCHAR(50) NOT NULL DEFAULT '',
	Position VARCHAR(50) NOT NULL DEFAULT '',
	Entry_Time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Age INT NOT NULL DEFAULT 0,
	FOREIGN KEY (StudentID) REFERENCES StudentList(StudentID)
);

CREATE TABLE HostelList(
	RoomID INT AUTO_INCREMENT,
	StudentID INT NOT NULL,
	`Status` VARCHAR(20) NOT NULL DEFAULT '',
	RoomType VARCHAR(20) NOT NULL DEFAULT '',
	UnitNo VARCHAR(20) NOT NULL DEFAULT '',
	PRIMARY KEY (RoomID),
	FOREIGN KEY (StudentID) REFERENCES StudentList(StudentID)
);

CREATE TABLE AdministrationUnit(
	DepartmentID INT AUTO_INCREMENT,
	DepartmentName VARCHAR(50) NOT NULL DEFAULT '',
	StaffNumber INT NOT NULL DEFAULT 0,
	DeanID INT NOT NULL DEFAULT 0,
	Detail VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (DepartmentID),
	FOREIGN KEY (DeanID) REFERENCES Staff(StaffID)
);

CREATE TABLE ClubAndSocieties(
  SocietiesID INT AUTO_INCREMENT,
  SocietiesName VARCHAR(50) NOT NULL,
  TYPE VARCHAR(50) NOT NULL,
  NumberMember INT NOT NULL DEFAULT 0,
  DeanID INT NOT NULL DEFAULT 0,
  Contact VARCHAR(50) NOT NULL DEFAULT '',
  PRIMARY KEY (SocietiesID),
  FOREIGN KEY (DeanID) REFERENCES Staff(StaffID)
);


CREATE TABLE Department(
   FacultyID INT NOT NULL DEFAULT 0,
   DepartmentID  INT AUTO_INCREMENT,
   ProgrammeName  VARCHAR(50) NOT NULL DEFAULT '',
   NumberSTudent INT NOT NULL DEFAULT 0,
   SubjectNumber INT NOT NULL DEFAULT 0,
  	PRIMARY KEY (DepartmentID),
  	FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
); 

CREATE TABLE ComputerCentre(
  StaffID INT NOT NULL DEFAULT 0,
  DepartmentID  INT NOT NULL DEFAULT 0,
  SupervisorID  INT NOT NULL DEFAULT 0,
  Responsibility VARCHAR(50) NOT NULL DEFAULT '',
  Shift VARCHAR(50) NOT NULL DEFAULT '',
  FOREIGN KEY (DepartmentID) REFERENCES AdministrationUnit(DepartmentID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  FOREIGN KEY (SupervisorID) REFERENCES Staff(StaffID)
);

CREATE TABLE GeneralAffairsDepartment(
  StaffID INT NOT NULL DEFAULT 0,
  DepartmentID  INT NOT NULL DEFAULT 0,
  SupervisorID  INT NOT NULL DEFAULT 0,
  Responsibility VARCHAR(50) NOT NULL DEFAULT '',
  Shift VARCHAR(50) NOT NULL DEFAULT '',
  FOREIGN KEY (DepartmentID) REFERENCES AdministrationUnit(DepartmentID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  FOREIGN KEY (SupervisorID) REFERENCES Staff(StaffID)
);

CREATE TABLE HumanResourceDepartment(
  StaffID INT NOT NULL DEFAULT 0,
  DepartmentID  INT NOT NULL DEFAULT 0,
  SupervisorID  INT NOT NULL DEFAULT 0,
  Responsibility VARCHAR(50) NOT NULL DEFAULT '',
  Shift VARCHAR(50) NOT NULL DEFAULT '',
  FOREIGN KEY (DepartmentID) REFERENCES AdministrationUnit(DepartmentID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  FOREIGN KEY (SupervisorID) REFERENCES Staff(StaffID)
);

CREATE TABLE CounsellingCentre(
  StaffID INT NOT NULL DEFAULT 0,
  DepartmentID  INT NOT NULL DEFAULT 0,
  SupervisorID  INT NOT NULL DEFAULT 0,
  Responsibility VARCHAR(50) NOT NULL DEFAULT '',
  Shift VARCHAR(50) NOT NULL DEFAULT '',
  FOREIGN KEY (DepartmentID) REFERENCES AdministrationUnit(DepartmentID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  FOREIGN KEY (SupervisorID) REFERENCES Staff(StaffID)
);

CREATE TABLE PublicRelationsDepartment(
  StaffID INT NOT NULL DEFAULT 0,
  DepartmentID  INT NOT NULL DEFAULT 0,
  SupervisorID  INT NOT NULL DEFAULT 0,
  Responsibility VARCHAR(50) NOT NULL DEFAULT '',
  Shift VARCHAR(50) NOT NULL DEFAULT '',
  FOREIGN KEY (DepartmentID) REFERENCES AdministrationUnit(DepartmentID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  FOREIGN KEY (SupervisorID) REFERENCES Staff(StaffID)
);

CREATE TABLE AccountStudent(
	userID INT NOT NULL,
	userName varchar(20) NOT NULL,
	userType VARCHAR(20) NOT NULL DEFAULT '',
	`password` VARCHAR(50) NOT NULL,-- must using MD5 when insert password
	Authority INT NOT NULL DEFAULT '5',
	CHECK (Authority BETWEEN 1 AND 5),
	PRIMARY KEY (userID),
	FOREIGN KEY (userID) REFERENCES studentlist(studentID)
	);
	
CREATE TABLE AccountStaff(
	userID INT NOT NULL,
	userName varchar(20) NOT NULL,
	userType VARCHAR(20) NOT NULL DEFAULT '',
	`password` VARCHAR(50) NOT NULL,-- must using MD5 when insert password
	Authority INT NOT NULL DEFAULT '5',
	CHECK (Authority BETWEEN 1 AND 5),
	PRIMARY KEY (userID),
	FOREIGN KEY (userID) REFERENCES Staff(staffID)
);
	
CREATE TABLE Payment (
		payID INT AUTO_INCREMENT,
		studentID INT NOT NULL,
		InvoiceNumber VARCHAR(255) NOT NULL,
		YearSemester VARCHAR(50) NOT NULL,
		PaidToCompany VARCHAR(50) NOT NULL,
		Amount DOUBLE NOT NULL DEFAULT 0,
		`Status` ENUM('Unpaid', 'Cash', 'FPX'),
		PaidDate DATE, -- Payment Date, if stautus is unpaid, then this Attribute is null
		PRIMARY KEY (payID),
		FOREIGN KEY (studentID) REFERENCES studentlist(studentID)
);


CREATE TABLE subjectList(
	subjectID INT AUTO_INCREMENT,
	facultyID INT NOT NULL,
	subjectName VARCHAR(50) NOT NULL DEFAULT '',
	Type ENUM('C','E','CC','CE'),
	Credit INT NOT NULL,
	Hours DOUBLE NOT NULL DEFAULT 0,
	PRIMARY KEY (subjectID),
	FOREIGN KEY (facultyID) REFERENCES Faculty(facultyID)
);

CREATE TABLE resultStudent(
	studentID INT NOT NULL,-- fk studentlist(studentid)
	subjectID INT NOT NULL,-- FK SUBJECTID
	Type ENUM('C','E','CC','CE'),
	Credit INT NOT NULL,
	Grade CHAR(2) NOT NULL DEFAULT 'F',
	GradePoint DECIMAL(3, 2) NOT NULL DEFAULT 0.00,
	FOREIGN KEY (studentID) REFERENCES studentlist(studentID),
	FOREIGN KEY (subjectID) REFERENCES subjectList(subjectID)
);


CREATE TABLE TuitionFees(
		FacultyID INT,-- FK
		ProgrammeName VARCHAR(50) NOT NULL DEFAULT '',
		Duration VARCHAR(50) NOT NULL,
		TuitionFee INT NOT NULL DEFAULT 0,
		MiscellaneousFee INT NOT NULL DEFAULT 0, 
		ApplicationFee INT NOT NULL DEFAULT 0,
		ValidationFee INT NOT NULL DEFAULT 0,
		TotalAmount INT NOT NULL DEFAULT 0,
		FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

CREATE TABLE CategoriesBook(
	CategoryID INT AUTO_INCREMENT,
	CategoryName  VARCHAR(50) NOT NULL DEFAULT '', 
	Description  VARCHAR(50) NOT NULL DEFAULT '',
	NumberBook INT NOT NULL DEFAULT 0,
  PRIMARY KEY (CategoryID)
);

CREATE TABLE BookList(
	BookID INT AUTO_INCREMENT,
	Title  VARCHAR(50) NOT NULL DEFAULT '',
	Author  VARCHAR(50) NOT NULL DEFAULT '',
	Publicationyear  DATE,
	CategoryID INT NOT NULL DEFAULT 0, -- FK
	PRIMARY KEY (BookID),
	FOREIGN KEY (CategoryID) REFERENCES CategoriesBook(CategoryID)
);

CREATE TABLE BorrowList(
	ID INT AUTO_INCREMENT,
	StudentID INT NOT NULL DEFAULT 0,-- FK
	BookID INT NOT NULL,
	BorrowDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	DueDate DATE NOT NULL,
	State VARCHAR(20) NOT NULL DEFAULT '',
  PRIMARY KEY (ID),
	FOREIGN KEY (StudentID) REFERENCES studentlist(studentID),
	FOREIGN KEY (BookID) REFERENCES bookList(bookID)
);

CREATE TABLE school_third_parties (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    contact_name VARCHAR(100),
    contact_phone VARCHAR(20),
    contact_email VARCHAR(100),
    note TEXT
);

CREATE TABLE staffSalary (
    id INT PRIMARY KEY AUTO_INCREMENT,
    staffID INT NOT NULL,
    `Month` DATE NOT NULL,
    baseSalary DECIMAL(10, 2) NOT NULL,
    bonus DECIMAL(10, 2) DEFAULT 0.00,
    deductions DECIMAL(10, 2) DEFAULT 0.00,
    netSalary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (staffId) REFERENCES staff(staffId)
);

CREATE TABLE school_accounts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(50),
    balance DECIMAL(10, 2),
    description TEXT,
    third_party_id INT,
		principalID INT,
    FOREIGN KEY (third_party_id) REFERENCES school_third_parties(id),
		FOREIGN KEY (principalID) REFERENCES staff(staffid)
);

CREATE TABLE student_cards (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    card_number VARCHAR(20) NOT NULL UNIQUE,
    expiration_date DATE,
    balance DECIMAL(10, 2),
    activated BOOLEAN DEFAULT FALSE,-- If student is graduated,then false
    FOREIGN KEY (student_id) REFERENCES studentList(studentId)
);

CREATE TABLE teacher_evaluation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id INT NOT NULL,
    yearSemester VARCHAR(50) NOT NULL,
    teaching_content_rating INT,
    teaching_method_rating INT,
    interaction_ability_rating INT,
    overall_evaluation TEXT,
    FOREIGN KEY (teacher_id) REFERENCES staff(staffid)
);


CREATE TABLE roomList (
    roomID INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(50) NOT NULL, -- classRoom or meetingRoom
    Capacity INT,
    Unit VARCHAR(20),
    Description TEXT
);

CREATE TABLE course_schedule (
    id INT PRIMARY KEY AUTO_INCREMENT,
    subjectID INT NOT NULL,
    teacherID INT NOT NULL,
		`day` VARCHAR(20) NOT NULL, -- Monday,....
    schedule_time DATETIME NOT NULL,
    classroomID INT NOT NULL,
		FOREIGN KEY (teacherID) REFERENCES Staff(staffID),
		FOREIGN KEY (classroomID) REFERENCES roomList(roomID),
		FOREIGN KEY (subjectID) REFERENCES subjectList(subjectID)
);

CREATE TABLE room_rentals (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    roomID INT NOT NULL,
    studentID INT NOT NULL,
    startTime DATETIME NOT NULL,
    endTime DATETIME NOT NULL,
		purpose TEXT,
		FOREIGN KEY (roomID) REFERENCES roomList(roomID),
		FOREIGN KEY (studentID) REFERENCES studentList(studentID)
);

CREATE TABLE student_discipline_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    studentID INT NOT NULL,
    date DATE NOT NULL,
    type VARCHAR(50),
    description TEXT,
    disciplinarian INT NOT NULL,
		FOREIGN KEY (studentID) REFERENCES studentList(studentID),
		FOREIGN KEY (disciplinarian) REFERENCES staff(staffID)
);


-- drop table clubandsociesties;
-- drop table department_artanddesign;
-- drop table department_businessstudies;
-- drop table department_chineselanguageandliterature;
-- drop table department_dramaandvisual;
-- drop table department_education;
-- drop table department_financeandaccounting;
-- drop table department_guidanceandcounsellingpsychology;
-- drop table department_informationcomputingtechnology;
-- drop table department_lawenforcement;
-- drop table department_mediastudies;
-- drop table administrationunit;
-- drop table computercentre;
-- drop table coundellingcentre;
-- drop table generalaffairsdepartment;
-- drop table humanresourcedepartment;
-- drop table publicrelationsdepartment;
-- drop table administrationUnit;
-- drop table studentunion;
-- drop table hostelList;
-- drop table studentlist;
-- drop table Faculty;
-- drop table Staff;
-- 

-- use your unit code followed by your student ID number. 
-- For example, if you are enrolled in COMP2350, and your student ID number is 123456
-- then, replace XXX with COMP2350_123456
create database COMP_47535032; 
use COMP_47535032;

-- Create table for storing student information
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    is_current ENUM('YES', 'NO') DEFAULT 'YES'
);

-- Create table for storing courses information
CREATE TABLE Unit (
    unit_code VARCHAR(15) PRIMARY KEY,
    unit_name VARCHAR(100),
    is_advanced ENUM('YES', 'NO') DEFAULT 'NO',
    enrollment INT DEFAULT 0,
    registration_date DATE
);

-- Create table for storing registrations (student-unit relationship)   
-- Update on 03/10/2024: added new column no_penlty_deadline. See ilearn announcement on 03/10/2024
-- Update on 07/10/2024: added new columns droped_out_date and status. 
CREATE TABLE Registration (
    student_id INT,
    unit_code VARCHAR(15),
    semester varchar(15),
    registration_date DATE,
    no_penalty_deadline DATE, 
    dropped_out_date DATE,
    status ENUM('active', 'dropped_with_penalty', 'dropped_without_penalty') DEFAULT 'active',  -- Newly added column
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);


-- Create table for storing student grades
-- Update on 07/10/2024: added new column status.
CREATE TABLE UnitGrade (
    student_id INT,
    unit_code VARCHAR(15),
    semester VARCHAR(15),
    marks DECIMAL(5, 2),
    status ENUM('active', 'dropped') DEFAULT 'active', 
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);

-- Create table for storing fee information
CREATE TABLE Fee (
    student_id INT,
    semester varchar(15),
    fee_amount DECIMAL(10, 2),
    status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    description VARCHAR(255),
    PRIMARY KEY (student_id, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


-- Insert data into Student table
INSERT INTO Student (student_id, student_name, is_current) VALUES
(10001, 'Alice Smith', 'YES'),
(10002, 'Bob Johnson', 'YES'),
(10003, 'Charlie Brown', 'NO'),
(10004, 'David Wilson', 'YES'),
(10005, 'Emily Davis', 'NO'),
(10006, 'Frank Miller', 'YES'),
(10007, 'Grace Hall', 'YES'),
(10008, 'Hannah Lewis', 'YES'),
(10009, 'Ian Walker', 'NO'),
(10010, 'Julia Young', 'YES'),
(10011, 'Kevin Harris', 'YES'),
(10012, 'Lily Martin', 'YES'),
(10013, 'Mason White', 'NO'),
(10014, 'Nina Clark', 'YES'),
(10015, 'Oliver King', 'YES'),
(10016, 'Paul Scott', 'YES'),
(10017, 'Quinn Green', 'NO'),
(10018, 'Rachel Adams', 'YES'),
(10019, 'Samuel Turner', 'YES'),
(10020, 'Tina Baker', 'YES');

-- Insert data into Unit table
INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) VALUES
('IT101', 'Introduction to Programming', 'NO', 40, '2023-02-20'),
('IT102', 'Data Structures', 'NO', 35, '2023-02-20'),
('IT103', 'Database Systems', 'NO', 30, '2023-02-20'),
('IT401', 'Advanced Algorithms', 'YES', 20, '2023-02-20'),
('IT402', 'Machine Learning', 'YES', 25, '2023-02-20'),
('IT403', 'AI in Business', 'YES', 15, '2023-02-20'),
('IT404', 'Cybersecurity', 'YES', 18, '2023-02-20'),
('IT105', 'Operating Systems', 'NO', 30, '2023-02-20'),
('IT106', 'Web Development', 'NO', 28, '2023-02-20'),
('IT405', 'Cloud Computing', 'YES', 12, '2023-02-20');

-- Insert data into Registration table. 
-- Update on 07/10/2024: added data for new columns, droped_out_date and status. Also, updated no_penalty_deadline data
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10001, 'IT101', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10001, 'IT102', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10002, 'IT103', '2023S1', '2023-01-16', '2023-02-13', NULL, 'active'), 
(10002, 'IT105', '2023S1', '2023-01-16', '2023-02-13', '2023-02-10', 'dropped_without_penalty'), 
(10003, 'IT101', '2023S1', '2023-01-17', '2023-02-12', '2023-02-15', 'dropped_with_penalty'), 
(10003, 'IT401', '2023S1', '2023-01-17', '2023-02-14', NULL, 'active'), 
(10004, 'IT402', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10004, 'IT403', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10005, 'IT404', '2023S1', '2023-01-19', '2023-02-16', NULL, 'active'), 
(10005, 'IT102', '2023S1', '2023-01-19', '2023-02-12', '2023-02-20', 'dropped_with_penalty'), 
(10006, 'IT401', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10006, 'IT105', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10007, 'IT402', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10007, 'IT101', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10008, 'IT403', '2023S2', '2023-06-12', '2023-07-10', NULL, 'active'), 
(10008, 'IT102', '2023S2', '2023-06-12', '2023-07-10', '2023-07-15', 'dropped_with_penalty'), 
(10009, 'IT404', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10009, 'IT103', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10010, 'IT401', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10010, 'IT405', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10011, 'IT101', '2024S1', '2024-01-10', '2024-02-10', NULL, 'active'), 
(10011, 'IT402', '2024S1', '2024-01-10', '2024-02-07', NULL, 'active'), 
(10012, 'IT403', '2024S1', '2024-01-11', '2024-02-11', '2024-02-10', 'dropped_with_penalty'), 
(10012, 'IT102', '2024S1', '2024-01-11', '2024-02-11', NULL, 'active'), 
(10013, 'IT105', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10013, 'IT404', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10014, 'IT101', '2024S1', '2024-01-13', '2024-02-10', '2024-02-12', 'dropped_with_penalty'), 
(10014, 'IT405', '2024S1', '2024-01-13', '2024-02-10', NULL, 'active'), 
(10015, 'IT102', '2024S1', '2024-01-14', '2024-02-11', '2024-02-01', 'dropped_without_penalty'), 
(10015, 'IT403', '2024S1', '2024-01-14', '2024-02-11', NULL, 'active'), 
(10016, 'IT401', '2024S1', '2024-01-15', '2024-02-07', NULL, 'active'), 
(10016, 'IT103', '2024S1', '2024-01-15', '2024-02-12', '2024-02-10', 'dropped_without_penalty'), 
(10017, 'IT102', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10017, 'IT404', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10018, 'IT101', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10018, 'IT401', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10019, 'IT105', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10019, 'IT402', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10020, 'IT403', '2024S2', '2024-06-04', '2024-07-02', NULL, 'active'), 
(10020, 'IT101', '2024S2', '2024-06-04', '2024-06-30', NULL, 'active');


-- Insert data into UnitGrade table with semester, marks, and status (active or dropped)
-- Update on 07/10/2024: added data for new column status and updated marks for dropped units
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10001, 'IT101', '2023S1', 75.00, 'active'),
(10001, 'IT102', '2023S1', 65.00, 'active'),
(10002, 'IT103', '2023S1', 85.50, 'active'),
(10002, 'IT105', '2023S1', NULL, 'dropped'),
(10003, 'IT101', '2023S1', NULL, 'dropped'),
(10003, 'IT401', '2023S1', NULL, 'dropped'),
(10004, 'IT402', '2023S1', 55.00, 'active'),
(10004, 'IT403', '2023S1', 92.00, 'active'),
(10005, 'IT404', '2023S1', 50.00, 'active'), 
(10005, 'IT102', '2023S1', NULL, 'dropped'),
(10006, 'IT401', '2023S2', 47.00, 'active'),  
(10006, 'IT105', '2023S2', 60.00, 'active'),
(10007, 'IT402', '2023S2', 88.00, 'active'),
(10007, 'IT101', '2023S2', 30.00, 'active'), 
(10008, 'IT403', '2023S2', 90.00, 'active'),
(10008, 'IT102', '2023S2', NULL, 'dropped'), 
(10009, 'IT404', '2023S2', 40.00, 'active'),
(10009, 'IT103', '2023S2', 55.00, 'active'),
(10010, 'IT401', '2023S2', 85.00, 'active'),
(10010, 'IT405', '2023S2', 32.00, 'active'), 
(10011, 'IT101', '2024S1', 75.00, 'active'),
(10011, 'IT402', '2024S1', 65.00, 'active'),
(10012, 'IT403', '2024S1', NULL, 'dropped'), 
(10012, 'IT102', '2024S1', 70.00, 'active'),
(10013, 'IT105', '2024S1', 85.00, 'active'),
(10013, 'IT404', '2024S1', 48.00, 'active'),
(10014, 'IT101', '2024S1', NULL, 'dropped'), 
(10014, 'IT405', '2024S1', 88.00, 'active'),
(10015, 'IT102', '2024S1', NULL, 'dropped'), 
(10015, 'IT403', '2024S1', 90.00, 'active'),
(10016, 'IT401', '2024S1', 75.00, 'active'),
(10016, 'IT103', '2024S1', NULL, 'dropped'),  
(10017, 'IT102', '2024S2', 70.00, 'active'),
(10017, 'IT404', '2024S2', 68.00, 'active'),
(10018, 'IT101', '2024S2', 60.00, 'active'),
(10018, 'IT401', '2024S2', 80.00, 'active'),
(10019, 'IT105', '2024S2', 82.00, 'active'),
(10019, 'IT402', '2024S2', 90.00, 'active'),
(10020, 'IT403', '2024S2', 94.00, 'active'),
(10020, 'IT101', '2024S2', 78.00, 'active');


-- Insert data into Fee table
-- Update on 07/10/2024: updated data for fee_amount column 
INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10001, '2023S1', 6500.00, 'PAID', 'Tuition Fee'),
(10001, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10002, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10002, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10003, '2023S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10003, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10004, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10004, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10005, '2023S1', 6500.00, 'UNPAID', 'Tuition Fee'),
(10005, '2023S2', 6500.00, 'PAID', 'Late Unit Enrollment Fee'),
(10006, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10006, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10007, '2023S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10007, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2024S1', 8500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10009, '2023S2', 6500.00, 'UNPAID', 'Tuition Fee'),
(10009, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10010, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10010, '2024S1', 8500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10012, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10012, '2024S2', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S2', 7500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10014, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10014, '2024S2', 8500.00, 'PAID', 'Dropped Unit Penalty'),
(10015, '2024S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10015, '2024S2', 6500.00, 'UNPAID', 'Tution Fee'),
(10016, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10016, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10017, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10017, '2023S2', 6500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10018, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10018, '2023S2', 6500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10019, '2024S2', 8500.00, 'PAID', 'Tuition Fee'),
(10019, '2023S2', 7500.00, 'PAID', 'Tution Fee'),
(10020, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10020, '2023S2', 8500.00, 'PAID', 'Tuition Fee');

-- TASK 1
--                  TASK 2 TEST PLAN
-- students with unpaid tuition fees but no dropped units
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10070, 'Leo Miles', 'YES');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (10070, 'IT101', '2024S1', '2023-02-19', '2024-02-10', NULL, 'active');

INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES (10070, '2024S1', 3000.00, 'unpaid', 'Tuition Fee');

SELECT GetStudentOutstandingBalance(10070) AS OutstandingBalance;


-- Student dropping unit before deadline
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10022, 'Drake Mamba', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT108', 'Software Engineering', 'NO', 30, '2023-02-20');

select * from unit;
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (10022, 'IT108', '2024S1', '2023-02-19', '2024-02-07', '2024-02-05', 'dropped_without_penalty');

SELECT GetStudentOutstandingBalance(10022) AS OutstandingBalance;


-- Student dropping a unit after penalty deadline (non-advance unit)
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10023, 'Tiani Obama', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT109', 'Data Mining', 'NO', 30, '2023-02-20');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (10023, 'IT109', '2024S1', '2023-01-12', '2023-02-19', '2024-02-15', 'dropped_with_penalty');

SELECT GetStudentOutstandingBalance(10023) AS OutstandingBalance;


-- Student dropping a unit after penalty deadline (advance unit)
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10030, 'Sophia Green', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT110', 'Advanced AI', 'YES', 15, '2023-02-20');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (10030, 'IT110', '2024S1', '2023-02-19', '2024-02-11', '2024-02-18', 'dropped_with_penalty');

SELECT GetStudentOutstandingBalance(10030) AS OutstandingBalance;



-- Student with unpaids tuition fees and dropped unit (advance)
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10072, 'Elaine Diddy', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT469', 'Machine Learning', 'YES', 25, '2023-02-20');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (10072, 'IT402', '2024S1', '2023-02-19', '2023-02-20', '2024-02-20', 'dropped_with_penalty');

INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES (10072, '2024S1', 0.00, 'unpaid', 'Tuition Fee');

SELECT GetStudentOutstandingBalance(10072) 
AS OutstandingBalance;


-- student with late enrollment penalty
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10080, 'Jake Peralta', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT555', 'Cybersecurity', 'YES', 20, '2023-02-01');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (10080, 'IT555', '2024S1', '2024-02-20', '2024-01-12', '2024-02-25', 'dropped_with_penalty');

INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES (10080, '2024S1', 8000.00, 'unpaid', 'Tuition Fee');

SELECT GetStudentOutstandingBalance(10080) 
AS OutstandingBalance;

-- Student who's only late for registering the class
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10032, 'Amy Santiago', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT117', 'Computer Networks', 'NO', 25, '2023-02-01');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (10032, 'IT117', '2024S1', '2024-02-20', '2024-01-12', NULL, 'active');

INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES (10032, '2024S1', 6000.00, 'paid', 'Tuition Fee');

SELECT GetStudentOutstandingBalance(10032) 
AS OutstandingBalance;




--                   TASK 3 TEST PLAN 

-- Insert data for a student with no failed units and no outstanding balance
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (20003, 'Bat Man', 'YES');

INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES (20003, '2023S1', 6500.00, 'paid', 'Tuition Fee');

INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) 
VALUES (20003, 'IT101', '2023S1', 75.00, 'active');

CALL EnrollInUnit(20003, 'IT101', '2024S1', @message);
SELECT @message;  

-- Insert Student with Outstanding Balance
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (20004, 'Joe Mama', 'YES');
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (20004, 'IT116', '2024S1', '2024-02-20', '2024-01-12', '2024-02-25', 'dropped_with_penalty');
INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES (20004, '2023S1', 5000.00, 'unpaid', 'Tuition Fee');

CALL EnrollInUnit(20004, 'IT105', '2024S1', @message);
SELECT @message;

SELECT GetStudentOutstandingBalance(20004) ;



-- student who fails more than 2 units and tries to enroll in advance unit
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10041, 'John Snow', 'YES');
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) 
VALUES 
(10041, 'IT101', '2023S1', 40.00, 'active'),
(10041, 'IT102', '2023S1', 35.00, 'active'),
(10041, 'IT103', '2023S1', 45.00, 'active');

CALL EnrollInUnit(10041, 'IT401', '2024S1', @message);
SELECT @message;	

-- Student who dropped a non-advanced unit after the ‘no-penalty’ deadline
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10042, 'Shafin kat', 'YES');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (10042, 'IT105', '2023S2', '2023-06-10', '2023-07-01', '2023-07-10', 'dropped_with_penalty');

CALL EnrollInUnit(10042, 'IT102', '2024S1', @message);
SELECT @message;


-- Error Handling
CALL EnrollInUnit(99999, 'IT101', '2024S1', @message);
SELECT @message;


-- Student Trying to Enroll in the Same Unit Twice 
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10044, 'Daenerys Targaryen', 'YES');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, status) 
VALUES (10044, 'IT102', '2024S1', '2023-02-15', 'active');

CALL EnrollInUnit(10044, 'IT102', '2024S1', @message);
SELECT @message;




-- Student trying to apply for a new unit with enrollment at max capacity
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10049, 'Bruce Wayne', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT201', 'Networking Basics', 'NO', 200, '2024-02-20');

INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES (10049, '2024S1', 6500.00, 'PAID', 'Tuition Fee');

INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) 
VALUES 
(10049, 'IT101', '2023S1', 70.00, 'active'),
(10049, 'IT102', '2023S1', 65.00, 'active');

CALL EnrollInUnit(10049, 'IT201', '2024S1', @message);
SELECT @message;

-- student who tries to enroll in a advance unit when they have 2 Failed Units and 1 Passed Unit

INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10050, 'Tom Misch', 'YES');
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) 
VALUES 
(10050, 'IT101', '2023S1', 45.00, 'active'),
(10050, 'IT102', '2023S1', 48.00, 'active'),
(10050, 'IT103', '2023S1', 50.00, 'active');

CALL EnrollInUnit(10050, 'IT401', '2024S1', @message);
SELECT @message;

-- Student failed more than 2 units and tries to apply for advance unit
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (10048, 'Tony Stark', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT305', 'Advanced AI Concepts', 'YES', 50, '2024-02-20');

INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) 
VALUES 
(10048, 'IT101', '2023S1', 40.00, 'active'),
(10048, 'IT102', '2023S1', 35.00, 'active'),
(10048, 'IT103', '2023S1', 45.00, 'active');

INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES (10048, '2023S1', 7000.00, 'PAID', 'Tuition Fee');

CALL EnrollInUnit(10048, 'IT305', '2024S1', @message);
SELECT @message;


-- Student Dropping a Unit Before the No-Penalty Deadline and Re-Registering in the Next Semester
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (20011, 'Hamster Nu', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) 
VALUES ('IT104', 'Software Engineering', 'NO', 35, '2023-02-20');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) 
VALUES (20011, 'IT104', '2023S1', '2023-01-15', '2023-02-12', '2023-02-10', 'dropped_without_penalty');  

CALL EnrollInUnit(20011, 'IT104', '2024S1', @message);
SELECT @message;


-- student who is already enrolled in 6 units
INSERT INTO Student (student_id, student_name, is_current) VALUES (30000, 'Fluffy kook', 'YES');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, status) VALUES
(30000, 'IT101', '2024S1', '2023-02-19', 'active'),
(30000, 'IT102', '2024S1', '2023-02-19', 'active'),
(30000, 'IT103', '2024S1', '2023-02-19', 'active'),
(30000, 'IT401', '2024S1', '2023-02-19', 'active'),
(30000, 'IT402', '2024S1', '2023-02-19', 'active'),
(30000, 'IT403', '2024S1', '2023-02-19', 'active');

CALL EnrollInUnit(30000, 'IT105', '2024S1', @message);
SELECT @message;  



-- Student who is enrolled in 2 advanced units and 2 non-advanced units and tries to enroll another advance unit
INSERT INTO Student (student_id, student_name, is_current) VALUES (30001, 'Hamburger e', 'YES');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, status) VALUES
(30001, 'IT101', '2024S1', '2023-01-15', 'active'),
(30001, 'IT102', '2024S1', '2023-01-15', 'active'),
(30001, 'IT401', '2024S1', '2023-01-15', 'active'),
(30001, 'IT402', '2024S1', '2023-01-15', 'active');


CALL EnrollInUnit(30001, 'IT403', '2024S1', @message);
SELECT @message;  


-- Enrolled exactly 6 units with 2 being advanced unit
INSERT INTO Student (student_id, student_name, is_current) 
VALUES (30003, 'Angela per', 'YES');

INSERT INTO Registration (student_id, unit_code, semester, registration_date, status) VALUES
(30003, 'IT101', '2024S1', '2023-01-15', 'active'),
(30003, 'IT102', '2024S1', '2023-01-15', 'active'),
(30003, 'IT103', '2024S1', '2023-01-15', 'active'),
(30003, 'IT401', '2024S1', '2023-01-15', 'active'),
(30003, 'IT402', '2024S1', '2023-01-15', 'active');

CALL EnrollInUnit(30003, 'IT105', '2024S1', @message);
SELECT @message;  







-- TASK 2
select * from registration;
DELIMITER //
DROP FUNCTION IF EXISTS GetStudentOutstandingBalance;
CREATE FUNCTION GetStudentOutstandingBalance(studentId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_balance DECIMAL(10, 2) DEFAULT 0;
    DECLARE unit_penalty DECIMAL(10, 2);
    DECLARE tuition_fee DECIMAL(10, 2);
    DECLARE late_enrollment_penalty INT DEFAULT 0;

    -- 1# Calculate unpaid tuition fees for active units 
    SELECT IFNULL(SUM(fee_amount), 0) INTO tuition_fee
    FROM Fee f
    JOIN Registration r ON f.student_id = r.student_id AND f.semester = r.semester
    WHERE f.student_id = studentId 
      AND f.status = 'unpaid'
      AND r.status != 'dropped_with_penalty';  -- Exclude dropped units with penalty

    -- Add unpaid tuition fees for active units to total balance
    SET total_balance = total_balance + tuition_fee;

    -- 2# Calculate penalties for dropped units with penalty (only apply penalty, not tuition fee)
    SELECT SUM(
        CASE 
            WHEN u.is_advanced = 'YES' THEN 600  -- Penalty : advanced units
            ELSE 400  -- Penalty : non-advanced units
        END
    ) INTO unit_penalty
    FROM Registration r
    JOIN Unit u ON r.unit_code = u.unit_code
    WHERE r.student_id = studentId
      AND r.status = 'dropped_with_penalty';

    -- Add penalty for dropped units to total balance
    SET total_balance = total_balance + IFNULL(unit_penalty, 0);

    -- 3# Calculate late enrollment penalty based on both registration and unit no-penalty deadline
    SELECT COUNT(*)
    INTO late_enrollment_penalty
    FROM Registration r
    JOIN Unit u ON r.unit_code = u.unit_code
    WHERE r.student_id = studentId
    AND r.registration_date > u.registration_date;  -- Compare student's registration to unit's registration date

    -- Add late enrollment penalty if applicable
    IF late_enrollment_penalty > 0 THEN
        -- Late enrollment penalty is 200 for both advanced and non-advanced units
        SET total_balance = total_balance + (late_enrollment_penalty * 200);
    END IF;

    -- Return the total outstanding balance
    RETURN total_balance;
END;
//
DELIMITER ;


-- task 3

DELIMITER //
DROP PROCEDURE IF EXISTS EnrollInUnit;

CREATE PROCEDURE EnrollInUnit (
    IN p_student_id INT,
    IN p_unit_code VARCHAR(15),
    IN p_semester VARCHAR(15),
    OUT p_message VARCHAR(255)
)
EnrollBlock: BEGIN
    DECLARE v_outstanding_balance DECIMAL(10, 2);
    DECLARE v_failed_units INT;
    DECLARE v_is_advanced ENUM('YES', 'NO');
    DECLARE v_no_penalty_deadline DATE;
    DECLARE v_dropped_out_date DATE;
    DECLARE v_penalty_amount DECIMAL(10, 2) DEFAULT 0;
    DECLARE v_enrollment INT;
    DECLARE v_total_units INT;
    DECLARE v_advanced_units INT;

    -- Error Handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Rollback in case of error
        SET p_message = 'Unable to process enrollment due to an error.';
        ROLLBACK;
    END;

    -- Start Transaction
    START TRANSACTION;

    -- Step 1: Check student's outstanding balance 
    SELECT GetStudentOutstandingBalance(p_student_id) INTO v_outstanding_balance;

    IF v_outstanding_balance > 0 THEN
        SET p_message = 'Student cannot enroll due to outstanding balance.';
        ROLLBACK;
        LEAVE EnrollBlock;
    END IF;

    -- Step 2: Check if the student is already enrolled in the same unit and semester 
    IF EXISTS (SELECT 1 FROM Registration WHERE student_id = p_student_id AND unit_code = p_unit_code AND semester = p_semester) THEN
        SET p_message = 'Student already enrolled in this unit for the same semester.';
        ROLLBACK;
        LEAVE EnrollBlock;  
    END IF;

    -- Step 3: Check if the student failed more than 2 units 
    SELECT COUNT(*) INTO v_failed_units
    FROM UnitGrade
    WHERE student_id = p_student_id AND marks < 50;

    IF v_failed_units > 2 THEN
        SET p_message = 'Student has failed more than 2 units. Cannot enroll in advanced-level units.';
        ROLLBACK;
        LEAVE EnrollBlock;  
    END IF;

    -- Step 4: Check if the student is enrolling in an advanced unit 
    SELECT is_advanced INTO v_is_advanced
    FROM Unit
    WHERE unit_code = p_unit_code;

    IF v_is_advanced = 'YES' AND v_failed_units > 2 THEN
        SET p_message = 'Ineligible to enroll in advanced units due to failed units.';
        ROLLBACK;
        LEAVE EnrollBlock;  
    END IF;

    -- Step 5: Check if the student is already enrolled in too many units (Max 6 units per sem) and Max 2 advanced units
    SELECT COUNT(*) INTO v_total_units
    FROM Registration
    WHERE student_id = p_student_id AND semester = p_semester;

    SELECT COUNT(*) INTO v_advanced_units
    FROM Registration r
    JOIN Unit u ON r.unit_code = u.unit_code
    WHERE r.student_id = p_student_id AND r.semester = p_semester AND u.is_advanced = 'YES';

    IF v_total_units >= 6 THEN
        SET p_message = 'Too many units trying to register. You can only enroll in up to 6 units per semester.';
        ROLLBACK;
        LEAVE EnrollBlock;  
    END IF;

    IF v_is_advanced = 'YES' AND v_advanced_units >= 2 THEN
        SET p_message = 'Cannot enroll in more than 2 advanced-level units per semester.';
        ROLLBACK;
        LEAVE EnrollBlock;  
    END IF;

    -- Step 6: Add penalty for dropping units after no-penalty deadline 
    SELECT no_penalty_deadline, dropped_out_date INTO v_no_penalty_deadline, v_dropped_out_date
    FROM Registration
    WHERE student_id = p_student_id AND unit_code = p_unit_code AND status = 'dropped_with_penalty';

    IF v_dropped_out_date IS NOT NULL AND v_no_penalty_deadline IS NOT NULL AND v_dropped_out_date > v_no_penalty_deadline THEN
        IF v_is_advanced = 'YES' THEN
            SET v_penalty_amount = 600;  -- Penalty: advanced unit
        ELSE
            SET v_penalty_amount = 400;  -- Penalty: non-advanced unit
        END IF;

        -- Apply penalty to student fee
        UPDATE Fee
        SET fee_amount = fee_amount + v_penalty_amount
        WHERE student_id = p_student_id AND semester = p_semester;
    END IF;

    -- Step 7: Check if units have available seats 
    SELECT enrollment INTO v_enrollment
    FROM Unit
    WHERE unit_code = p_unit_code;

    IF v_enrollment >= 200 THEN -- Assume the maximum capacity is 200
        SET p_message = 'No available seats for the unit.';
        ROLLBACK;
        LEAVE EnrollBlock;  
    END IF;

    -- Step 8: Register the student in the unit
    INSERT INTO Registration (student_id, unit_code, semester, registration_date, status)
    VALUES (p_student_id, p_unit_code, p_semester, CURDATE(), 'active');

    -- Step 9: Update the unit enrollment count
    UPDATE Unit
    SET enrollment = enrollment + 1
    WHERE unit_code = p_unit_code;

    COMMIT;
    SET p_message = 'Student enrolled successfully.';
END //
DELIMITER ;




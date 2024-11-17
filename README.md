# 📚 Student Management System - SQL Implementation

This project demonstrates a SQL-based student management system for automating and managing critical tasks such as student registration, fee management, unit enrolment, and performance tracking. It is designed for an academic institution's streamlined operations with robust data integrity and business rule enforcement.

---

## 📄 Project Overview

### Features:
- **Student Information Management**: Store and update student details.
- **Unit Enrolment**: Handle unit registration, enforce business rules, and manage penalties.
- **Fee Tracking**: Automate fee management with dynamic outstanding balance calculations.
- **Performance Monitoring**: Maintain student grades and statuses for each unit and semester.

This project adheres to real-world scenarios and enforces business rules such as preventing enrolment for students with outstanding balances or excessive failed units.

---

## 🚀 How to Use

### Prerequisites:
- A SQL-compatible database system (e.g., MySQL).
- SQL client software to run the scripts.

### Steps to Run:
1. **Set Up the Database**:
   - Replace `COMP_47535032` with your unit code and student ID, e.g., `COMP2350_123456`.
   - Run the `create database` and `use` commands to create and use the database.

2. **Create Tables**:
   - Execute the table creation statements to set up the database schema.

3. **Insert Data**:
   - Populate the tables with provided sample data for testing.

4. **Execute Functions and Procedures**:
   - Use the custom SQL function `GetStudentOutstandingBalance` to calculate outstanding balances.
   - Use the `EnrollInUnit` procedure to handle student enrolments and enforce business rules dynamically.

---

## 📑 File Breakdown

### Database Schema:
1. **Student Table**: Stores student information (e.g., ID, name, current status).
2. **Unit Table**: Contains unit details (e.g., code, name, advanced-level indicator).
3. **Registration Table**: Tracks unit registrations with penalties and statuses.
4. **UnitGrade Table**: Maintains student grades and statuses for units.
5. **Fee Table**: Manages fees, including penalties for late enrolments or dropped units.

### Key Scripts:
- **`GetStudentOutstandingBalance` (Function)**:
  - Calculates a student’s total outstanding balance, including unpaid tuition and penalties for dropped or late-enrolled units.

- **`EnrollInUnit` (Procedure)**:
  - Handles unit enrolments while enforcing business rules:
    - Ensures no outstanding balance.
    - Prevents enrolment for students with excessive failed units.
    - Updates penalties for dropped units beyond no-penalty deadlines.
    - Checks unit capacity before enrolment.

---

## 📊 Features and Business Rules

### Business Rules:
1. A student cannot enrol if they have an outstanding balance.
2. Failed more than two units? Advanced-level unit enrolments are restricted.
3. Students cannot re-enrol in the same unit for the same semester.
4. Dropped units beyond the no-penalty deadline incur penalties.
5. Unit capacity is enforced (maximum enrolment: 200).

### Advanced Features:
- Real-time penalty calculation for late enrolments.
- Dynamic updates to fees and enrolment statuses based on student actions.
- Structured data model with foreign key relationships ensuring data consistency.

---

## 🔧 Technologies Used
- **Database Management System**: MySQL
- **Language**: SQL
- **Key Concepts**: Stored procedures, functions, triggers, ENUM data type, and transactions.

---

## 📖 Learnings and Insights
This project highlights:
- Database schema design and normalization.
- Advanced SQL features for automating workflows.
- Error handling and transaction management in SQL.
- Enforcement of real-world business rules using stored procedures and functions.

---

DROP DATABASE IF EXISTS personnel;
CREATE DATABASE personnel CHARACTER SET utf8mb4;
USE personnel;


CREATE TABLE users(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN','EMP') DEFAULT 'EMP',
    employee_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_employee_id(employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE employees(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    emp_no VARCHAR(50) UNIQUE,
    name VARCHAR(100) NOT NULL,
    dept VARCHAR(100),
    position VARCHAR(100),
    phone VARCHAR(100),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE leave_requests(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    leave_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    days INT,
    reason TEXT,
    status ENUM('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
    apply_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_leave_employee(employee_id),
    CONSTRAINT fk_leave_emp FOREIGN KEY (employee_id) REFERENCES employees(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE salaries(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    base_salary DECIMAL(10,2) DEFAULT 0.00,
    bonus DECIMAL(10,2) DEFAULT 0.00,
    tax DECIMAL(10,2) DEFAULT 0.00,
    pay_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_salary_emp(employee_id),
    CONSTRAINT fk_salary_emp FOREIGN KEY (employee_id) REFERENCES employees(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE suggestion(
    suggestionID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    suggestionTitle VARCHAR(100) NOT NULL,
    suggestionContent TEXT NOT NULL,
    submitTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    employee_id INT,
    INDEX idx_suggestion_emp(employee_id),
    CONSTRAINT fk_suggestion_emp FOREIGN KEY (employee_id) REFERENCES employees(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO users(username, password, role)
VALUES ('11', '11', 'ADMIN');

INSERT INTO users(username, password, role)
VALUES ('22', '22', 'EMP');
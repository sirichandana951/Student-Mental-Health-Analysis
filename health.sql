Drop table if exists students;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    age INT CHECK (age BETWEEN 16 AND 30),
    department VARCHAR(50),
    year_of_study INT CHECK (year_of_study BETWEEN 1 AND 5),
    hostel_resident BOOLEAN,
    cgpa DECIMAL(3,2) CHECK (cgpa BETWEEN 0 AND 10)
);
-- Mental Health Table
CREATE TABLE mental_health (
    record_id INT PRIMARY KEY,
    student_id INT,
    stress_level INT,
    depression_level INT,
    anxiety_level INT,
    sleep_hours DECIMAL(3,1),
    counseling BOOLEAN
);

-- Lifestyle Table
CREATE TABLE lifestyle (
    lifestyle_id INT PRIMARY KEY,
    student_id INT,
    exercise_hours DECIMAL(3,1),
    screen_time DECIMAL(3,1),
    social_support INT
);

-- Academics Table
CREATE TABLE academics (
    academic_id INT PRIMARY KEY,
    student_id INT,
    attendance INT,
    study_hours DECIMAL(3,1)
);
select *from students;
SELECT COUNT(*) FROM students;
SELECT COUNT(*) FROM mental_health;
SELECT COUNT(*) FROM lifestyle;
SELECT COUNT(*) FROM academics;
SELECT * FROM students WHERE name IS NULL OR cgpa IS NULL;
SELECT student_id, COUNT(*)
FROM students
GROUP BY student_id
HAVING COUNT(*) > 1;
ALTER TABLE mental_health
ADD CONSTRAINT fk_mental
FOREIGN KEY (student_id)
REFERENCES students(student_id);

ALTER TABLE lifestyle
ADD CONSTRAINT fk_lifestyle
FOREIGN KEY (student_id)
REFERENCES students(student_id);

ALTER TABLE academics
ADD CONSTRAINT fk_academic
FOREIGN KEY (student_id)
REFERENCES students(student_id);

SELECT s.department,
       ROUND(AVG(m.stress_level),2) AS avg_stress
FROM students s
JOIN mental_health m
ON s.student_id = m.student_id
GROUP BY s.department
ORDER BY avg_stress DESC;
SELECT m.sleep_hours,
       ROUND(AVG(s.cgpa),2) AS avg_cgpa
FROM students s
JOIN mental_health m
ON s.student_id = m.student_id
GROUP BY m.sleep_hours
ORDER BY m.sleep_hours;
SELECT s.name,
       m.stress_level,
       m.depression_level,
       m.anxiety_level
FROM students s
JOIN mental_health m
ON s.student_id = m.student_id
WHERE m.stress_level >= 8
  AND m.depression_level >= 7;

SELECT s.hostel_resident,
       ROUND(AVG(m.stress_level),2) AS avg_stress
FROM students s
JOIN mental_health m
ON s.student_id = m.student_id
GROUP BY s.hostel_resident;
SELECT l.exercise_hours,
       ROUND(AVG(m.stress_level),2) AS avg_stress
FROM lifestyle l
JOIN mental_health m
ON l.student_id = m.student_id
GROUP BY l.exercise_hours
ORDER BY l.exercise_hours;
CREATE VIEW high_risk_students AS
SELECT s.student_id,
       s.name,
       m.stress_level,
       m.depression_level
FROM students s
JOIN mental_health m
ON s.student_id = m.student_id
WHERE m.stress_level >= 8;
SELECT * FROM high_risk_students;
CREATE INDEX idx_student_id ON mental_health(student_id);
CREATE INDEX idx_dept ON students(department);




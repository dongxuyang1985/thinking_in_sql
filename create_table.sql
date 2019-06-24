-- 创建 3 个示例表
CREATE TABLE department
    ( dept_id    INTEGER NOT NULL PRIMARY KEY
    , dept_name  VARCHAR(50) NOT NULL
    ) ;
CREATE TABLE job
    ( job_id         INTEGER NOT NULL PRIMARY KEY
    , job_title      VARCHAR(50) NOT NULL
    ) ;
CREATE TABLE employee
    ( emp_id    INTEGER NOT NULL PRIMARY KEY
    , emp_name  VARCHAR(50) NOT NULL
    , sex       VARCHAR(10) NOT NULL
    , dept_id   INTEGER NOT NULL
    , manager   INTEGER
    , hire_date DATE NOT NULL
    , job_id    INTEGER NOT NULL
    , salary    NUMERIC(8,2) NOT NULL
    , bonus     NUMERIC(8,2)
    , email     VARCHAR(100) NOT NULL
    , CONSTRAINT ck_emp_sex CHECK (sex IN ('男', '女'))
    , CONSTRAINT ck_emp_salary CHECK (salary > 0)
    , CONSTRAINT uk_emp_email UNIQUE (email)
    , CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    , CONSTRAINT fk_emp_job FOREIGN KEY (job_id) REFERENCES job(job_id)
    , CONSTRAINT fk_emp_manager FOREIGN KEY (manager) REFERENCES employee(emp_id)
    ) ;
CREATE INDEX idx_emp_name ON employee(emp_name);
CREATE INDEX idx_emp_dept ON employee(dept_id);
CREATE INDEX idx_emp_job ON employee(job_id);
CREATE INDEX idx_emp_manager ON employee(manager);

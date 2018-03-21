DROP TABLE IF EXISTS datascience;
DROP TABLE IF EXISTS teaching;
DROP TABLE IF EXISTS algorithm;
DROP TABLE IF EXISTS method;
DROP TABLE IF EXISTS tool;

CREATE TABLE datascience (
  id INTEGER PRIMARY KEY NOT NULL,
  gender VARCHAR(255) NOT NULL,
  country VARCHAR(255),
  age VARCHAR(255),
  employment_status VARCHAR(255),
  current_job_title VARCHAR(255),
  title_fit VARCHAR(255),
  past_job_title VARCHAR(255),
  current_employer_type VARCHAR(255),
  formal_education VARCHAR(255),
  major VARCHAR(255),
  tenure VARCHAR(255),
  first_training VARCHAR(255),
  employer_industry VARCHAR(255),
  employer_size VARCHAR(255),
  employer_size_change VARCHAR(255),
  employer_ml_time VARCHAR(255),
  empoyer_search_method VARCHAR(255),
  university_importance VARCHAR(255),
  job_function VARCHAR(255),
  remote_work VARCHAR(255),
  compensation_amount VARCHAR(255),
  compensation_currenty VARCHAR(255)
  );

CREATE TABLE teaching (
  id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  ds_id INTEGER NOT NULL,
  category VARCHAR(100) NOT NULL,
  percent INTEGER NOT NULL,
  foreign key(ds_id) references datascience(ds_id)
  );
  
LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\607project3\\tidied_csv\\learning_category.csv' 
INTO TABLE teaching
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(ds_id, category, percent)
;


CREATE TABLE algorithm(
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ds_id INTEGER NOT NULL,
    algorithm VARCHAR(255) NOT NULL,
    foreign key(ds_id) references datascience(ds_id)
    );
    
LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\607project3\\tidied_csv\\algorithms.csv' 
INTO TABLE algorithm
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(ds_id, algorithm)
;

CREATE TABLE method(
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ds_id INTEGER NOT NULL,
    datasetsize VARCHAR(50) NOT NULL,
    method VARCHAR(255) NOT NULL,
    frequency VARCHAR(50),
    foreign key(ds_id) references datascience(ds_id)
    );
    
LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\607project3\\tidied_csv\\methods.csv' 
INTO TABLE method
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(ds_id, datasetsize, method, @frequency)
SET 
frequency = nullif(@frequency,'NA')
;

CREATE TABLE tool(
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ds_id INTEGER NOT NULL,
    tool_name VARCHAR(255) NOT NULL,
    frequency VARCHAR(255) NOT NULL,
    foreign key(ds_id) references datascience(ds_id)
    );
    
LOAD DATA LOCAL INFILE 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\607project3\\tidied_csv\\tool_use.csv' 
INTO TABLE tool
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(ds_id, tool_name, frequency)
;
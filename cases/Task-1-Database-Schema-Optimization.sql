-- This whole scripts has been implemented on initdb folder, that initialize the database with whoever exists on this folder

-- Create Tables 

-- Suverys Table
CREATE TABLE surveys (
    survey_id SERIAL PRIMARY KEY,
    survey_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Questions Table
CREATE TABLE questions (
    question_id SERIAL PRIMARY KEY,
    survey_id INT REFERENCES surveys(survey_id),
    question_text TEXT NOT NULL
);

-- Users Table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) UNIQUE NOT NULL
);

-- Response Options to insert into Responses Table
CREATE TABLE response_options (
    response_text TEXT PRIMARY KEY,
    score INT
);
-- Responses Table
CREATE TABLE responses (
    response_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    question_id INT REFERENCES questions(question_id),
    response_text TEXT NOT NULL
);


-- Insert Data


-- Insert surveys's name on surveys table
INSERT INTO surveys (survey_name) VALUES 
('Customer Satisfaction Survey'), 
('Employee Feedback Survey'), 
('Product Feedback Survey');

-- Insert questions for each survey

-- Survey 1: Customer Satisfaction Survey
INSERT INTO questions (survey_id, question_text) VALUES
(1, 'How satisfied are you with our service?'),
(1, 'How likely are you to recommend our service to others?'),
(1, 'How would you rate our customer support?'),
(1, 'How would you rate the quality of our product?'),
(1, 'How likely are you to use our service again?');

-- Survey 2: Employee Feedback Survey
INSERT INTO questions (survey_id, question_text) VALUES
(2, 'How satisfied are you with your current job role?'),
(2, 'How would you rate the work-life balance at our company?'),
(2, 'How satisfied are you with the management?'),
(2, 'How would you rate the career development opportunities?'),
(2, 'How likely are you to recommend our company as a good place to work?');

-- Survey 3: Product Feedback Survey
INSERT INTO questions (survey_id, question_text) VALUES
(3, 'How satisfied are you with the product quality?'),
(3, 'How would you rate the product usability?'),
(3, 'How would you rate the product design?'),
(3, 'How likely are you to purchase our product again?'),
(3, 'How would you rate the value for money of our product?');

-- Insert sample data into users
INSERT INTO users (user_name, user_email) VALUES 
('Alice', 'alice@example.com'), 
('Bob', 'bob@example.com'), 
('Charlie', 'charlie@example.com');

-- Insert sample data into responses with their respective score or weight
DO $$
BEGIN
    INSERT INTO response_options (response_text, score) VALUES
    ('Very Satisfied', 5),
    ('Satisfied', 4),
    ('Neutral', 3),
    ('Dissatisfied', 2),
    ('Very Dissatisfied', 1),
    ('Very Likely', 5),
    ('Likely', 4),
    ('Unlikely', 2),
    ('Very Unlikely', 1),
    ('Excellent', 5),
    ('Good', 4),
    ('Average', 3),
    ('Poor', 2),
    ('Very Poor', 1),
    ('Yes', 5),
    ('No', 1);
    
END $$;

-- Insert responses for each question
DO $$
DECLARE
    question RECORD;
    user_id INT;
    response TEXT;
BEGIN
    -- Loop through each question
    FOR question IN (SELECT question_id FROM questions) LOOP
        -- Insert 30 responses for each question
        FOR i IN 1..30 LOOP
            user_id := (random() * 2 + 1)::INT; -- Select a random user_id between 1 and 3 (assuming we have 3 users)

            -- Select a random response from response_options table
            SELECT response_text INTO response
            FROM response_options
            ORDER BY random()
            LIMIT 1;

            -- Insert the response
            INSERT INTO responses (user_id, question_id, response_text)
            VALUES (user_id, question.question_id, response);
        END LOOP;
    END LOOP;
END $$;

-- Create indexes

-- Index on Survey to optimize queries with created_at
CREATE INDEX idx_surveys_created_at ON surveys (created_at);

-- Index on Survey to optimize queries with survey id
CREATE INDEX idx_questions_survey_id ON questions (survey_id);

-- Index on Survey to optimize queries with queries that includes joins between user_id and question_id
CREATE INDEX idx_responses_user_id ON responses (user_id);
CREATE INDEX idx_responses_question_id ON responses (question_id);

-- Index on Survey to optimize queries to use in a find_by_email case
CREATE INDEX idx_users_user_email ON users (user_email);

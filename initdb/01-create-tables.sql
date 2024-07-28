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

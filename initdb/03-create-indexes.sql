-- Index on Survey to optimize queries with created_at
CREATE INDEX idx_surveys_created_at ON surveys (created_at);

-- Index on Survey to optimize queries with survey id
CREATE INDEX idx_questions_survey_id ON questions (survey_id);

-- Index on Survey to optimize queries with queries that includes joins between user_id and question_id
CREATE INDEX idx_responses_user_id ON responses (user_id);
CREATE INDEX idx_responses_question_id ON responses (question_id);

-- Index on Survey to optimize queries to use in a find_by_email case
CREATE INDEX idx_users_user_email ON users (user_email);

-- Write a stored procedure that calculates the score for a survey based on responses.

CREATE OR REPLACE PROCEDURE calculate_survey_score(survey_id_input INT)
LANGUAGE plpgsql
AS $$
DECLARE
    total_score INT;
BEGIN
    -- Initialize wit 0 the total score
    total_score := 0;

    -- Calculate total score adding up the scores to the responses
    SELECT
        SUM(ro.score) INTO total_score
    FROM
        questions q
    JOIN
        responses r ON q.question_id = r.question_id
    JOIN
        response_options ro ON r.response_text = ro.response_text
    WHERE
        q.survey_id = survey_id_input;

    -- Create a temp table to store the total score
    CREATE TEMP TABLE IF NOT EXISTS survey_total_score (
        survey_id INT,
        total_score INT
    );

    -- Insert the total score on temp's table 
    INSERT INTO survey_total_score (survey_id, total_score)
    VALUES (survey_id_input, total_score);

    -- Print the total calculated score  
    RAISE NOTICE 'Total score for survey % is %', survey_id_input, total_score;
END;
$$;


-- Create a view that displays the survey name, question text, response text, and calculated score for each response.

CREATE OR REPLACE VIEW survey_responses_with_scores AS
SELECT
    s.survey_name,
    q.question_text,
    r.response_text,
    SUM(ro.score) AS total_score
FROM
    surveys s
JOIN
    questions q ON s.survey_id = q.survey_id
JOIN
    responses r ON q.question_id = r.question_id
JOIN
    response_options ro ON r.response_text = ro.response_text
GROUP BY
    s.survey_name, q.question_text, r.response_text, ro.score
order by 
	q.question_text;

    
SELECT * FROM survey_responses_with_scores WHERE survey_name = 'Customer Satisfaction Survey';

--Write a query to retrieve all responses for a given survey, including survey name, question text, and response text.

SELECT 
	s.survey_name as "Survey Name",
	q.question_text as "Question",
	r.response_text as "Response"
FROM 
	responses r 
INNER JOIN questions q ON r.question_id  = q.question_id 
INNER JOIN surveys s ON q.survey_id = s.survey_id 
WHERE s.survey_id  = 1;


-- Write a query to calculate the average score for each survey, grouped by survey name.

SELECT
    s.survey_name as "Survey Name",
    AVG(ro.score) as "Average Score"
FROM
    surveys s
JOIN
    questions q ON s.survey_id = q.survey_id
JOIN
    responses r ON q.question_id = r.question_id
JOIN
    response_options ro  ON r.response_text = ro.response_text
GROUP BY
    s.survey_name;
    

-- Write a query to find the top 3 users with the highest average response score across all surveys.
SELECT
    u.user_id as "User id",
    u.user_name as "Username",
    AVG(ro.score) as "Average Score"
FROM
    users u
JOIN
    responses r ON u.user_id = r.user_id
JOIN
    response_options ro ON r.response_text = ro.response_text
GROUP BY
    u.user_id, u.user_name
ORDER BY
    "Average Score" DESC
LIMIT 3;


-- Write a query to determine the distribution of responses for each question in a specific survey (e.g., count of each response).
SELECT
    q.question_text as "Question",
    r.response_text as "Response",
    COUNT(r.response_id) as "Response Count"
FROM
    questions q
JOIN
    responses r ON q.question_id = r.question_id
WHERE
    q.survey_id = 1  -- Especificar el survey_id aquí
GROUP BY
    q.question_text, r.response_text
ORDER BY
    q.question_text, response_count DESC;
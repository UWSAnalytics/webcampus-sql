SELECT distinct CONCAT(u.firstname, ' ', u.lastname) as "Student Name", c.shortname, u.idnumber, ml.module, ml.action, DATE_SUB(MAX(from_unixtime(ml.time)), INTERVAL 8 HOUR) as time
FROM mdl_log ml
JOIN mdl_user u ON ml.userid = u.id
JOIN mdl_course c ON ml.course = c.id

--  ---------------------v CHANGE
WHERE u.idnumber = 000000000
-- ---------------------^
AND ml.action IN ('add submission',
                     'mod_assign_submit_for_grading',
                     'mod_forum_add_discussion',
                     'mod_forum_add_discussion_post',
                     'mod_quiz_save_attempt',
                     'submit',
                     'submit for grading',
                     'attempt',
                     'mod_quiz_save_attempt',
                     'assign_submit for grading',
                     'continue attempt',
                     'add discussion',
                     'add post',
                     'attempt',
                     'update post')

AND DATE_SUB(from_unixtime(ml.time), INTERVAL 8 HOUR) > '2021-1-04 00:00:00'
GROUP BY c.shortname
ORDER BY ml.time DESC
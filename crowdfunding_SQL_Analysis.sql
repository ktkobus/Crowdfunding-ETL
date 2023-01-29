-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id, backers_count
INTO live_backer_counts
FROM campaign
WHERE (outcome = 'live')
ORDER BY backers_count DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT(b.backer_id), lbc.cf_id
INTO count_confirmation
FROM backers as b
LEFT JOIN live_backer_counts as lbc
ON b.cf_id = lbc.cf_id
GROUP BY lbc.cf_id
ORDER BY COUNT DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT c.first_name,
	c.last_name,
	c.email,
	cp.goal - cp.pledged as "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts as c
LEFT JOIN campaign as cp
ON c.contact_id = cp.contact_id
WHERE (cp.outcome = 'live')
ORDER BY "Remaining Goal Amount" DESC;


-- Check the table
SELECT *
FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT b.email
    b.first_name,
	b.last_name,
    c.cf_id,
    c.company_name,
    c.description,
    c.end_date,
	c.goal - c.pledged as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as b
LEFT JOIN campaign as c
ON b.cf_id = c.cf_id
WHERE (c.outcome = 'live')
ORDER BY b.email DESC;

-- Check the table
SELECT *
FROM email_backers_remaining_goal_amount;


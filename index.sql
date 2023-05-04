-- Heaviest Hitters

SELECT 
	AVG(people.weight), 
	teams.name, 
	batting.yearid 
FROM people 
INNER JOIN batting 
	ON people.playerid = batting.playerid
INNER JOIN teams
	ON batting.team_id = teams.id
GROUP BY 
	teams.name,
	batting.yearid
ORDER BY
	AVG(people.weight) 
	DESC;

-- Above, takes the average of the weight, found in the people table, then the team name and batting year. Starting with people, joins batting, then teams, using the id to match
-- Groups by the team name 1st, then the year (in ASC order)
-- Orders by the average weight, highest 1st

-- Shortest Sluggers

SELECT 
	AVG(people.height), 
	teams.name, 
	batting.yearid 
FROM people 
INNER JOIN batting 
	ON people.playerid = batting.playerid
INNER JOIN teams 
	ON batting.team_id = teams.id
GROUP BY 
	teams.name, 
	batting.yearid
ORDER BY 
	AVG(people.height) 
	ASC;

-- above, similar to above, takes av height, teams.name and batting year, merges the 3 tables together and groups by teamname, then batting year, then orders by height, highest 1st

-- Biggest Spenders

SELECT 
	SUM(salary), 
	teams.name, 
	salaries.yearid 
FROM salaries
LEFT JOIN teams 
	ON teams.teamid = salaries.teamid 
	AND teams.yearid = salaries.yearid
GROUP BY 
	teams.name, 
	salaries.yearid
ORDER BY
	SUM(salary) 
	DESC;

-- Takes total sum of salary, plus team name and salary year,then joins salaries and teams, matching team and salary id columns. Groups by team and salary year, orders by salary sum, highest 1st

-- Most Bang For Their Buck

SELECT 
	ROUND(SUM(salary)/teams.w),
	teams.w,
	teams.name,
	salaries.yearid 
FROM salaries
LEFT JOIN teams 
	ON teams.teamid = salaries.teamid 
	AND teams.yearid = salaries.yearid
WHERE teams.yearid = 2010
GROUP BY 
	teams.name, 
	salaries.yearid, 
	teams.w
ORDER BY 
	SUM(salary)/teams.w 
	ASC;

-- above, takes the cost per win (line 1) and other columns, joints salaries to teams on team and salary id (like above example.) Then, limits results to 2010, grouping by team, salary id then wins, ordering by cost per win

-- Priciest Starters

SELECT 
	people.namefirst,
	people.namelast, 
	salaries.salary/pitching.g as cost_per_game, 
	salaries.yearid, 
	pitching.g
FROM salaries 
INNER JOIN pitching 
	ON salaries.playerid = pitching.playerid 
	AND salaries.yearid = pitching.yearid 
	AND salaries.teamid = pitching.teamid 
INNER JOIN people 
	ON salaries.playerid = people.playerid
WHERE pitching.g > 10
ORDER BY 
	cost_per_game 
	DESC;

-- takes pitcher info, cost_per_game calculation, etc, then joins salaries and pitching, matching on playerid, yearid and teamid. Then joins the people table on player id (limiting to those who played at least 10 times) then orders by cost per game alias

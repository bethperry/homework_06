--Write a query to select all of the columns in the tutorial.us_housing_units table without using *.

SELECT
  year
  , month
  , month_name
  , south
  , west
  , midwest
  , northeast
FROM tutorial.us_housing_units

--This query selects each individual column from the us_housing_units table within the tutorial schema.


--Write a query to select all of the columns in tutorial.us_housing_units and rename them so that their first letters are capitalized.

SELECT
  year AS "Year"
  , month AS "Month"
  , month_name AS "MonthName"
  , south AS "South"
  , west AS "West"
  , midwest AS "Midwest"
  , northeast AS "Northeast"
FROM tutorial.us_housing_units

--I have aliased each query with double-quotes so that the first letters of each column name are capitalized.


--Write a query that uses the LIMIT command to restrict the result set to only 15 rows.

SELECT *
FROM tutorial.us_housing_units
LIMIT 15

--The LIMIT 15 operator tells Mode to return only the first 15 results



--Did the West Region ever produce more than 50,000 housing units in one month?

SELECT *
FROM tutorial.us_housing_units
WHERE west > 50
--yes, three times: 
--June 1978 = 50,500
--August 1978 = 51,800
--December 2004 = 54,200

--I filtered the us_housing_units table to only records where the west column was greater than 50. 
--Since the units are recorded in tens of thousands, this is the equivalent of filtering to where the west units were greater than 50,000



--Did the South Region ever produce 20,000 or fewer housing units in one month?

SELECT * 
FROM tutorial.us_housing_units
WHERE south <= 20
--yes, 4 times:
--January 2011 = 17,300
--May 2011 = 20,000
--January 2012 = 18,800
--February 2012 = 19,900

--I filtered the us_housing_units table to only records where the south column was less than or equal to 20 (x 1,000) units



--Write a query that only shows rows for which the month name is February.

SELECT *
FROM tutorial.us_housing_units
WHERE month_name = 'February'

--The equals operator allows me to match only rows where the month_name is exactly "February"



--Write a query that only shows rows for which the month_name starts with the letter "N" or an earlier letter in the alphabet.

SELECT *
FROM tutorial.us_housing_units
WHERE LEFT(month_name, 1) <= 'N'

--This query looks at the first letter of the month_name (LEFT(month_name, 1)) and does an alphabetic comparison on it
--If the first letter of the month is 'N' or earlier in the alphabet, it gets returned; if it is 'O' or later in the alphabet, it does not



--Write a query that calculates the sum of all four regions in a separate column.

SELECT
  year
  , month
  , south + west + midwest + northeast AS region_total
FROM tutorial.us_housing_units

--I added the four region columns together to get the overall monthly total



--Write a query that returns all rows for which more units were produced in the West region than in the Midwest and Northeast combined.

SELECT *
FROM tutorial.us_housing_units
WHERE west > (midwest + northeast)

--This compares the number in the west column with the sum of the numbers from the midwest and northeast columns.
--If the west number is larger, that means the west region produced more units than the midwest and northeast combined.



--Write a query that calculates the percentage of all houses completed in the United States represented by each region. Only return results from the year 2000 and later.

--Hint: There should be four columns of percentages.

SELECT
  year
  , month
  , month_name
  , south / (south + west + midwest + northeast) AS south_pct
  , west / (south + west + midwest + northeast) AS west_pct
  , midwest / (south + west + midwest + northeast) AS midwest_pct
  , northeast / (south + west + midwest + northeast) AS northeast_pct
FROM tutorial.us_housing_units
WHERE year >= 2000

--To get the percentages, I divided each region's column by the total of all regions



--Write a query that returns all rows for which Ludacris was a member of the group.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" ILIKE '%Ludacris%'

--ILIKE does a case insensitive match on the group column for the string value 'Ludacris'
--The search is "contains"-style because I added wildcards (%) to both ends of the string



--Write a query that returns all rows for which the first artist listed in the group has a name that begins with "DJ".

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" ILIKE 'DJ%'

--This query performs a case-insensitive "starts with"-style search on the group column to bring back rows where the name of the first artist listed starts with "DJ"



--Write a query that shows all of the entries for Elvis and M.C. Hammer.

--Hint: M.C. Hammer is actually on the list under multiple names, so you may need to first write a query to figure out exactly how M.C. Hammer is listed. You're likely to face similar problems that require some exploration in many real-life scenarios.

--First I wrote these two queries to identify how M.C. Hammer and Elvis are listed in the table.
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist ILIKE '%hammer%'   --I opted to search for "hammer" because I believed most of the variation would be with the way the periods were used in M.C. (M.C., MC, MC.)
--M.C. Hammer is listed as:
--M.C. Hammer
--Hammer

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist ILIKE '%elvis%'
--ELvis is just listed as Elvis Presley

SELECT * 
FROM tutorial.billboard_top_100_year_end
WHERE artist IN ('M.C. Hammer', 'Hammer', 'Elvis Presley')

--After identifying the ways M.C. Hammer and Elvis are listed in the table, I used an IN statement to bring back all the records where any of those values are in the artist column.



--Write a query that shows all top 100 songs from January 1, 1985 through December 31, 1990.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year BETWEEN 1985 AND 1990

--Technically, the table doesn't give you the intra-year rank of the top 100 songs. 
--There may be songs that ranked in the top 100 during the year that did not make the year end chart.
--However, I believe this query answers the spirit of the question, using a BETWEEN statement to get all the records listed on the Top 100 Year End chart for the years 1985-1990 (inclusive)



--Write a query that shows all of the rows for which song_name is null.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE song_name IS NULL

--The IS NULL operator allows me to filter to only records where the song_name field has no value (NULL)



--Write a query that surfaces all rows for top-10 hits for which Ludacris is part of the Group.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank <= 10
   AND "group" ILIKE '%ludacris%'

--I used the AND operator to combine the two requirements
--year_rank <= 10 gets songs in the Top 10
--"group" ILIKE '%ludacris%' performs a case-insensitive match on the "group" column to find records where Lundacris was part of the group



--Write a query that surfaces the top-ranked records in 1990, 2000, and 2010.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank = 1
   AND year IN (1990, 2000, 2010)

--This query also uses the AND operator to get the top ranked song in each of the 3 years listed



--Write a query that lists all songs from the 1960s with "love" in the title.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year BETWEEN 1960 AND 1969
   AND song_name ILIKE '%love%'

--I used the BETWEEN operator to get all the years between 1960 and 1969 (the 1960s)
--I used the ILIKE operator to do a case-insensitive contains-style search for song titles with "love" in them
--The AND operator requires that both conditions match (1960s and "love" in the title)



--Write a query that returns all rows for top-10 songs that featured either Katy Perry or Bon Jovi.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank <= 10
   AND ("group" ILIKE '%katy perry%' OR "group" ILIKE '%bon jovi%')

--This query filters the results to only songs ranked in the top 10 (year_rank <= 10) where the "group" contains either "Katy Perry" or "Bon Jovi"
--I prefer the case-insensitive match because:
--1) My background is in T-SQL with databases where the collation has been set to case-insensitive (so I'm used to CI-searches)
--2) I don't trust users to enter data cleanly; if the data accidentally got typed in 'katy perry' then the LIKE operator would not find it



--Write a query that returns all songs with titles that contain the word "California" in either the 1970s or 1990s.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE song_name ILIKE '%california%'
   AND (year BETWEEN 1970 AND 1979 OR year BETWEEN 1990 AND 1999)

--This query demonstrates use of the AND and OR operators together
--The parentheses are necessary here to ensure the conditions get evaluated in the order I want
--I could rewrite it so the parentheses aren't strictly necessary to get the "right" answer, but they are still helpful for readability



--Write a query that lists all top-100 recordings that feature Dr. Dre before 2001 or after 2009.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" ILIKE '%dr%dre%'
   AND (year < 2001 OR year > 2009)

--Here I used the ILIKE operator and multiple wildcards to look for records where Dr. Dre was in the group.
--I opted to use the additional wildcard in case the period was not included (back to that distrust of the data entry process)
--The year filters select records where the year is before 2001 or after 2009



--Write a query that returns all rows for songs that were on the charts in 2013 and do not contain the letter "a".

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
   AND song_name NOT LIKE '%a%'

--The main purpose of this query was to show how the NOT operator is used to return records where the specified condition is not true



--Write a query that returns all rows from 2012, ordered by song title from Z to A.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2012
ORDER BY song_name DESC

--The DESC operator sorts from Z to A. 



--Write a query that returns all rows from 2010 ordered by rank, with artists ordered alphabetically for each song.

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2010
ORDER BY year_rank, artist

--Multiple ORDER BY fields can be specified by adidng a comma between them (in this case, rank (1-100), followed by artist name (A-Z))



--Write a query that shows all rows for which T-Pain was a group member, ordered by rank on the charts, from lowest to highest rank (from 100 to 1).

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" ILIKE '%t-pain%'
ORDER BY year_rank DESC

--I got the records where T-Pain was a group member using the ILIKE operator to do a contains search on the group column.
--Then I ordered from 100 to 1 on the year_rank column using the DESC operator.
--As a side note, it's bad practice to create table or column names in SQL that are the same as a SQL function name.
--Hopefully the "group" column is only so named so Mode could teach us all this valuable lesson, but if not, please call it out in our class discussion time.
--We had a table named Case at my work, which of course was a pain any time we had to select from it or wanted to write a CASE statement.
--In a corporate setting, table names generally aren't that simple to change once they're in production, so selecting a proper name is an important decision.



--Write a query that returns songs that ranked between 10 and 20 (inclusive) in 1993, 2003, or 2013. 
--Order the results by year and rank, and leave a comment on each line of the WHERE clause to indicate what that line does

SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank BETWEEN 10 AND 20 --return songs ranked between 10 and 20 (inclusive)
  AND year IN (1993, 2003, 2013)  --look at years 1993, 2003, 2013 only
ORDER BY year, year_rank

--This is a general rule I use when writing SQL for work:
--List each WHERE condition on a separate line
--Include a comment as to why you're filtering that way
--Since I often have to read SQL written by others, this really helps me understand what they're trying to accomplish with their query 
--(and whether what they've stated they are doing is actually what they've done)
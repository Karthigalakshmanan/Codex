select * from dim_cities;
select * from dim_repondents;
select * from fact_survey_responses;

-- Primary Insights --

-- 1. Demographic Insights --

-- a.Who prefers energy drink more? (male/female/non-binary?) --
select gender, count(Respondent_ID) as count_pre from dim_repondents
group by Gender order by count_pre desc;

-- b.Which age group prefers energy drinks more?--
select  age,count(Respondent_ID) as count_pre from dim_repondents
group by age order by age ;

-- c.Which type of marketing reaches the most Youth (15-30)? --
select f.Marketing_channels,count(*) from fact_survey_responses f
join dim_repondents r on f.Respondent_ID=r.Respondent_ID
where r.age in ("15-18","19-30")
group by f.Marketing_channels;

-- 2. Consumer Preferences --

-- a. What are the preferred ingredients of energy drinks among respondents?--
select count(Respondent_ID) as Response_count,Ingredients_expected from fact_survey_responses
 group by Ingredients_expected order by Response_count desc;
;

-- b. What packaging preferences do respondents have for energy drinks?--
select count(Respondent_ID) as Total_count,Packaging_preference from fact_survey_responses
group by Packaging_preference order by Total_count desc;

-- 3. Competition Analysis:--

-- a.Who are the current market leaders? --
select distinct(current_brands)  from fact_survey_responses;

-- b. What are the primary reasons consumers prefer those brands over ours?--
select count(Respondent_ID) as total_count,Reasons_for_choosing_brands from fact_survey_responses
group by Reasons_for_choosing_brands order by total_count desc;

-- 4. Marketing Channels and Brand Awareness: --

-- a. Which marketing channel can be used to reach more customers? --
select count(Respondent_ID) as total_count,Marketing_channels from fact_survey_responses
group by Marketing_channels order by total_count desc;

/* b. How effective are different marketing strategies
 and channels in reaching our customers? */
 select count(Respondent_ID) as total_count,Marketing_channels
 from fact_survey_responses
 where Current_brands="Codex"
group by Marketing_channels order by total_count desc ;

-- 5. Brand Penetration: --
-- a. What do people think about our brand? (overall rating)

-- Taste Experience--
SELECT 
    COUNT(Respondent_ID) AS total_count, Taste_experience
FROM
    fact_survey_responses
    where Current_brands="Codex"
GROUP BY Taste_experience
ORDER BY Taste_experience DESC;

-- b. Which cities do we need to focus more on? --
select  count(*) as Total_count,c.city,c.tier from fact_survey_responses fs
join dim_repondents r on fs.Respondent_ID=r.Respondent_ID
join dim_cities c on r.City_ID=c.City_ID
where fs.Current_brands="Codex" 
group by c.city order by Total_count Asc;

-- 6. Purchase Behavior: --

-- a. Where do respondents prefer to purchase energy drinks? --
SELECT 
    COUNT(Respondent_ID) AS total_count, Purchase_location
FROM
    fact_survey_responses
GROUP BY Purchase_location;

/* b. What are the typical consumption situations for energy drinks 
among respondents? */
SELECT 
    COUNT(Respondent_ID) AS total_count, Typical_consumption_situations
FROM
    fact_survey_responses
GROUP BY Typical_consumption_situations;

 /* c. What factors influence respondents' purchase decisions,
 such as price range and limited edition packaging? */
 
 SELECT 
    COUNT(Respondent_ID) AS total_count, Packaging_preference
FROM
    fact_survey_responses
GROUP BY Packaging_preference;

SELECT 
    COUNT(Respondent_ID) AS total_count, Price_range
FROM
    fact_survey_responses
GROUP BY Price_range;

SELECT 
    COUNT(Respondent_ID) AS total_count, Limited_edition_packaging
FROM
    fact_survey_responses
GROUP BY Limited_edition_packaging;

-- 7. Product Development --

/* a. Which area of business should we focus more 
on our product development? (Branding/taste/availability) */
SELECT 
    COUNT(Respondent_ID) AS total_count,
    Reasons_for_choosing_brands
FROM
    fact_survey_responses
WHERE
    Current_brands = 'Codex'
GROUP BY Reasons_for_choosing_brands
ORDER BY total_count DESC;

-- Secondary Insights --

-- What immediate improvements can we bring to the product? --
select count(Respondent_ID) as total_count,Improvements_desired
 from fact_survey_responses
 group by Improvements_desired
 order by total_count desc;
 
 select count(Respondent_ID) as total_count, Ingredients_expected
 from fact_survey_responses
 group by Ingredients_expected
 order by total_count desc;
 
 select count(Respondent_ID) as total_count,Interest_in_natural_or_organic
 from fact_survey_responses
 group by Interest_in_natural_or_organic
 order by total_count desc;
 
select count(Respondent_ID) as total_count,Health_concerns
 from fact_survey_responses
 group by Health_concerns
 order by total_count desc;
 
 select count(Respondent_ID) as total_count,Packaging_preference
 from fact_survey_responses
 group by Packaging_preference
 order by total_count desc;
 
 select count(Respondent_ID) as total_count,Brand_perception
 from fact_survey_responses
 where Current_brands="codex"
 group by Brand_perception
 order by total_count desc;
 
 -- What should be the ideal price of our product? --
 select count(Respondent_ID) as total_count,Price_range
 from fact_survey_responses
 where Current_brands="codex"
 group by Price_range
 order by total_count desc;
 
 --  What kind of marketing campaigns, offers, and discounts we can run?--
 Select count(Respondent_ID) as total_count,Marketing_channels
 from fact_survey_responses
 where Current_brands="codex"
 group by Marketing_channels
 order by total_count desc;
 
 --  Who can be a brand ambassador, and why? --
 
select count(Respondent_ID) as total_count,Purchase_location
 from fact_survey_responses
 where Current_brands="codex"
 group by Purchase_location
 order by total_count desc;
 
 Select count(Respondent_ID) as total_count,Typical_consumption_situations
 from fact_survey_responses
 where Current_brands="codex"
 group by Typical_consumption_situations
 order by total_count desc;
 
-- Who should be our target audience, and why? --
select count(f.Respondent_ID) as total_count,r.age
from dim_repondents r join
fact_survey_responses f on r.Respondent_ID=f.Respondent_ID
 where Current_brands="codex"
 group by age
 order by total_count desc;
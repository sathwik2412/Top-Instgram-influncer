use instgram ;
select * from top_insta_influencers;
/*  What are the top 10 influencers based on the influence_score?*/
select channel_info, influence_score from top_insta_influencers
order by influence_score desc
limit 10 ;

/*  List all influencers who have a 60_day_eng_rate higher than 1% */

select channel_info , 60_day_eng_rate from top_insta_influencers
where 60_day_eng_rate >"1.00" 
order by channel_info asc;

/*Which country has the highest number of influencers in the dataset?*/
SELECT COUNTRY , count(*) INFLUNCER_COUNT FROM top_insta_influencers
GROUP BY COUNTRY 
ORDER BY INFLUNCER_COUNT desc
LIMIT 1;

/* Find the influencer(s) with the highest number of followers.*/

SELECT channel_info, followers FROM top_insta_influencers
order by followers desc 
limit 2;

/*What is the average influence_score of influencers from the United States?*/
 
select avg(influence_score) as avg_score_united_states  from top_insta_influencers
where country = "united states";

/*How many influencers have more than 100 million followers?*/

select channel_info , followers from top_insta_influencers
where followers > 1000000
limit 5;

/*List all influencers who have posted more than 5,000 times.*/

select channel_info ,posts from top_insta_influencers
where posts> 5000
order by posts desc ;
/* how many posts is there in the dataset */

SELECT SUM(posts) AS total_posts
FROM top_insta_influencers;

/*Find the influencer with the lowest avg_likes.*/

select channel_info , avg_likes from top_insta_influencers
order by   avg_likes asc
limit 2;

/*  What is the sum of total_likes for influencers from Spain?*/

select sum(total_likes) , country from top_insta_influencers
where country = "spain";

/*How many unique countries are represented in the dataset?*/
select distinct( country) from
 top_insta_influencers;
 
 /* Find the top 5 countries based on the total number of followers.*/
  
  select sum(followers) as top_5_followers , country from top_insta_influencers
  group by country 
  order by top_5_followers desc
  limit 5;
  
  /*Which influencer has the highest new_post_avg_like?*/
   select channel_info , new_post_avg_like 
   from top_insta_influencers
   order by new_post_avg_like desc
   limit 5 ;
   
  /* Calculate the average number of posts per influencer.*/
  
  SELECT AVG(posts) AS average_posts_per_influencer
FROM top_insta_influencers;
  -- or---
  SELECT channel_info, posts, 
       (SELECT AVG(posts) FROM top_insta_influencers) AS avg_posts
FROM top_insta_influencers;

/*List influencers with a 60_day_eng_rate less than 0.5%.*/

select channel_info, 60_day_eng_rate from 
top_insta_influencers
where 60_day_eng_rate < "0.05"
order by 60_day_eng_rate desc;


/*How many influencers have an influence_score above 90?*/
   select channel_info , influence_score
  from top_insta_influencers
  where influence_score >"90";
  
  /* What is the total number of followers for influencers from the top 3 ranked positions?*/
  
 select rank_info as "rank", channel_info , followers from top_insta_influencers
 order by rank_info 
 limit 3;
 
 /*Identify influencers with a new_post_avg_like greater than their avg_likes.*/
 
 select channel_info, new_post_avg_like, avg_likes from top_insta_influencers
 where new_post_avg_like > avg_likes ;
 

/*What is the median total_likes across all influencers? */
-- Create a Common Table Expression (CTE) to rank influencers by total_likes and count the total rows
WITH RankedInfluencers AS (
  SELECT *,
         -- Assign a row number to each influencer based on the total_likes in ascending order
         ROW_NUMBER() OVER (ORDER BY total_likes) AS row_num,
         -- Calculate the total number of influencers
         COUNT(*) OVER () AS total_rows
  FROM top_insta_influencers
)

-- Select the median total_likes using a CASE statement to handle both odd and even total rows
SELECT
  CASE
    -- If the total number of rows is even
    WHEN total_rows % 2 = 0 THEN
      -- Find the two middle total_likes values and calculate their average for the median
      (SELECT total_likes FROM RankedInfluencers WHERE row_num = total_rows / 2) +
      (SELECT total_likes FROM RankedInfluencers WHERE row_num = (total_rows / 2) + 1) / 2
    ELSE
      -- If the total number of rows is odd, return the middle total_likes value directly
      (SELECT total_likes FROM RankedInfluencers WHERE row_num = (total_rows + 1) / 2)
  END AS median_total_likes
FROM RankedInfluencers;



  






















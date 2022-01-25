-- Question 3: Count records
--How many taxi trips were there on January 15?

Select 
    count(tpep_pickup_datetime) 
from yellow_taxi_trips 
where date(tpep_pickup_datetime) =  cast('2021-01-15' as date)

-- Question 4: Largest tip for each day *
-- On which day it was the largest tip in January? (note: it's not a typo, it's "tip", not "trip")
Select 
	cast(tpep_pickup_datetime as date) as day,
	max(tip_amount)
from yellow_taxi_trips 
group by 1
order by 2 desc


-- Question 5: Most popular destination *
-- What was the most popular destination for passengers picked up in central park on January 14? 
-- Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown"
select
	zdo."Zone",
	count(1) as count
	
from
    yellow_taxi_trips t LEFT JOIN zones zpu
        ON t."PULocationID" = zpu."LocationID"
    LEFT JOIN zones zdo
        ON t."DOLocationID" = zdo."LocationID"
		
where zpu."Zone" = 'Central Park' and cast(t.tpep_pickup_datetime as date) = '2021-01-14'
group by zdo."Zone"
order by 2 desc

-- Question 6: Most expensive route *
-- What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)? 
-- Enter two zone names separated by a slashFor example:"Jamaica Bay / Clinton East"
-- If any of the zone names are unknown (missing), write "Unknown". For example, "Unknown / Clinton East".

SELECT
    CONCAT(zpu."Zone", '/', zdo."Zone") AS "pair",
    avg(total_amount)
    
FROM
    yellow_taxi_trips t LEFT JOIN zones zpu
        ON t."PULocationID" = zpu."LocationID"
    LEFT JOIN zones zdo
        ON t."DOLocationID" = zdo."LocationID"
group by 1
order by 2 desc;
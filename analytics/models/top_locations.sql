select 
    job_location,
    count(*) as job_count
from {{ ref('job_postings') }}
group by job_location
order by job_count desc
limit 10;
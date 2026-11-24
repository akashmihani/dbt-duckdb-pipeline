select 
DATE_TRUNC('month', search_time) as month,
search_term As role,
count(*) as postings
from {{ ref('job_postings') }}
group by month, search_term;
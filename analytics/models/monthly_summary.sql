WITH totals AS (
    SELECT
        month,
        SUM(postings) AS total_postings
    FROM {{ ref('jobs_per_month') }}
    GROUP BY month  
),
remote_jobs AS (
    SELECT
        DATE_TRUNC('month', search_time) AS month,
        COUNT(*) AS remote_jobs
    FROM {{ ref('job_postings') }}
    WHERE job_work_from_home = 'Yes'
    GROUP BY month
)
SELECT month,
       total_postings,
       remote_jobs,
       ROUND(COALESCE(remote_jobs, 0) * 100.0 / total_postings, 2) AS remote_percentage
FROM totals
JOIN remote_jobs USING (month)
ORDER BY month;
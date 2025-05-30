-- residual_count
-- visitor_log
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.visitor_log vl
WHERE (vl.check_in_time < "2022-12-31 23:59:59" OR vl.check_out_time < "2022-12-31 23:59:59");

-- retained_count
-- visitor_log
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.visitor_log vl;

-- expected_count_for_retention
-- visitor_log 
SELECT *
FROM {SOURCE_MS_CLASSOPS_DB}.visitor_log vl
WHERE (vl.check_in_time > "2022-12-31 23:59:59" OR vl.check_out_time > "2022-12-31 23:59:59");
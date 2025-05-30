-- residual_check
-- lead_activity_log 
SELECT lc.*
FROM {ARCHIVED_SN2_DB}.lead_child lc
INNER JOIN {ARCHIVED_SN2_DB}.lead_activity_log wt ON wt.fk_lead_child = lc.id
WHERE lc.id IN ( 
   SELECT darch.fk_lead_child FROM {ARCHIVED_SN2_DB}.dar_lead_child_archival_map darch
   WHERE lc.id = darch.fk_lead_child
   AND darch.fk_lead_child NOT IN (
   SELECT le.fk_lead_child FROM {ARCHIVED_SN2_DB}.lead le
   WHERE le.fk_lead_child = darch.fk_lead_child
   )
)
ORDER BY lc.updated_at ASC;

-- retained_count
-- lead_activity_log
SELECT lc.*
FROM {ARCHIVED_SN2_DB}.lead_child lc
INNER JOIN {ARCHIVED_SN2_DB}.lead_activity_log wt ON wt.fk_lead_child = lc.id;


-- expected_count_for_retention
-- lead_activity_log
SELECT lc.*
FROM {SOURCE_SN2_DB}.lead_child lc
INNER JOIN {SOURCE_SN2_DB}.lead_activity_log wt ON wt.fk_lead_child = lc.id
WHERE lc.id NOT IN ( 
          SELECT darlc.fk_lead_child FROM {ARCHIVED_SN2_DB}.dar_lead_child_archival_map darlc
          WHERE lc.id = darlc.fk_lead_child
          )
UNION ALL
SELECT lc.*
FROM {ARCHIVED_SN2_DB}.lead_child lc
INNER JOIN {ARCHIVED_SN2_DB}.lead_activity_log wt ON wt.fk_lead_child = lc.id
WHERE lc.id IN ( 
SELECT darlc.fk_lead_child FROM {ARCHIVED_SN2_DB}.dar_lead_child_archival_map darlc
WHERE lc.id = darlc.fk_lead_child
);
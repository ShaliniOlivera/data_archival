-- residual_check
-- lead_child
SELECT le.*
FROM {ARCHIVED_SN2_DB}.lead_child le
WHERE le.id IN ( 
   SELECT darch.fk_lead_child FROM {ARCHIVED_SN2_DB}.dar_lead_child_archival_map darch
   WHERE le.id = darch.fk_lead_child
);

-- retained_count
-- lead_child
SELECT lc.*
FROM {ARCHIVED_SN2_DB}.lead_child lc;

-- expected_count_for_retention
-- lead_child
SELECT lc.*
FROM {SOURCE_SN2_DB}.lead_child lc
WHERE lc.id NOT IN ( 
 SELECT darlc.fk_lead_child FROM {ARCHIVED_SN2_DB}.dar_lead_child_archival_map darlc
 WHERE lc.id = darlc.fk_lead_child
 );
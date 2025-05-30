-- residual_check
-- lead_child
SELECT lc.*
FROM {ARCHIVED_SN2_DB}.lead_child lc
WHERE lc.id IN ( 
   SELECT darch.fk_lead_child FROM {ARCHIVED_SN2_DB}.dar_lead_child_archival_map darch
   WHERE lc.id = darch.fk_lead_child
   AND darch.fk_lead_child NOT IN (
   SELECT le.fk_lead_child FROM {ARCHIVED_SN2_DB}.lead le
   WHERE le.fk_lead_child = darch.fk_lead_child
   )
)
;

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
 AND darlc.fk_lead_child NOT IN (
   SELECT le.fk_lead_child FROM {ARCHIVED_SN2_DB}.lead le
   WHERE le.fk_lead_child = darlc.fk_lead_child
)
 );
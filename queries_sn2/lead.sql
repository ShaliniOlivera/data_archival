-- residual_check
-- lead
SELECT le.*
FROM {ARCHIVED_SN2_DB}.lead le
WHERE le.id IN ( 
SELECT darch.fk_lead FROM {ARCHIVED_SN2_DB}.dar_lead_archival_map darch
WHERE le.id = darch.fk_lead
);


-- retained_count
-- lead
SELECT le.*
FROM {ARCHIVED_SN2_DB}.lead le;

-- expected_count_for_retention
-- lead
SELECT le.*
FROM {SOURCE_SN2_DB}.lead le
WHERE le.id NOT IN(
   SELECT darch.fk_lead FROM {ARCHIVED_SN2_DB}.dar_lead_archival_map darch
   WHERE le.id = darch.fk_lead
   );
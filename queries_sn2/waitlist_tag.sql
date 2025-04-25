-- residual_check
-- waitlist_tag
SELECT lc.*
FROM {ARCHIVED_SN2_DB}.lead_child lc
INNER JOIN {ARCHIVED_SN2_DB}.waitlist_tag lal ON lal.fk_lead_child = lc.id
WHERE lc.id IN ( 
SELECT darlc.fk_lead_child FROM {ARCHIVED_SN2_DB}.dar_lead_child_archival_map darlc
WHERE lc.id = darlc.fk_lead_child
);

-- retained_count
-- waitlist_tag
SELECT lc.*
FROM {ARCHIVED_SN2_DB}.lead_child lc
INNER JOIN {ARCHIVED_SN2_DB}.waitlist_tag lal ON lal.fk_lead_child = lc.id;

-- expected_count_for_retention
-- waitlist_tag
SELECT lc.*
FROM {SOURCE_SN2_DB}.lead_child lc
INNER JOIN {SOURCE_SN2_DB}.waitlist_tag lal ON lal.fk_lead_child = lc.id
WHERE lc.id NOT IN ( 
SELECT darlc.fk_lead_child FROM {ARCHIVED_SN2_DB}.dar_lead_child_archival_map darlc
WHERE lc.id = darlc.fk_lead_child
);
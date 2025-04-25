-- residual_check
-- registration_child_mapping
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child rch 
INNER JOIN {ARCHIVED_SN2_DB}.registration_child_mapping rcal ON rcal.fk_registration_child = rch.id
WHERE rch.id IN (
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
);

-- retained_count
-- registration_child_mapping
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child rch 
INNER JOIN {ARCHIVED_SN2_DB}.registration_child_mapping rcal ON rcal.fk_registration_child = rch.id;

-- expected_count_for_retention
-- registration_child_mapping
SELECT *
FROM {SOURCE_SN2_DB}.registration_child rch 
INNER JOIN {SOURCE_SN2_DB}.registration_child_mapping rcal ON rcal.fk_registration_child = rch.id
WHERE rch.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
);
-- residual_check
-- registration_state_history
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_state_history rch 
WHERE rch.fk_registration IN(
SELECT darch.fk_registration FROM {ARCHIVED_SN2_DB}.dar_registration_delete_unique_map darch
);

-- retained_count
-- registration_state_history
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_state_history rch;

-- expected_count_for_retention
-- registration_state_history
SELECT *
FROM {SOURCE_SN2_DB}.registration_state_history rch 
WHERE rch.fk_registration NOT IN(
SELECT darch.fk_registration FROM {ARCHIVED_SN2_DB}.dar_registration_delete_unique_map darch
);
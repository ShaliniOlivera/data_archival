-- residual_check
-- parent_entry_mapping
SELECT * FROM {ARCHIVED_SN2_DB}.parent_entry_mapping pem
WHERE pem.ep_id IN (
SELECT darp.fk_parent FROM {ARCHIVED_SN2_DB}.dar_parent_user_archival_map darp
WHERE darp.fk_parent = pem.ep_id
);

-- retained_count
-- parent_entry_mapping
SELECT * FROM {ARCHIVED_SN2_DB}.parent_entry_mapping pem;

-- expected_count_for_retention
-- parent_entry_mapping
SELECT * FROM {SOURCE_SN2_DB}.parent_entry_mapping pem
WHERE pem.ep_id NOT IN (
SELECT darp.fk_parent FROM {ARCHIVED_SN2_DB}.dar_parent_user_archival_map darp
WHERE darp.fk_parent = pem.ep_id
);


-- residual_check
-- registration_parent_attribute
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_parent rp
INNER JOIN {ARCHIVED_SN2_DB}.registration_parent_attribute rpa ON rpa.fk_registration_parent = rp.id
WHERE rp.id IN(
SELECT darp.fk_registration_parent FROM {ARCHIVED_SN2_DB}.dar_registration_parent_delete_unique_map darp
WHERE rp.id = darp.fk_registration_parent
);

-- retained_count
-- registration_parent_attribute
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_parent rp
INNER JOIN {ARCHIVED_SN2_DB}.registration_parent_attribute rpa ON rpa.fk_registration_parent = rp.id;

-- expected_count_for_retention
-- registration_parent_attribute
SELECT *
FROM {SOURCE_SN2_DB}.registration_parent rp
INNER JOIN {ARCHIVED_SN2_DB}.registration_parent_attribute rpa ON rpa.fk_registration_parent = rp.id
WHERE rp.id NOT IN(
SELECT darp.fk_registration_parent FROM {ARCHIVED_SN2_DB}.dar_registration_parent_delete_unique_map darp
WHERE rp.id = darp.fk_registration_parent
);
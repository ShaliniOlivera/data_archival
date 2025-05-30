-- residual_count
-- form on fk_registration_child
SELECT  fo.id AS fo_id, rcm.*
FROM {ARCHIVED_SN2_DB}.form fo
INNER JOIN {ARCHIVED_SN2_DB}.registration re ON re.id = fo.fk_registration
INNER JOIN {ARCHIVED_SN2_DB}.registration_child_mapping rcm ON rcm.fk_registration = re.id
INNER JOIN {ARCHIVED_SN2_DB}.registration_child rch ON rch.id = rcm.fk_registration_child
WHERE rch.id IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
WHERE rch.id = darch.fk_registration_child
);

-- retained_count
-- form on fk_registration_child
SELECT  fo.id AS fo_id, rcm.*
FROM {ARCHIVED_SN2_DB}.form fo
INNER JOIN {ARCHIVED_SN2_DB}.registration re ON re.id = fo.fk_registration
INNER JOIN {ARCHIVED_SN2_DB}.registration_child_mapping rcm ON rcm.fk_registration = re.id
INNER JOIN {ARCHIVED_SN2_DB}.registration_child rch ON rch.id = rcm.fk_registration_child;

-- expected_count_for_retention
-- form on fk_registration_child
SELECT  fo.id AS fo_id, rcm.*
FROM {SOURCE_SN2_DB}.form fo
INNER JOIN {SOURCE_SN2_DB}.registration re ON re.id = fo.fk_registration
INNER JOIN {SOURCE_SN2_DB}.registration_child_mapping rcm ON rcm.fk_registration = re.id
INNER JOIN {SOURCE_SN2_DB}.registration_child rch ON rch.id = rcm.fk_registration_child
WHERE rch.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
WHERE rch.id = darch.fk_registration_child
);
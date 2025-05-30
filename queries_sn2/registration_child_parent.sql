-- residual_check
-- registration_child_parent
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child_parent rp
INNER JOIN {ARCHIVED_SN2_DB}.registration_child rch ON rch.id = rp.fk_registration_child
WHERE rch.id IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
WHERE rch.id = darch.fk_registration_child
);


-- retained_count
-- registration_child_parent
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child_parent rp
INNER JOIN {ARCHIVED_SN2_DB}.registration_child rch ON rch.id = rp.fk_registration_child;

-- expected_count_for_retention
-- registration_child_parent
SELECT *
FROM {SOURCE_SN2_DB}.registration_child_parent rp
INNER JOIN {SOURCE_SN2_DB}.registration_child rch ON rch.id = rp.fk_registration_child
WHERE rch.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
WHERE rch.id = darch.fk_registration_child
);
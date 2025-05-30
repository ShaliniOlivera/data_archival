-- residual_check
-- registration_parent
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_parent rp
WHERE rp.id IN(
SELECT darp.fk_registration_parent FROM {ARCHIVED_SN2_DB}.dar_registration_parent_delete_unique_map darp
WHERE rp.id = darp.fk_registration_parent
);

-- retained_count
-- registration_parent
SELECT ROW_NUMBER() OVER (ORDER BY rp.id) AS row_num, rp.*
FROM {ARCHIVED_SN2_DB}.registration_parent rp;

-- expected_count_for_retention
-- registration_parent
SELECT ROW_NUMBER() OVER (ORDER BY rp.id) AS row_num,
    rp.*
FROM {SOURCE_SN2_DB}.registration_parent rp
WHERE rp.id NOT IN(
SELECT darp.fk_registration_parent FROM {ARCHIVED_SN2_DB}.dar_registration_parent_delete_unique_map darp
WHERE rp.id = darp.fk_registration_parent
);
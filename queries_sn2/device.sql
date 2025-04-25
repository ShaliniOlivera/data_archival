-- residual_check
-- device
SELECT ud.fk_user, de.* FROM {ARCHIVED_SN2_DB}.device de
INNER JOIN {ARCHIVED_SN2_DB}.user_device ud ON ud.fk_device = de.id
WHERE ud.fk_user IN (
SELECT darp.fk_user FROM {ARCHIVED_SN2_DB}.dar_parent_user_archival_map darp
);

-- retained_count
-- device
SELECT ud.fk_user, de.* FROM {ARCHIVED_SN2_DB}.device de
INNER JOIN {ARCHIVED_SN2_DB}.user_device ud ON ud.fk_device = de.id;

-- expected_count_for_retention
-- device
SELECT ud.fk_user, de.* FROM {SOURCE_SN2_DB}.device de
INNER JOIN {SOURCE_SN2_DB}.user_device ud ON ud.fk_device = de.id
WHERE ud.fk_user NOT IN (
SELECT darp.fk_user FROM {ARCHIVED_SN2_DB}.dar_parent_user_archival_map darp
);

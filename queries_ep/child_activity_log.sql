-- residual_check
-- child_activity_log
SELECT ch.birth_certificate, cal.*
FROM {ARCHIVED_SN2_DB}.child_activity_log cal
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cal.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- child_activity_log
SELECT ch.birth_certificate, cal.*
FROM {ARCHIVED_SN2_DB}.child_activity_log cal
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cal.fk_child;

-- expected_count_for_retention
-- child_activity_log
SELECT ch.birth_certificate, cal.*
FROM {SOURCE_SN2_DB}.child_activity_log cal
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cal.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
-- residual_check
-- guardian_centre_verification
SELECT ch.birth_certificate, gcv.*
FROM {ARCHIVED_SN2_DB}.guardian gu
INNER JOIN {ARCHIVED_SN2_DB}.guardian_centre_verification gcv ON gu.id = gcv.fk_guardian
INNER JOIN {ARCHIVED_SN2_DB}.guardian_child_relation gcr ON gcr.fk_guardian = gu.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = gcr.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);

-- retained_count
-- guardian_centre_verification
SELECT DISTINCT ch.birth_certificate, gcv.*
FROM {ARCHIVED_SN2_DB}.guardian gu
INNER JOIN {ARCHIVED_SN2_DB}.guardian_centre_verification gcv ON gu.id = gcv.fk_guardian
INNER JOIN {ARCHIVED_SN2_DB}.guardian_child_relation gcr ON gcr.fk_guardian = gu.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = gcr.fk_child
WHERE gu.active = 1 AND gcr.active = 1;

-- expected_count_for_retention
-- guardian_centre_verification
SELECT DISTINCT ch.birth_certificate, gcv.*
FROM {SOURCE_SN2_DB}.guardian gu
INNER JOIN {SOURCE_SN2_DB}.guardian_centre_verification gcv ON gu.id = gcv.fk_guardian
INNER JOIN {SOURCE_SN2_DB}.guardian_child_relation gcr ON gcr.fk_guardian = gu.id
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = gcr.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
)
and gu.active = 1 AND gcr.active = 1;
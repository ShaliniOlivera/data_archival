-- residual_check
-- class_attendance
SELECT ch.id, ca.*
FROM {ARCHIVED_MS_CICO_DB}.class_attendance ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- class_attendance
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_MS_CICO_DB}.class_attendance ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child
group by ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- class_attendance
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_MS_CICO_DB}.class_attendance ca
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
)
group by ch.id, ch.birth_certificate;
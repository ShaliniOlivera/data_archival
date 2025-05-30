-- residual_check
-- child_health_record
SELECT ch.id, ca.*
FROM {ARCHIVED_MS_CICO_DB}.child_health_record ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
where ch.id = darch.fk_child
);

-- retained_count
-- child_health_record
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_MS_CICO_DB}.child_health_record ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child
group by ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- child_health_record
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_MS_CICO_DB}.child_health_record ca
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
where ch.id = darch.fk_child
)
group by ch.id, ch.birth_certificate;
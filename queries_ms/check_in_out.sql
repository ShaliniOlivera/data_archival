-- residual_check
-- check_in_out
SELECT cio.*
FROM {ARCHIVED_MS_CICO_DB}.check_in_out cio
WHERE cio.fk_child IN(
   SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch)
;

-- retained_count
-- check_in_out
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_MS_CICO_DB}.check_in_out cio
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cio.fk_child
group by ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- check_in_out
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_MS_CICO_DB}.check_in_out cio
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cio.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
)
group by ch.id, ch.birth_certificate;
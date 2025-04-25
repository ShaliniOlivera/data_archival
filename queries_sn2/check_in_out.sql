-- residual_check
-- check_in_out
SELECT ch.birth_certificate, cio.*
FROM {ARCHIVED_SN2_DB}.check_in_out cio
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cio.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- check_in_out
SELECT ch.birth_certificate, cio.*
FROM {ARCHIVED_SN2_DB}.check_in_out cio
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cio.fk_child;

-- expected_count_for_retention
-- check_in_out
SELECT ch.birth_certificate, cio.*
FROM {SOURCE_SN2_DB}.check_in_out cio
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cio.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
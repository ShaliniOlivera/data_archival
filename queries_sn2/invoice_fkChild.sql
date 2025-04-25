-- residual_check
-- invoice
SELECT ch.birth_certificate, inv.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_child = ch.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- invoice
SELECT ch.birth_certificate, inv.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_child = ch.id;

-- expected_count_for_retention
-- invoice
SELECT ch.birth_certificate, inv.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.invoice inv ON inv.fk_child = ch.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
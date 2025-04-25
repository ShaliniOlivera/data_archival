-- residual_check
-- child_level
SELECT ch.id, cl.*
FROM {ARCHIVED_SN2_DB}.child_level cl
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cl.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);

-- retained_count
-- child_level
SELECT ch.id, cl.*
FROM {ARCHIVED_SN2_DB}.child_level cl
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cl.fk_child;

-- expected_count_for_retention
-- child_level
SELECT ch.id, cl.*
FROM {SOURCE_SN2_DB}.child_level cl
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cl.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
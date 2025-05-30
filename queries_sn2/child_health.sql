-- residual_count
-- child_health
SELECT ch.id, ca.id, ca.*
FROM {ARCHIVED_SN2_DB}.child_health ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- child_health
SELECT row_number() over () AS row_num, ch.id, ca.id, ca.*
FROM {ARCHIVED_SN2_DB}.child_health ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child;

-- expected_count_for_retention
-- child_health
SELECT row_number () over () AS row_num, ch.id, ca.id, ca.*
FROM {SOURCE_SN2_DB}.child_health ca
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.id NOT IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);
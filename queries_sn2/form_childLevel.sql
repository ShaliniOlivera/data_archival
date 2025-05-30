-- residual_count
-- form on fk_child_level
SELECT ch.id, fo.*
FROM {ARCHIVED_SN2_DB}.child_level cl
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cl.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_child_level = cl.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- form on fk_child_level
SELECT ch.id, fo.*
FROM {ARCHIVED_SN2_DB}.child_level cl
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cl.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_child_level = cl.id;

-- expected_count_for_retention
-- form on fk_child_level
SELECT ch.id, fo.*
FROM {SOURCE_SN2_DB}.child_level cl
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cl.fk_child
INNER JOIN {SOURCE_SN2_DB}.form fo ON fo.fk_child_level = cl.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);
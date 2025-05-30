-- residual_count
-- form_participant on fk_child_level
SELECT ch.id, fp.* 
FROM {ARCHIVED_SN2_DB}.child_level cl
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cl.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_child_level = cl.id
INNER JOIN {ARCHIVED_SN2_DB}.form_participant fp ON fp.fk_form = fo.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- form_participant on fk_child_level
SELECT ch.id, fp.* 
FROM {ARCHIVED_SN2_DB}.child_level cl
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cl.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_child_level = cl.id
INNER JOIN {ARCHIVED_SN2_DB}.form_participant fp ON fp.fk_form = fo.id;

-- expected_count_for_retention
-- form_participant on fk_child_level
SELECT ch.id, fp.* 
FROM {SOURCE_SN2_DB}.child_level cl
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cl.fk_child
INNER JOIN {SOURCE_SN2_DB}.form fo ON fo.fk_child_level = cl.id
INNER JOIN {SOURCE_SN2_DB}.form_participant fp ON fp.fk_form = fo.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
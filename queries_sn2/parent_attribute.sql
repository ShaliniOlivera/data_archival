-- residual_check
-- parent_attribute
SELECT ch.birth_certificate, pat.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.parent_attribute pat ON pat.fk_parent = pa.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);


-- retained_count
-- parent_attribute
SELECT ch.birth_certificate, pat.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.parent_attribute pat ON pat.fk_parent = pa.id;

-- expected_count_for_retention
-- parent_attribute
SELECT ch.birth_certificate, pat.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.parent_attribute pat ON pat.fk_parent = pa.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
-- residual_check
-- address
SELECT ch.id, ch.birth_certificate, pa.email, pa.lastname, pa.identification_no, ad.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.address ad ON ad.fk_parent = pa.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- address
SELECT ch.id, ch.birth_certificate, pa.email, pa.lastname, pa.identification_no, ad.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.address ad ON ad.fk_parent = pa.id;


-- expected_count_for_retention
-- address
SELECT ch.id, ch.birth_certificate, pa.email, pa.lastname, pa.identification_no, ad.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.address ad ON ad.fk_parent = pa.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);
-- residual_check
-- address | parent | child_relation
SELECT ch.birth_certificate AS child_BC, pa.email, pa.lastname, pa.identification_no, ad.* FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.address ad ON ad.fk_parent = pa.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
); 

-- retained_count
-- address | parent | child_relation
SELECT ch.birth_certificate AS child_BC, pa.email, pa.lastname, pa.identification_no, ad.* FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.address ad ON ad.fk_parent = pa.id
; 

-- expected_count_for_retention
-- address | parent | child_relation
SELECT ch.birth_certificate AS child_BC, pa.email, pa.lastname, pa.identification_no, ad.* FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.address ad ON ad.fk_parent = pa.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
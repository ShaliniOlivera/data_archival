-- residual_check
-- address | parent | child_relation
SELECT ch.birth_certificate AS child_BC, pa.email, pa.lastname, pa.identification_no, ad.* 
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.address ad ON ad.fk_parent = pa.id
WHERE pa.id IN(
SELECT darch.fk_parent FROM {ARCHIVED_SN2_DB}.dar_parent_user_archival_map darch
); 

-- retained_count
-- address | parent | child_relation
SELECT ch.birth_certificate AS child_BC, pa.email, pa.lastname, pa.identification_no, ad.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.address ad ON ad.fk_parent = pa.id
; 

-- expected_count_for_retention
-- address | parent | child_relation
SELECT ch.birth_certificate AS child_BC, pa.email, pa.lastname, pa.identification_no, ad.* 
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.address ad ON ad.fk_parent = pa.id
WHERE ch.id not IN(
   SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
   )
AND ad.fk_registration_parent NOT IN (
SELECT darp.fk_registration_parent FROM {ARCHIVED_SN2_DB}.dar_registration_parent_delete_unique_map darp
WHERE ad.fk_registration_parent = darp.fk_registration_parent
);
   
   

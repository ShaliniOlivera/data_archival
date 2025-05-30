-- residual_check
-- receipt_audit_log on fk_registration_child
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child rch 
INNER JOIN {ARCHIVED_SN2_DB}.receipt_audit_log rcb ON rch.id = rcb.fk_registration_child
WHERE rch.id IN(
   SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
   );

-- retained_count
-- receipt_audit_log on fk_registration_child
SELECT DISTINCT rch.id, rch.birth_certificate, count(rch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.registration_child rch 
INNER JOIN {ARCHIVED_SN2_DB}.receipt_audit_log rcb ON rch.id = rcb.fk_registration_child
GROUP BY rch.id, rch.birth_certificate;

-- expected_count_for_retention
-- receipt_audit_log on fk_registration_child
SELECT DISTINCT rch.id, rch.birth_certificate, count(rch.birth_certificate)
FROM {SOURCE_SN2_DB}.registration_child rch 
INNER JOIN {SOURCE_SN2_DB}.receipt_audit_log rcb ON rch.id = rcb.fk_registration_child
WHERE rch.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
)
GROUP BY rch.id, rch.birth_certificate;
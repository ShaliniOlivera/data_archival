-- residual_check
-- registration_audit_migrated_log
SELECT *
FROM {ARCHIVED_SN2_DB}.registration reg
INNER JOIN {ARCHIVED_SN2_DB}.registration_audit_migrated_log raml ON reg.id = raml.fk_registration
WHERE reg.id IN(
SELECT darch.fk_registration FROM {ARCHIVED_SN2_DB}.dar_registration_delete_unique_map darch
) ;

-- retained_count
-- registration_audit_migrated_log
SELECT *
FROM {ARCHIVED_SN2_DB}.registration reg
INNER JOIN {ARCHIVED_SN2_DB}.registration_audit_migrated_log raml ON reg.id = raml.fk_registration;

-- expected_count_for_retention
-- registration_audit_migrated_log
SELECT *
FROM {SOURCE_SN2_DB}.registration reg
INNER JOIN {SOURCE_SN2_DB}.registration_audit_migrated_log raml ON reg.id = raml.fk_registration
WHERE reg.id NOT IN(
SELECT darch.fk_registration FROM {ARCHIVED_SN2_DB}.dar_registration_delete_unique_map darch
);
-- residual_check
-- marketing_consent_audit_log
SELECT ch.birth_certificate, mcaul.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON ch.id = cr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = cr.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.marketing_consent mc ON mc.fk_user = us.id
INNER JOIN {ARCHIVED_SN2_DB}.marketing_consent_audit_log mcaul ON mcaul.fk_marketing_consent = mc.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);

-- retained_count
-- marketing_consent_audit_log
SELECT ch.birth_certificate, mcaul.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON ch.id = cr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = cr.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.marketing_consent mc ON mc.fk_user = us.id
INNER JOIN {ARCHIVED_SN2_DB}.marketing_consent_audit_log mcaul ON mcaul.fk_marketing_consent = mc.id;

-- expected_count_for_retention
-- marketing_consent_audit_log
SELECT ch.birth_certificate, mcaul.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON ch.id = cr.fk_child
INNER JOIN {SOURCE_SN2_DB}.user us ON us.id = cr.fk_user
INNER JOIN {SOURCE_SN2_DB}.marketing_consent mc ON mc.fk_user = us.id
INNER JOIN {SOURCE_SN2_DB}.marketing_consent_audit_log mcaul ON mcaul.fk_marketing_consent = mc.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);
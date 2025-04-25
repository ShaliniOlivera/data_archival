-- residual_check
-- marketing_consent | marketing_consent_user
SELECT ch.birth_certificate, mc.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON ch.id = cr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = cr.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.marketing_consent_user mc ON mc.email = us.email
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- marketing_consent | marketing_consent_user
SELECT ch.birth_certificate, mc.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON ch.id = cr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = cr.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.marketing_consent_user mc ON mc.email = us.email;

-- expected_count_for_retention
-- marketing_consent | marketing_consent_user
SELECT ch.birth_certificate, mc.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON ch.id = cr.fk_child
INNER JOIN {SOURCE_SN2_DB}.user us ON us.id = cr.fk_user
INNER JOIN {SOURCE_SN2_DB}.marketing_consent_user mc ON mc.email = us.email
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
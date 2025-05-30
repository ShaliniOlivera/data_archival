-- residual_check
-- temporary_withdrawal
SELECT ch.birth_certificate, tw.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.temporary_withdrawal tw ON tw.fk_child = ch.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- temporary_withdrawal
SELECT ch.birth_certificate, tw.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.temporary_withdrawal tw ON tw.fk_child = ch.id;

-- expected_count_for_retention
-- temporary_withdrawal
SELECT ch.birth_certificate, tw.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.temporary_withdrawal tw ON tw.fk_child = ch.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
-- residual_check
-- trade_debt_notification_log
SELECT ch.birth_certificate, tw.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.trade_debt_notification_log tw ON tw.fk_child = ch.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- trade_debt_notification_log
SELECT ch.birth_certificate, tw.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.trade_debt_notification_log tw ON tw.fk_child = ch.id;

-- expected_count_for_retention
-- trade_debt_notification_log
SELECT ch.birth_certificate, tw.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.trade_debt_notification_log tw ON tw.fk_child = ch.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
-- residual_count
-- form on fk_withdrawal_draft
SELECT ch.birth_certificate, fo.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal w ON w.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft wd ON wd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft_item wdi ON wdi.fk_draft = wd.id
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_withdrawal_draft = wd.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);


-- retained_count
-- form on fk_withdrawal_draft
SELECT ch.birth_certificate, fo.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal w ON w.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft wd ON wd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft_item wdi ON wdi.fk_draft = wd.id
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_withdrawal_draft = wd.id;


-- expected_count_for_retention
-- form on fk_withdrawal_draft
SELECT ch.birth_certificate, fo.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.withdrawal w ON w.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.withdrawal_draft wd ON wd.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.withdrawal_draft_item wdi ON wdi.fk_draft = wd.id
INNER JOIN {SOURCE_SN2_DB}.form fo ON fo.fk_withdrawal_draft = wd.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);
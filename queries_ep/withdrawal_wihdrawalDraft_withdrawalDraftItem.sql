-- residual_check
-- withdrawal | withdrawal_draft | withdrawal_draft_item
SELECT ch.birth_certificate AS child_BC, trd.*,tr.*,tdi.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal tr ON tr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft trd ON trd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft_item tdi ON tdi.fk_draft = trd.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);


-- retained_count
-- withdrawal | withdrawal_draft | withdrawal_draft_item
SELECT ch.birth_certificate AS child_BC, trd.*,tr.*,tdi.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal tr ON tr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft trd ON trd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft_item tdi ON tdi.fk_draft = trd.id;


-- expected_count_for_retention
-- withdrawal | withdrawal_draft | withdrawal_draft_item
SELECT ch.birth_certificate AS child_BC, trd.*,tr.*,tdi.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.withdrawal tr ON tr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.withdrawal_draft trd ON trd.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.withdrawal_draft_item tdi ON tdi.fk_draft = trd.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
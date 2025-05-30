-- residual_count
-- form_participant on fk_withdrawal_draft
SELECT ch.birth_certificate, fp.* 
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal w ON w.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft wd ON wd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft_item wdi ON wdi.fk_draft = wd.id
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_withdrawal_draft = wd.id
INNER JOIN {ARCHIVED_SN2_DB}.form_participant fp ON fp.fk_form = fo.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);


-- retained_count
-- form_participant on fk_withdrawal_draft 
SELECT ch.birth_certificate, fp.* 
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal w ON w.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft wd ON wd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.withdrawal_draft_item wdi ON wdi.fk_draft = wd.id
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_withdrawal_draft = wd.id
INNER JOIN {ARCHIVED_SN2_DB}.form_participant fp ON fp.fk_form = fo.id;


-- expected_count_for_retention
-- form_participant on fk_withdrawal_draft
SELECT ch.birth_certificate, fp.* 
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.withdrawal w ON w.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.withdrawal_draft wd ON wd.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.withdrawal_draft_item wdi ON wdi.fk_draft = wd.id
INNER JOIN {SOURCE_SN2_DB}.form fo ON fo.fk_withdrawal_draft = wd.id
INNER JOIN {SOURCE_SN2_DB}.form_participant fp ON fp.fk_form = fo.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

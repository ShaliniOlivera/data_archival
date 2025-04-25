-- residual_check
-- transfer_draft_activity_log
SELECT ch.birth_certificate AS child_BC, tdal.* FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.transfer_draft trd ON trd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.transfer_draft_activity_log tdal ON tdal.fk_draft = trd.id 
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- transfer_draft_activity_log
SELECT ch.birth_certificate AS child_BC, tdal.* FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.transfer_draft trd ON trd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.transfer_draft_activity_log tdal ON tdal.fk_draft = trd.id;

-- expected_count_for_retention
-- transfer_draft_activity_log
SELECT ch.birth_certificate AS child_BC, tdal.* FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.transfer_draft trd ON trd.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.transfer_draft_activity_log tdal ON tdal.fk_draft = trd.id 
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
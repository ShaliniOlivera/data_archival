-- residual_count
-- form on transfer_draft
SELECT ch.birth_certificate AS child_BC, fo.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.transfer tr ON tr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.transfer_draft trd ON trd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.transfer_draft_item tdi ON tdi.fk_draft = trd.id
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_transfer_draft = trd.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);


-- retained_count
-- form on transfer_draft
SELECT ch.birth_certificate AS child_BC, fo.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.transfer tr ON tr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.transfer_draft trd ON trd.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.transfer_draft_item tdi ON tdi.fk_draft = trd.id
INNER JOIN {ARCHIVED_SN2_DB}.form fo ON fo.fk_transfer_draft = trd.id;


-- expected_count_for_retention
-- form on transfer_draft
SELECT ch.birth_certificate AS child_BC, fo.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.transfer tr ON tr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.transfer_draft trd ON trd.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.transfer_draft_item tdi ON tdi.fk_draft = trd.id
INNER JOIN {SOURCE_SN2_DB}.form fo ON fo.fk_transfer_draft = trd.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
); 
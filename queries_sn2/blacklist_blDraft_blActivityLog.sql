-- residual_check
-- balcklist | blacklist_draft_item | blacklist_draft_activity_log
SELECT * FROM {ARCHIVED_SN2_DB}.blacklist bl
LEFT JOIN {ARCHIVED_SN2_DB}.blacklist_draft_item bdi ON bdi.fk_blacklist = bl.id
LEFT JOIN {ARCHIVED_SN2_DB}.blacklist_draft_activity_log bdag ON bdag.fk_draft = bdi.id
WHERE bl.fk_child IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);

-- retained_count
-- balcklist | blacklist_draft_item | blacklist_draft_activity_log
SELECT * FROM {ARCHIVED_SN2_DB}.blacklist bl
LEFT JOIN {ARCHIVED_SN2_DB}.blacklist_draft_item bdi ON bdi.fk_blacklist = bl.id
LEFT JOIN {ARCHIVED_SN2_DB}.blacklist_draft_activity_log bdag ON bdag.fk_draft = bdi.id;

-- expected_count_for_retention
-- balcklist | blacklist_draft_item | blacklist_draft_activity_log
SELECT * FROM {SOURCE_SN2_DB}.blacklist bl
LEFT JOIN {SOURCE_SN2_DB}.blacklist_draft_item bdi ON bdi.fk_blacklist = bl.id
LEFT JOIN {SOURCE_SN2_DB}.blacklist_draft_activity_log bdag ON bdag.fk_draft = bdi.id
WHERE bl.fk_child NOT IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);
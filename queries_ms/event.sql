-- residual_count
-- event | event_photo | event_rsvp
SELECT ch.birth_certificate, ev.*,ep.*,er.*
FROM {ARCHIVED_MS_CLASSOPS_DB}.event ev
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.event_photo ep ON ev.id = ep.fk_event
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.event_rsvp er ON ev.id = er.fk_event
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = er.fk_child
WHERE ch.id IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- event | event_photo | event_rsvp
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_MS_CLASSOPS_DB}.event ev
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.event_photo ep ON ev.id = ep.fk_event
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.event_rsvp er ON ev.id = er.fk_event
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = er.fk_child
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- event | event_photo | event_rsvp
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_MS_CLASSOPS_DB}.event ev
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.event_photo ep ON ev.id = ep.fk_event
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.event_rsvp er ON ev.id = er.fk_event
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = er.fk_child
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
)
GROUP BY ch.id, ch.birth_certificate;
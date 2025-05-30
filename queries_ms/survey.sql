-- residual_count
-- survey_recipient | survey_recipient_history | survey_response
SELECT ch.birth_certificate, rcb.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_MS_PSS_DB}.survey_recipient rcb ON rcb.fk_child = ch.id
INNER JOIN {ARCHIVED_MS_PSS_DB}.survey_recipient_history srh ON srh.fk_survey_recipient = rcb.id
LEFT JOIN {ARCHIVED_MS_PSS_DB}.survey_response sr ON sr.fk_survey_recipient = rcb.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- survey_recipient | survey_recipient_history | survey_response
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_MS_PSS_DB}.survey_recipient rcb ON rcb.fk_child = ch.id
INNER JOIN {ARCHIVED_MS_PSS_DB}.survey_recipient_history srh ON srh.fk_survey_recipient = rcb.id
LEFT JOIN {ARCHIVED_MS_PSS_DB}.survey_response sr ON sr.fk_survey_recipient = rcb.id
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- survey_recipient | survey_recipient_history | survey_response
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_MS_PSS_DB}.survey_recipient rcb ON rcb.fk_child = ch.id
INNER JOIN {SOURCE_MS_PSS_DB}.survey_recipient_history srh ON srh.fk_survey_recipient = rcb.id
LEFT JOIN {SOURCE_MS_PSS_DB}.survey_response sr ON sr.fk_survey_recipient = rcb.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
)
GROUP BY ch.id, ch.birth_certificate;
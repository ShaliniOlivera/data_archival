-- residual_count
-- portfolio_class_activity
SELECT ch.birth_certificate, ca.title, clg.*, pat.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio_class_activity clg ON clg.fk_portfolio = pat.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca ON ca.id = clg.fk_class_activity
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);


-- retained_count
-- portfolio_class_activity
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio_class_activity clg ON clg.fk_portfolio = pat.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca ON ca.id = clg.fk_class_activity
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- portfolio_class_activity
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.portfolio_class_activity clg ON clg.fk_portfolio = pat.id
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity ca ON ca.id = clg.fk_class_activity
WHERE ch.id not IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
)
GROUP BY ch.id, ch.birth_certificate;
-- residual_count
-- portfolio_class_teacher
SELECT ch.birth_certificate, clg.*, pat.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio_class_teacher clg ON clg.fk_portfolio = pat.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);


-- retained_count
-- portfolio_class_teacher
SELECT ch.birth_certificate, clg.*, pat.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio_class_teacher clg ON clg.fk_portfolio = pat.id;

-- expected_count_for_retention
-- portfolio_class_teacher
SELECT ch.birth_certificate, clg.*, pat.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.portfolio_class_teacher clg ON clg.fk_portfolio = pat.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
-- residual_count
-- portfolio
SELECT ch.birth_certificate, pat.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- portfolio
SELECT ch.birth_certificate, pat.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id;

-- expected_count_for_retention
-- portfolio
SELECT ch.birth_certificate,  pat.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.portfolio pat ON pat.fk_child = ch.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
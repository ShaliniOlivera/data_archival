-- residual_check
-- child_entry_mapping
SELECT ch.id, cem.*
FROM {ARCHIVED_SN2_DB}.child_entry_mapping cem
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cem.ep_id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- child_entry_mapping
SELECT ch.id, cem.*
FROM {ARCHIVED_SN2_DB}.child_entry_mapping cem
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cem.ep_id;

-- expected_count_for_retention
-- child_entry_mapping
SELECT ch.id, cem.*
FROM {SOURCE_SN2_DB}.child_entry_mapping cem
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cem.ep_id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

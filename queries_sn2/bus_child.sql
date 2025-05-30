-- residual_check
-- bus_child 
SELECT bc.*
FROM {ARCHIVED_SN2_DB}.bus_child bc
WHERE bc.fk_child IN ( 
   SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
   WHERE bc.fk_child = darch.fk_child
   )
;

-- retained_count
-- bus_child
SELECT bc.*
FROM {ARCHIVED_SN2_DB}.bus_child bc;

-- expected_count_for_retention
-- bus_child
SELECT bc.*
FROM {SOURCE_SN2_DB}.bus_child bc
WHERE bc.fk_child NOT IN ( 
   SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
   WHERE bc.fk_child = darch.fk_child
   )
;
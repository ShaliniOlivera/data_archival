1. WHAT IS DATA ARCHIVAL?

Activity where Vision squad archives data until certain year. Making the "Archived" DB contain only those that are LEFT from archival process.

2. WHAT THE MAIN SCRIPTS DO:

verify the discrepancies between databases - source (original data) and archived (contains only retained data after archival)

this can verify multiple tables from monolith, MS, and EP.

after verification, it will export the result in a .xlsx file that will contain multiple tabs | Summary , tabs for each tables executed

3. HOW TO USE THE FRAMEWORK:
Depending on which BU or architecture we need to test, we need to update the following:

queries_ep - folder that contains all queries for ep (.sql)
queries_ms - folder that contains all queries for for MS modules (.sql)
queries_sn2 - folder that contains all queries for Monolith modules (.sql)

sql_file_list_EP.py - contains the list of ".sql" files to be verified at a time for EP
sql_file_list_MS.py - contains the list of ".sql" files to be verified at a time for MS modules
sql_file_list_SN2.py - contains the list of ".sql" files to be verified at a time for Monolith modules

db_config.py - contains the databases to be used. note that the scripts should be replaced with the variable names declared in the db_config for ease of rerunning in case of switch of database e.g "{ARCHIVED_SN2_DB}"

Steps:
    1. Manually verify the correctness and completeness of the following tables:
        - child, parent, child_relation
    2. Once everything is clear on step 1, can now proceed to updating this framework for all necessary data verification (queries, file_list)
    3. to run, open terminal (type in "python3 <file to be executed>). below are the files to be executed depending on BU and architecture:
         - verify_ep_queries.py
         - verify_ms_queries.py
         - verify_sn2_queries.py

4. KEY NOTES:

4.1 the script treats ID as unique and base each record verification on the unique id. in the event that there needs to be multiple IDs, rename the other ones
4.2 discrepancies will be displayed in the summary wether the cause is missing records or mismatch in records
4.3 the .sql file must each have the following commented out "-- residual_check", "-- retained_count", "-- expected_count_for_retention" and below each is the identical table name. otherwise, the result will show multiple rows
4.4 "-- residual_check" query for the source database to check if everything from the tmp table for archival are all removed (result should always be 0)
4.5 "-- retained_count" query for the archived database to get what are actually retained
4.6 "-- expected_count_for_retention" query to get what are expected to be retained

import pymysql

def load_environment(config):
    if config == LSH_CONFIG:
        return {
            "source_connection": get_source_connection_lsh(),
            "archived_connection": get_archived_connection_lsh(),
            "placeholders": get_placeholder_mappings_lsh()
        }
    elif config == MFS_CONFIG:
        return {
            "source_connection": get_source_connection_mfs(),
            "archived_connection": get_archived_connection_mfs(),
            "placeholders": get_placeholder_mappings_mfs()
        }
    else:
        raise ValueError("Invalid DB config selected.")
    
# Shared connection configs
LSH_CONFIG = {
    'host': '127.0.0.1',
    'port': 5333,
    'user': 'skoolboy',
    'password': 'skoolpass123456'
}

MFS_CONFIG = {
    'host': '127.0.0.1',
    'port': 5334,
    'user': 'skoolboy',
    'password': 'skoolpass123456'
}

# LSH source and archived connections (single DB instance)
def get_source_connection_lsh():
    return pymysql.connect(**LSH_CONFIG)

def get_archived_connection_lsh():
    return pymysql.connect(**LSH_CONFIG)

# MFS source and archived connections (single DB instance)
def get_source_connection_mfs():
    return pymysql.connect(**MFS_CONFIG)

def get_archived_connection_mfs():
    return pymysql.connect(**MFS_CONFIG)

# Placeholder mappings
def get_placeholder_mappings_lsh():
    return {
        "SOURCE_SN2_DB": "skoolnet2_uat_20250402_v3",
        "ARCHIVED_SN2_DB": "skoolnet2_uat_20250402_v6",
        "SOURCE_MS_CICO_DB": "sn2_health_attendance_db_20250407_v3",
        "ARCHIVED_MS_CICO_DB": "sn2_health_attendance_db_20250407_v2"
    }

def get_placeholder_mappings_mfs():
    return {
        "SOURCE_SN2_DB": "skoolnet2_archival_mfs_sn2_20250303_v3",
        "ARCHIVED_SN2_DB": "skoolnet2_archival_mfs_sn2_20250303_v4",
        "SOURCE_MS_CICO_DB": "", #not provided yet
        "ARCHIVED_MS_CICO_DB": ""  #not provided yet
    }

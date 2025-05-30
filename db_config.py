import pymysql

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

EP_CONFIG = {
    'host': '127.0.0.1',
    'port': 5335,
    'user': 'skoolboy',
    'password': 'skoolpass123456'
}

# Environment loader
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
    elif config == EP_CONFIG:
        return {
            "source_connection": get_source_connection_ep(),
            "archived_connection": get_archived_connection_ep(),
            "placeholders": get_placeholder_mappings_ep()
        }
    else:
        raise ValueError("Invalid DB config selected.")

# Connection methods
def get_source_connection_lsh():
    return pymysql.connect(**LSH_CONFIG)

def get_archived_connection_lsh():
    return pymysql.connect(**LSH_CONFIG)

def get_source_connection_mfs():
    return pymysql.connect(**MFS_CONFIG)

def get_archived_connection_mfs():
    return pymysql.connect(**MFS_CONFIG)

def get_source_connection_ep():
    return pymysql.connect(**EP_CONFIG)

def get_archived_connection_ep():
    return pymysql.connect(**EP_CONFIG)

# Placeholder mappings
def get_placeholder_mappings_lsh():
    return {
        "SOURCE_SN2_DB": "skoolnet2_uat_20250526",
        "ARCHIVED_SN2_DB": "skoolnet2_uat_20250526_v2",
        "SOURCE_MS_CICO_DB": "sn2_health_attendance_db_20250514",
        "ARCHIVED_MS_CICO_DB": "sn2_health_attendance_db_20250514_v2",
        "SOURCE_MS_CLASSOPS_DB": "sn2_class_ops_db_20250506",
        "ARCHIVED_MS_CLASSOPS_DB": "sn2_class_ops_db_20250506_v2",
        "SOURCE_MS_PSS_DB": "sn2_pss_service_db_20250514",
        "ARCHIVED_MS_PSS_DB": "sn2_pss_service_db_20250514_v2",
        "SOURCE_MS_PIM_DB": "sn2_pim_service_db_20250514",
        "ARCHIVED_MS_PIM_DB": "sn2_pim_service_db_20250514_v2",
    }

def get_placeholder_mappings_mfs():
    return {
        "SOURCE_SN2_DB": "skoolnet2_archival_mfs_sn2_20250303_v4",
        "ARCHIVED_SN2_DB": "skoolnet2_archival_mfs_sn2_20250303_v10",
        "SOURCE_MS_CICO_DB": "sn2_health_attendance_db_20250512",
        "ARCHIVED_MS_CICO_DB": "sn2_health_attendance_db_20250512_v2",
        "SOURCE_MS_CLASSOPS_DB": "sn2_class_ops_db_20250508_v2",
        "ARCHIVED_MS_CLASSOPS_DB": "sn2_class_ops_db_20250508",
        "SOURCE_MS_PSS_DB": "sn2_pss_service_db_20250515",
        "ARCHIVED_MS_PSS_DB": "sn2_pss_service_db_20250515_v2",
        "SOURCE_MS_PIM_DB": "sn2_pim_service_db_20250515",
        "ARCHIVED_MS_PIM_DB": "sn2_pim_service_db_20250515_v2",
    }

def get_placeholder_mappings_ep():
    return {
        "SOURCE_SN2_DB": "skoolnet2_archival_mfs_ep_20250425_org",
        "ARCHIVED_SN2_DB": "skoolnet2_archival_mfs_ep_20250425",
    }

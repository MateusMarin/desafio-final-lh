resource "databricks_catalog" "raw_catalog" {
    name    = "${var.full_name}_raw"
    comment = "Raw data storage"
}

resource "databricks_schema" "raw_sales" {
    catalog_name = databricks_catalog.raw_catalog.name
    name         = "sales"
}

resource "databricks_catalog" "stg_catalog" {
    name    = "${var.full_name}_stg"
    comment = "Staging data storage"
}

resource "databricks_schema" "stg_sales" {
    catalog_name = databricks_catalog.stg_catalog.name
    name         = "sales"
}

# Permissões no catálogo RAW
resource "databricks_grants" "raw_catalog_grants" {
  catalog = databricks_catalog.raw_catalog.name

  grant {
    principal  = "users"  # Pode ser um grupo, usuário específico ou 'users' para todos
    privileges = ["USE_CATALOG", "SELECT", "MODIFY"]
  }
}

# Permissões no schema `sales` dentro do RAW
resource "databricks_grants" "raw_sales_grants" {
  schema = "${databricks_catalog.raw_catalog.name}.sales"

  grant {
    principal  = "users"
    privileges = ["SELECT", "MODIFY"]
  }
}

# Permissões no catálogo STG
resource "databricks_grants" "stg_catalog_grants" {
  catalog = databricks_catalog.stg_catalog.name

  grant {
    principal  = "users"
    privileges = ["USE_CATALOG", "SELECT", "MODIFY"]
  }
}

# Permissões no schema `sales` dentro do STG
resource "databricks_grants" "stg_sales_grants" {
  schema = "${databricks_catalog.stg_catalog.name}.sales"

  grant {
    principal  = "users"
    privileges = ["SELECT", "MODIFY"]
  }
}
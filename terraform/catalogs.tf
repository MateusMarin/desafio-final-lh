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
resource "databricks_catalog" "raw_catalog" {
    name = "${var.full_name}_raw"
    comment = "Raw data storage"
}

resource "databricks_catalog" "stg_catalog" {
    name = "${var.full_name}_stg"
    comment = "Staging data storage"
}
output "instance_name" {
  value = google_sql_database_instance.db_instance.name
}

output "instance_self_link" {
  value = google_sql_database_instance.db_instance.self_link
}

output "database_name" {
  value = google_sql_database.default_db.name
}

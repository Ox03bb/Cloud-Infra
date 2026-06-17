output "topic_id" {
  value = google_pubsub_topic.topic.id
}

output "topic_name" {
  value = google_pubsub_topic.topic.name
}

output "topic_self_link" {
  value = google_pubsub_topic.topic.id
}

output "subscription_id" {
  value = google_pubsub_subscription.subscription.id
}

output "subscription_name" {
  value = google_pubsub_subscription.subscription.name
}

output "subscription_self_link" {
  value = google_pubsub_subscription.subscription.id
}
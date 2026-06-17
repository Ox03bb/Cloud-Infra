resource "google_pubsub_topic" "topic" {
  name = var.topic_name

  labels = var.labels

  message_retention_duration = var.topic_message_retention_duration

  kms_key_name = var.kms_key_name
}

resource "google_pubsub_subscription" "subscription" {
  name  = var.subscription_name
  topic = google_pubsub_topic.topic.name

  ack_deadline_seconds = var.ack_deadline_seconds

  retain_acked_messages = var.retain_acked_messages

  message_retention_duration = var.subscription_message_retention_duration

  enable_message_ordering = var.enable_message_ordering

  filter = var.filter

  dynamic "expiration_policy" {
    for_each = var.expiration_ttl != null ? [1] : []

    content {
      ttl = var.expiration_ttl
    }
  }

  dynamic "push_config" {
    for_each = var.push_endpoint != null ? [1] : []

    content {
      push_endpoint = var.push_endpoint
    }
  }

  dynamic "dead_letter_policy" {
    for_each = var.dead_letter_topic != null ? [1] : []

    content {
      dead_letter_topic     = var.dead_letter_topic
      max_delivery_attempts = var.max_delivery_attempts
    }
  }

  dynamic "retry_policy" {
    for_each = (
      var.minimum_backoff != null &&
      var.maximum_backoff != null
    ) ? [1] : []

    content {
      minimum_backoff = var.minimum_backoff
      maximum_backoff = var.maximum_backoff
    }
  }
}

resource "google_pubsub_topic_iam_member" "publisher" {
  for_each = toset(var.publisher_members)

  topic  = google_pubsub_topic.topic.name
  role   = "roles/pubsub.publisher"
  member = each.value
}

resource "google_pubsub_subscription_iam_member" "subscriber" {
  for_each = toset(var.subscriber_members)

  subscription = google_pubsub_subscription.subscription.name
  role         = "roles/pubsub.subscriber"
  member       = each.value
}
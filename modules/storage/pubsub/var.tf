variable "topic_name" {
  type        = string
  description = "Pub/Sub topic name"
}

variable "subscription_name" {
  type        = string
  description = "Pub/Sub subscription name"
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to resources"
  default     = {}
}

variable "topic_message_retention_duration" {
  type        = string
  description = "Topic message retention duration"
  default     = null
}

variable "kms_key_name" {
  type        = string
  description = "KMS key for topic encryption"
  default     = null
}

variable "ack_deadline_seconds" {
  type        = number
  description = "Ack deadline"
  default     = 10
}

variable "retain_acked_messages" {
  type        = bool
  description = "Retain acknowledged messages"
  default     = false
}

variable "subscription_message_retention_duration" {
  type        = string
  description = "Subscription retention duration"
  default     = "604800s"
}

variable "enable_message_ordering" {
  type        = bool
  description = "Enable message ordering"
  default     = false
}

variable "filter" {
  type        = string
  description = "Subscription filter"
  default     = null
}

variable "expiration_ttl" {
  type        = string
  description = "Subscription expiration"
  default     = null
}

variable "push_endpoint" {
  type        = string
  description = "Push endpoint URL"
  default     = null
}

variable "dead_letter_topic" {
  type        = string
  description = "Dead letter topic"
  default     = null
}

variable "max_delivery_attempts" {
  type        = number
  description = "Maximum delivery attempts"
  default     = 5
}

variable "minimum_backoff" {
  type        = string
  description = "Retry minimum backoff"
  default     = null
}

variable "maximum_backoff" {
  type        = string
  description = "Retry maximum backoff"
  default     = null
}

variable "publisher_members" {
  type        = list(string)
  description = "Publisher IAM members"
  default     = []
}

variable "subscriber_members" {
  type        = list(string)
  description = "Subscriber IAM members"
  default     = []
}
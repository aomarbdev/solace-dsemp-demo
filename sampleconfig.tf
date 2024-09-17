terraform {
  required_providers {
    solacebroker = {
      source = "registry.terraform.io/solaceproducts/solacebroker"
    }
  }
}
/*
module "queue-endpoint" {
  source  = "SolaceProducts/queue-endpoint/solacebroker"
  version = "1.0.0"
  # insert the 4 required variables here
}
*/


# Configure the   provider
provider "solacebroker" {
  username = "solace-demo-admin"
  password = "mif0df790snl4agrs9n14umtks"
  url      = "https://mr-connection-gjywy1wv6ri.messaging.solace.cloud:943"
}

# Create a messaging queue
resource "solacebroker_msg_vpn_queue" "Q1" {
  msg_vpn_name    = "solace-demo"
  queue_name      = "DANONE-Q1"
  ingress_enabled = true
  egress_enabled  = true
}

resource "solacebroker_msg_vpn_queue" "Q2" {
  msg_vpn_name    = "solace-demo"
  queue_name      = "DANONE-Q2"
  ingress_enabled = true
  egress_enabled  = true
}

resource "solacebroker_msg_vpn_queue" "Q3" {
  msg_vpn_name    = "solace-demo"
  queue_name      = "DANONE-Q3"
  ingress_enabled = true
  egress_enabled  = true
}


module "queue_with_topic_subscriptions" {
  # update with the module location
  source  = "SolaceProducts/queue-endpoint/solacebroker"
  msg_vpn_name       = "solace-demo"
  endpoint_name      = "DANONE-Q1"
  endpoint_type      = "queue"

  # permission "consume" enables a messaging client to connect, read and consume messages to/from the queue
  permission         = "consume"

  # this will add the listed subscriptions to the queue
  queue_subscription_topics = ["foo/bar", "baz/>"]
}

/*
module "queue_with_topic_subscriptions" {
  # update with the module location
  #source  = "SolaceProducts/queue-endpoint/solacebroker"
  msg_vpn_name       = "solace-demo"
  endpoint_name      = "DANONE-Q2"
  endpoint_type      = "queue"

  # permission "consume" enables a messaging client to connect, read and consume messages to/from the queue
  permission         = "consume"

  # this will add the listed subscriptions to the queue
  queue_subscription_topics = ["foo/bar", "baz>"]
}

module "queue_with_topic_subscriptions" {
  # update with the module location
  source  = "SolaceProducts/queue-endpoint/solacebroker"
  msg_vpn_name       = "solace-demo"
  endpoint_name      = "DANONE-Q3"
  endpoint_type      = "queue"

  # permission "consume" enables a messaging client to connect, read and consume messages to/from the queue
  permission         = "consume"

  # this will add the listed subscriptions to the queue
  queue_subscription_topics = ["demo/danone/event3", "demo/danone/event4"]
}
*/

resource "solacebroker_msg_vpn_client_profile" "bar" {
  msg_vpn_name        = "solace-demo"
  client_profile_name = "admin"
  lifecycle {
    create_before_destroy = true
  }
}

resource "solacebroker_msg_vpn_client_profile" "bar1" {
  msg_vpn_name        = "solace-demo"
  client_profile_name = "developer"
  lifecycle {
    create_before_destroy = true
  }
}

resource "solacebroker_msg_vpn_client_profile" "bar2" {
  msg_vpn_name        = "solace-demo"
  client_profile_name = "factories"
  lifecycle {
    create_before_destroy = true
  }
}

/*
resource "solacebroker_msg_vpn_client_profile" "bar3" {
  msg_vpn_name        = "solace-demo"
  client_profile_name = "factory"
  lifecycle {
    create_before_destroy = true
  }
}
*/

resource "solacebroker_msg_vpn_client_username" "username" {
  msg_vpn_name        = "solace-demo"
  client_username     = "romain"
  client_profile_name = solacebroker_msg_vpn_client_profile.bar.client_profile_name
  enabled             = true
}

resource "solacebroker_msg_vpn_client_username" "username1" {
  msg_vpn_name        = "solace-demo"
  client_username     = "youssef"
  client_profile_name = solacebroker_msg_vpn_client_profile.bar.client_profile_name
  enabled             = true
}

resource "solacebroker_msg_vpn_client_username" "username2" {
  msg_vpn_name        = "solace-demo"
  client_username     = "luke"
  client_profile_name = solacebroker_msg_vpn_client_profile.bar1.client_profile_name
  enabled             = true
}

resource "solacebroker_msg_vpn_client_username" "username3" {
  msg_vpn_name        = "solace-demo"
  client_username     = "matthias"
  client_profile_name = solacebroker_msg_vpn_client_profile.bar2.client_profile_name
  enabled             = true
}

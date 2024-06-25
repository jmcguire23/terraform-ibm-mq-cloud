########################################################################################################################
# Outputs
########################################################################################################################

output "deployment" {
  value       = module.mqcloud_instance.deployment_guid
  description = "Deployment UID"
}

output "web_hostname" {
  value       = module.queue_manager.web_console_url
  description = "Web Console URL"
}

output "rest_endpoint" {
  value       = module.queue_manager.rest_api_endpoint_url
  description = "REST API Endpoint"
}

output "admin_api_endpoint" {
  value = module.queue_manager.administrator_api_endpoint_url
  description = "Administrator api endpoint url"
}

output "connection_info_uri" {
  value = module.queue_manager.connection_info_uri
  description = "URI to fetch connection information for queue manager"
}

output "qmgr_id" {
  value       = module.queue_manager.id
  description = "Queue Manager ID"
}

output "location" {
  value       = module.mqcloud_instance.queue_manager_options.locations[0]
  description = "First location available on the MQ on Cloud deployment"
}

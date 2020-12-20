output "service_node_port" {
  value = module.pseudo_service.webapp_service.spec[0].port[0].node_port
}

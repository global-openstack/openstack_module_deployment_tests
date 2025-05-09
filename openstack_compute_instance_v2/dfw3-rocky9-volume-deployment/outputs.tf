output "vm_ids" {
  description = "Map of VM names to their instance IDs"
  value       = module.openstack_vm.vm_ids
}

output "floating_ips" {
  description = "Map of VM names to their floating IPs"
  value       = module.openstack_vm.floating_ips
}

output "additional_volumes" {
  description = "Additional volumes attached to each VM"
  value       = module.openstack_vm.additional_volumes
}

output "additional_nics_ports" {
  description = "Details about additional NIC ports (IP, MAC address, network ID)"
  value       = module.openstack_vm.additional_nics_ports
}
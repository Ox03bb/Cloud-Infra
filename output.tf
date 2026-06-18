output "networks" {
  value = {
    for network_key, network in module.networks : network_key => {
      network_id        = network.network_id
      vpc_name          = network.vpc_name
      vpc_self_link     = network.vpc_self_link
      subnet_ids        = network.subnet_ids
      subnet_self_links = network.subnet_self_links
      subnet_cidrs      = network.subnet_cidrs
      subnet_regions    = network.subnet_regions
      global_ip         = network.global_ip
    }
  }
}

output "vms" {
  value = {
    for vm_key, vm in module.vms : vm_key => {
      vm_name              = vm.vm_name
      vm_zone              = vm.vm_zone
      vm_machine_type      = vm.vm_machine_type
      vm_network_interfaces = vm.vm_network_interfaces
      private_ips          = vm.private_ips
      public_ips           = vm.public_ips
      vm_tags              = vm.vm_tags
      vm_startup_script    = vm.vm_startup_script
    }
  }
}

output "ips" {
  value = {
    for vm_key, vm in module.vms : vm_key => {
      private_ips = vm.private_ips
      public_ips  = vm.public_ips
    }
  }
}

output "public_ips" {
  value = {
    for vm_key, vm in module.vms : vm_key => vm.public_ips
  }
}

output "private_ips" {
  value = {
    for vm_key, vm in module.vms : vm_key => vm.private_ips
  }
}
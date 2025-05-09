module "openstack_vm" {

  source              = "github.com/global-openstack/openstack_compute_instance_v2.git?ref=v1.2.0"
  vm_count            = 5
  use_name_formatting = true
  instance_base_name  = "rocky9-local-test"

  image_name          = "Rocky Linux 9"
  flavor_name         = "gp.5.4.8"
  key_pair            = "my_openstack_kp"
  security_groups     = ["default","dmz-sg"]

  destination_type    = "local"

  #user_data_file      = "cloud-init/user_data_mount_volumes.tpl"

  public_network_name = "PUBLICNET"

  network_name        = "DMZ-Network"
  subnet_name         = "dmz-subnet"

  #static_ips = ["192.168.0.10", "192.168.0.11", "192.168.0.12", "192.168.0.13", "192.168.0.14"]

  additional_nics = [
    {
      network_name = "Inside-Network"
      subnet_name  = "inside-subnet"
      security_groups = ["inside-sg"]
    }
  ]

  #add_nics_static_ips = ["172.16.0.10", "172.16.0.11", "172.16.0.12", "172.16.0.13", "172.16.0.14"]

  #additional_volumes = [
  #  { size = 10, type = "Performance" },
  #  { size = 20, type = "Standard" }
  #]
}
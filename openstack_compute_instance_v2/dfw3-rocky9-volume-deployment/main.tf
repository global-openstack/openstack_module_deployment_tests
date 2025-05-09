module "openstack_vm" {

  source              = "github.com/global-openstack/openstack_compute_instance_v2.git?ref=v1.2.0"
  vm_count            = 4
  use_name_formatting = true
  instance_base_name  = "rocky9-vol-test"

  image_name          = "Rocky Linux 9"
  flavor_name         = "gp.5.4.8"
  key_pair            = "my_openstack_kp"
  security_groups     = ["default","dmz-sg"]
  
  destination_type    = "volume"
  volume_size         = 20
  volume_type         = "Standard"

  user_data_file      = "cloud-init/user_data_mount_volumes.tpl"

  public_network_name = "PUBLICNET"

  network_name        = "DMZ-Network"
  subnet_name         = "dmz-subnet"

  additional_nics = [
    {
      network_name = "Inside-Network"
      subnet_name  = "inside-subnet"
      security_groups = ["inside-sg"]
    }
  ]

  additional_volumes = [
    { size = 10, type = "Performance" },
    { size = 20, type = "Standard" }
  ]
}
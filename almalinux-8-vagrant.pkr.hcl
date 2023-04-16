/*
 * AlmaLinux OS 8 Packer template for building Vagrant boxes.
 */

source "hyperv-iso" "almalinux-8" {
  iso_url               = var.iso_url_x86_64
  iso_checksum          = var.iso_checksum_x86_64
  boot_command          = var.vagrant_efi_boot_command
  boot_wait             = var.boot_wait
  generation            = 2
  switch_name           = var.hyperv_switch_name
  cpus                  = var.cpus
  memory                = var.memory
  enable_dynamic_memory = true
  disk_size             = var.vagrant_disk_size
  disk_block_size       = 1
  headless              = var.headless
  http_directory        = var.http_directory
  shutdown_command      = var.vagrant_shutdown_command
  communicator          = "ssh"
  ssh_username          = var.vagrant_ssh_username
  ssh_password          = var.vagrant_ssh_password
  ssh_timeout           = var.ssh_timeout
}

build {
  sources = ["sources.hyperv-iso.almalinux-8"]

  provisioner "ansible" {
    user = "vagrant"
    use_proxy = false
    ssh_authorized_key_file = var.ssh_authorized_key_file
    playbook_file    = "./ansible/vagrant-box.yml"
    galaxy_file      = "./ansible/requirements.yml"
    roles_path       = "./ansible/roles"
    collections_path = "./ansible/collections"
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False",
      "ANSIBLE_PIPELINING=True",
      "ANSIBLE_REMOTE_TEMP=/tmp",
      "ANSIBLE_SSH_ARGS='-o ControlMaster=no -o ControlPersist=180s -o ServerAliveInterval=120s -o TCPKeepAlive=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'"
    ]
    extra_arguments  = [
      "--extra-vars", "packer_provider=${source.type} ansible_ssh_pass=vagrant -e ansible_ssh_private_key_file=none"
    ]
  }

  post-processors {
    post-processor "vagrant" {
      compression_level = "9"
      output            = var.box_file_path
    }
  }
}

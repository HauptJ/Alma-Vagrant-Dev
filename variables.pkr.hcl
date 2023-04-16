variables {
  //
  // common variables
  //
  iso_url_x86_64        = "https://repo.almalinux.org/almalinux/8.5/isos/x86_64/AlmaLinux-8.5-x86_64-boot.iso"
  iso_checksum_x86_64   = "file:https://repo.almalinux.org/almalinux/8.5/isos/x86_64/CHECKSUM"
  iso_url_aarch64       = "https://repo.almalinux.org/almalinux/8.5/isos/aarch64/AlmaLinux-8.5-aarch64-boot.iso"
  iso_checksum_aarch64  = "file:https://repo.almalinux.org/almalinux/8.5/isos/aarch64/CHECKSUM"
  headless              = false
  boot_wait             = "10s"
  cpus                  = 4
  memory                = 6144
  post_cpus             = 1
  post_memory           = 1024
  http_directory        = "http"
  ssh_timeout           = "3600s"
  ssh_authorized_key_file  = env("SSH_PRIVATE_KEY")
  root_shutdown_command = "/sbin/shutdown -hP now"
  qemu_binary           = ""
  //
  // Hyper-V specific variables
  //
  hyperv_switch_name = "env("HYPER_V_SWITCH_NAME")"
  //
  // Vagrant specific variables
  //
  vagrant_boot_command = [
    "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux-8.vagrant.ks<enter><wait>"
  ]
  vagrant_efi_boot_command = [
    "e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux-8.vagrant.ks<leftCtrlOn>x<leftCtrlOff>"
  ]
  vagrant_disk_size        = 20000
  vagrant_shutdown_command = "echo vagrant | sudo -S /sbin/shutdown -hP now"
  vagrant_ssh_username     = "vagrant"
  vagrant_ssh_password     = "vagrant"
  //
  // Vagrant cloud
  //
  vagrant_cloud_token = env("VAGRANT_CLOUD_TOKEN")
  box_file_path = "almalinux-8-x86_64.{{isotime \"20060102\"}}.{{.Provider}}.box"
  box_tag = "hauptj/alma8dev"
  version = "0.1.0"
  user = "hauptj"
}
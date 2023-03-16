resource "proxmox_vm_qemu" "k8s-server" {
    
    for_each = var.servers

    # VM General Settings
    target_node = each.value.node
    vmid = each.value.vmid
    name = each.value.name
    desc = each.value.description

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = "ubuntu-server-k8s-template"
    qemu_os = "l26"
    # VM System Settings
    agent = 1
    
    # VM CPU Settings
    cores = each.value.cores
    sockets = each.value.sockets
    cpu = "host"
    
    # VM Memory Settings
    memory = each.value.memory

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
        macaddr = each.value.macaddr
    }

    # disk {
    #     type = "virtio"
    #     storage = "local-lvm"
    #     size = "16G"
    #     discard = "on"
    #     ssd = 1
    #     volume = "local-lvm:vm-${each.value.vmid}-disk-0"
    # }
    
    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    # ipconfig0 = "ip=0.0.0.0/0,gw=0.0.0.0"
    ipconfig0 = "ip=dhcp"
}
servers = {
  ctrlr = {
    vmid        = "800"
    node        = "mila"
    name        = "k8s-ctrlr"
    description = "Kubernetes controller"
    cores       = 4
    sockets     = 1
    memory      = 4096
    macaddr     = "12:B5:80:E7:0A:D0"
  }

  node-1 = {
    vmid        = "810"
    node        = "mila"
    name        = "k8s-node-1"
    description = "Kubernetes node"
    cores       = 2
    sockets     = 1
    memory      = 2048
    macaddr     = "96:B6:4F:7C:2B:13"
  }

  node-2 = {
    vmid        = "820"
    node        = "mila"
    name        = "k8s-node-2"
    description = "Kubernetes node"
    cores       = 2
    sockets     = 1
    memory      = 2048
    macaddr     = "52:7D:E5:01:C2:1E"
  }

  node-3 = {
    vmid        = "830"
    node        = "mila"
    name        = "k8s-node-3"
    description = "Kubernetes node"
    cores       = 2
    sockets     = 1
    memory      = 2048
    macaddr     = "62:85:0D:E8:EC:DA"
  }
}

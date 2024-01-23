servers = {
  ctrlr = {
    vmid        = "807"
    node        = "mila"
    name        = "k8s-ctrlr"
    description = "Kubernetes controller"
    cores       = 4
    sockets     = 1
    memory      = 4096
    macaddr     = "12:B5:80:E7:0A:D1"
  }

  node-1 = {
    vmid        = "808"
    node        = "mila"
    name        = "k8s-node-1"
    description = "Kubernetes node"
    cores       = 2
    sockets     = 1
    memory      = 2048
    macaddr     = "96:B6:4F:7C:2B:14"
  }
}

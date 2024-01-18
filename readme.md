# Homelab

This repository contains all the files I use to deploy my personal homelab.

It is deployed with the following:

- Proxmox Virtual Environment
    - The virtualization environment, where all the services live. I have nothing in the way of automating this requirement. If it ever breaks, or I want to add a new node, that is a manual step. But I feel that there is enough documentation, and since I'm not using ceph, it is pretty straightforward to setup.
- Packer
    - Used to create a linux template for the kubernetes controllers and nodes
- Terraform
    - It will provision the servers from the packer template. It will configure the new servers with the supplied IDs, ram and cpu count.
- Ansible
    - After the servers are created, ansible will take care of configuring the controller, and attaching the nodes.
- Kubernetes and fluxcd
    - Finally, all services are deployed using fluxcd.
    - SOPS is used for secret management.
    - SSL certificates are created inside the cluster with certbot from *let's encrypt*

The Makefile will contain some recipes for deploying all of this.

`make init-terraform` will init terraform. This is necessary to do one time, so that it can download the proxmox plugin

`make template` Will create a new template with packer

`make cluster` Will create the virtual machines configure the kubernetes cluster

`make bootstrap-flux` will bootstrap flux. If it's a new install, it will create the SOPS secret, otherwise it will just update the existing flux.

I'm still playing around with it, so some of these may not exactly work without some manual intervention.

# some commands

Besides these commands, there may be some extra commands not in the makefile

To add a new helm repository the following command will create the necessary yaml file, in the correct place:

```sh
HELM_NAME=new_service
HELM_REPO=htps://repo.com/service-charts

flux create source helm ${HELM_NAME} \
            --url ${HELM_REPO} \
            --interval 24h0m0s \
            --export > infrastructure/helm-repos/${HELM_NAME}.yaml
```

and to install a chart from the repository

```sh
HELM_NAME=new_service

mkdir apps/home-services/${HELM_NAME}

flux create helmrelease ${HELM_NAME} \
            --source=HelmRepository/${HELM_NAME} \
            --chart ${HELM_NAME} \
            --release-name ${HELM_NAME} \
            --target-namespace home-services \
            --interval 1440m0s \
            --export > apps/home-services/${HELM_NAME}/helmrelease.yaml
```

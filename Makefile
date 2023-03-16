
.PHONY: template
template:
	@$(MAKE)  -C provisioning/packer/

.PHONY: template
clean-template:
	@$(MAKE)  -C provisioning/packer/ clean

.PHONY: cluster
cluster:
	@$(MAKE)  -C provisioning/terraform/
	ansible-playbook -i provisioning/ansible/inventory provisioning/ansible/setup-kubernetes-cluster.yaml

.PHONY: clean-cluster
clean-cluster:
	@$(MAKE)  -C provisioning/terraform/ clean

.PHONY: init
init:
	@$(MAKE) -C provisioning/terraform/ init
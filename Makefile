
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
	flux bootstrap github \
		--owner=$$GITHUB_USER \
		--repository=kubernetes-home \
		--branch=main \
		--path=./clusters/home \
		--personal
	cat $$SOPS_AGE_KEY_FILE  | kubectl create secret generic sops-age --namespace=flux-system --from-file=age.agekey=/dev/stdin

.PHONY: clean-cluster
clean-cluster:
	@$(MAKE)  -C provisioning/terraform/ clean

.PHONY: init
init:
	@$(MAKE) -C provisioning/terraform/ init
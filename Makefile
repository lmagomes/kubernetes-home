.PHONY: template clean-template cluster clean-cluster bootstrap-flux clean-flux init

template:
	@echo 🎯 Creating kubernetes template
	@$(MAKE)  -C provisioning/packer/
	@echo 🎯 New template created

clean-template:
	@echo 🧹 Cleaning template
	@$(MAKE)  -C provisioning/packer/ clean
	@echo 🧹 Template delete issued

cluster:
	@echo 🎯 Creating kubernetes cluster
	@$(MAKE)  -C provisioning/terraform/
	@echo 🎯 Configuring the new kubernetes cluster
	@ansible-playbook -i provisioning/ansible/inventory provisioning/ansible/setup-kubernetes-cluster.yaml
	@echo 🎯 New kubernetes cluster created

clean-cluster:
	@echo 🧹 Deleting kubernetes cluster
	@$(MAKE)  -C provisioning/terraform/ clean
	@echo 🧹 kubernetes cluster deleted

bootstrap-flux:
	@echo 🎯 bootstraping flux
	@flux bootstrap github \
		--owner=$$GITHUB_USER \
		--repository=kubernetes-home \
		--branch=main \
		--path=./clusters/home \
		--personal
	@echo 🎯 Creating SOPS age kubernetes secret
	@cat $$SOPS_AGE_KEY_FILE  | kubectl create secret generic sops-age --namespace=flux-system --from-file=age.agekey=/dev/stdin
	@echo 🎯 flux bootstraped and configured

clean-flux:
	@echo 🧹 Uninstalling flux from the kubernetes cluster
	@flux uninstall --namespace=flux-system
	@echo 🧹 flux removed from kubernetes

init-terraform:
	@echo 🎯 Issuing an init to terraform
	@$(MAKE) -C provisioning/terraform/ init

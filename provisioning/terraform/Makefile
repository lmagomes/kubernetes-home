.PHONY: all
all:
	@sops --decrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.auto.tfvars.json
	@terraform apply -auto-approve --var-file=servers.auto.tfvars || true
	@sops --encrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.auto.tfvars.json

clean:
	@sops --decrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.auto.tfvars.json
	@terraform destroy -auto-approve --var-file=servers.auto.tfvars || true
	@sops --encrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.auto.tfvars.json

.PHONY: init
init:
	terraform init
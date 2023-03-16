.PHONY: all clean init

all:
	@sops --config /dev/null --decrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.auto.tfvars.json
	@terraform apply -auto-approve --var-file=servers.auto.tfvars || true
	@sops --config /dev/null --encrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.auto.tfvars.json

clean:
	@sops  --config /dev/null --decrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.auto.tfvars.json
	@terraform destroy -auto-approve --var-file=servers.auto.tfvars || true
	@sops  --config /dev/null --encrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.auto.tfvars.json

init:
	@terraform init

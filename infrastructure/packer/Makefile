.PHONY: all
all:
	@sops --decrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.pkr.json
	@$(MAKE)  -C ubuntu-server-k8s all || true
	@sops --encrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.pkr.json

clean:
	@sops --decrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.pkr.json
	@$(MAKE) -C ubuntu-server-k8s clean || true
	@sops --encrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.pkr.json
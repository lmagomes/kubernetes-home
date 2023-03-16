.PHONY: all
all:
	@sops  --config /dev/null --decrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.pkr.json
	@$(MAKE)  -C ubuntu-server-k8s all || true
	@sops  --config /dev/null --encrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.pkr.json

clean:
	@sops  --config /dev/null --decrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.pkr.json
	@$(MAKE) -C ubuntu-server-k8s clean || true
	@sops  --config /dev/null --encrypt -age $(shell cat ${SOPS_AGE_KEY_FILE} | grep -oP "public key: \K(.*)") --in-place credentials.pkr.json
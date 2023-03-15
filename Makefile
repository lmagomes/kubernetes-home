
.PHONY: template
template:
	@$(MAKE)  -C infrastructure/packer/

.PHONY: template
clean-template:
	@$(MAKE)  -C infrastructure/packer/ clean

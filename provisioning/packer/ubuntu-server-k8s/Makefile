.PHONY: all
all:
	packer build --var-file=../credentials.pkr.json ubuntu-server-k8s.pkr.hcl

clean: export NODE_NAME=$(shell cat ubuntu-server-k8s.pkr.hcl | grep node | cut -d'=' -f2 | sed 's/[ \"]//g')
clean: export VM_ID=$(shell cat ubuntu-server-k8s.pkr.hcl | grep vm_id | cut -d'=' -f2 | sed 's/[ \"]//g')
clean: export API_URL=$(shell cat ../credentials.pkr.json | grep url | cut -d' ' -f2 | sed 's/[ \",]//g')
clean: export API_TOKEN=$(shell cat ../credentials.pkr.json | grep token_id | cut -d' ' -f2 | sed 's/[ \",]//g')
clean: export API_SECRET=$(shell cat ../credentials.pkr.json | grep token_secret | cut -d' ' -f2 | sed 's/[ \",]//g')
clean:
	@echo "⚠️  Deleting current template ⚠️"
	@curl -X DELETE -H "Authorization: PVEAPIToken=${API_TOKEN}=${API_SECRET}" ${API_URL}/nodes/${NODE_NAME}/qemu/${VM_ID}
	@echo ""
	@echo "✅ Delete issued ✅"
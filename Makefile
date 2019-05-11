init:
	aws configure --profile tooploox-jaceks-task && \
	packer build packer/jenkins.json && \
	packer build packer/slave.json && \
	cd terraform && terraform init && \
	terraform plan && \
	cd -

apply:
	cd terraform && \
	terraform apply -auto-approve && \
	cd -

destroy:
	cd terraform && \
	terraform destroy -auto-approve && \
	echo "Please remember to manually deregister two Jenkins AMIs created by 'make init'! Didn't have time to automate that :)" && \
	cd -

packer:
	packer build packer/jenkins.json && \
	packer build packer/slave.json
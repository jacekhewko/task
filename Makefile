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
	aws ec2 deregister-image --image-id $MASTER-AMI && \
	aws ec2 deregister-image --image-id $SLAVE-AMI && \
	cd -

build:
	packer build packer/jenkins.json && \
	packer build packer/slave.json && \
	cd -

deregister:
	MASTER-AMI=$(cat terraform/metadata/master-ami-id.txt) && SLAVE-AMI=$(cat terraform/metadata/slave-ami-id.txt) && \
	aws ec2 deregister-image --image-id $MASTER-AMI && \
	aws ec2 deregister-image --image-id $SLAVE-AMI && \
	cd -
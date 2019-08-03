ifeq (,$(wildcard .env))
$(error "Please create the .env file first. Use .env.dist as baseline.")
endif

ifeq (, $(shell which aws))
$(error "AWS CLI was not detected in $(PATH). Please install it first.")
endif

include .env

launch_stack:
	aws cloudformation create-stack \
		--stack-name ${StackName} \
		--template-body file://cloudformation-template-AD-and-OpenVPN.yaml \
		--profile ${AwsProfile} \
		--capabilities CAPABILITY_IAM  CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
		--parameters $(cat parameters.json)
	aws cloudformation wait stack-create-complete --stack-name ${StackName} --profile ${AwsProfile}
update_stack:
	aws cloudformation update-stack \
		--stack-name ${StackName} \
		--template-body file://cloudformation-template-AD-and-OpenVPN.yaml \
		--profile ${AwsProfile} \
		--capabilities CAPABILITY_IAM  CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
		--parameters $(cat parameters.json)
	aws cloudformation wait stack-update-complete --stack-name ${StackName} --profile ${AwsProfile}


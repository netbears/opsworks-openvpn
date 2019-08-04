# OpsWorks OpenVPN cookbook

## Notes about the stacks
1) CloudFormation:
- it's an infrastructure-as-code stack deployment script written by AWS that creates resources based on the definition within the file
- The format is simple: YAML fille with at least a `Resources` key in which you define your resources
- More information here: https://aws.amazon.com/cloudformation/

2) OpsWorks:
- it's a "control-plane" that provisions Chef-based resources using custom cookbooks
- the "master" instance is self-managed and FREE, as provided by AWS
- the stacks can contain `Layers`, which encompass `Instances` that are bootstrapped using a custom cookbook created by the user
- More info here: https://aws.amazon.com/opsworks/

## Prerequisites
* In order for ALL resources to be properly bootstrapped to this cluster, the following needs to pre-exist:
-> ElasticSearch running and proper network peering between the new k8s and ES (for logs)
-> SimpleAD or normal ActiveDirectory running and proper peering between the new k8s and AD (used as LDAP authentication backend for auxiliary services - eg Grafana)

## Deploy stack
* Create an `.env` file based on `.env.dist`
* Deploy the cloudformation template
```bash
make launch_stack
```
* Deploy the auxiliary resources (OPTIONAL)
```bash
make bootstrap
```

## Make changes to deployment
* Make your changes to the YAML files
* Deploy (just) the YAML file changes
```bash
make deploy
```

## SSH permissions

SSH is handled by OpsWorks automatically. In order to grant a user SSH permissions, the following needs to happen:
1) The user needs to have an SSH public key set up

To do that, have the user go here to the `Users` menu in OpsWorks, click on his IAM user, then on `Edit`, paste the public key and then hit `Save`.

Or you can do that for him. Whatever makes more sense for you.

2) Assign `SUDO` and/or `SSH` permissions in the `Permissions` tab for the stack that you want to give him permissions for.

Click on `Edit`, tick the boxes for `sudo` and/or `ssh` and hit `Save`

3) The OpsWorks agent should automatically run the default recipe on all instances and give access to the user within 5 minutes.

If that doesn't happen or you want to speed things up, just go to the `Deployments` tab, hit `Run Command` and execute the `Configure` command on all running instances.

## Add new nodes to cluster

* Go to your CloudFormation stack
* Click on `Update using current template`
* Update values for `NodeAutoScalingGroupMinSize` and/or `NodeAutoScalingGroupMaxSize`

## Monitoring
The stack automatically deploys the following logic:
- NodeExporter: which is connected to the internal Prometheus service
- CloudWatch: detailed-monitoring is enabled for both ASGs and SpotFleets

## Logging
The stack pushes all ElasticSearch logs within to filebeat, they get filtered with logstash and then pre-defined ElasticSearch stack under index `filebeat-*`.

## Security concerns
* This stack is missing an ingress controller, therefore any services that need to be publicly available have to use a LoadBalancer
* If you don't want to use the LoadBalancer approach for each service, you should consider deploying an ingress-controller (such as nginx-ingress-controller or traefik-ingress-controller) and expose the services through Ingress rules with a ClusterIP

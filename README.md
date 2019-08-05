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

## Manage users and permissions in LDAP

1) Install AD  Administration Tools -> https://docs.aws.amazon.com/directoryservice/latest/admin-guide/simple_ad_install_ad_tools.html
2) Create a user -> https://docs.aws.amazon.com/directoryservice/latest/admin-guide/simple_ad_manage_users_groups_create_user.html
3) Reset a user password -> https://docs.aws.amazon.com/directoryservice/latest/admin-guide/simple_ad_manage_users_groups_reset_password.html
4) Create a group -> https://docs.aws.amazon.com/directoryservice/latest/admin-guide/simple_ad_manage_users_groups_create_group.html
5) Add a user to a group -> https://docs.aws.amazon.com/directoryservice/latest/admin-guide/simple_ad_manage_users_groups_add_user_to_group.html

## Make changes to deployment
* Make your changes to the YAML files
* Deploy (just) the YAML file changes
```bash
make update_stack
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

## Monitoring
The stack automatically deploys the following logic:
- NodeExporter: which can be connected to any running Prometheus instance
- CloudWatch: because underlying system is OpsWorks for provisioning, you get the benefits of exporting automatically granular data to CloudWatch which can be viewed in the Monitoring section of the stack
- Metricbeat: this is available through the Kibana UI and offers more detailed information about the running nodes (available only if `OpenVPNMetricbeatEnabled` is set to `true` in `.env`)

## Logging
The stack pushes all ElasticSearch logs within to filebeat and then they get sent to the pre-defined ElasticSearch stack under index `filebeat-*`  (available only if `OpenVPNFilebeatEnabled` is set to `true` in `.env`).

## Security concerns
* For all intents and purposes, you should set the `EnableMfa` parameter to true in CloudFormation (`OpenVPNEnableMfa` to `true` in `.env`) so that your users are enforced to use and setup Multi-Factor Authentication

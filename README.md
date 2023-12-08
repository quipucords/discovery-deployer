# Quipucords Deployer

Helm Chart for the Discovery product.

Install and Uninstall the Discovery product to OpenShift and Kubernetes via the `helm` command-line tool which must be installed as a prerequisite.

The Helm chart lives in the `discovery` subdirectory and can be installed as follows:

```
$ oc login https://api.<your_cluster>:6443 -u kubeadmin -p <kubeadmin_password>
$ oc project discovery-dev
$ helm install discovery ./discovery
NAME: discovery-1612624192
LAST DEPLOYED: Sun Dec  3 16:09:56 2023
NAMESPACE: discovery-dev
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES: ... 
```

To uninstall the above release of discovery, specify the instance name:

```
$ oc project discovery-dev
$ helm uninstall discovery-1612624192
release "discovery-1612624192" uninstalled
```



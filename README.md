#### Quipucords Deployer is now archived in favor of using the Quipucords Helm Chart for deploying Discovery to OpenShift and Kubernetes Clusters.
See:
#### Discovery Helm Chart - https://quipucords/quipucords-helm-chart
#### Discovery Helm Repo - https://quipucords/quipucords-helm-repo


# Quipucords Deployer
Script and template for deploying the Discovery product to OpenShift.

```
discodeploy [--help] [--deploy | --create-pull-secret | --undeploy]
```

run:

```
$ discodeploy --help
```

To see the additional help for running the command.

Primary usage to deploy Discovery to OpenShift:

```
$ discodeploy --deploy
```

And to undeploy Discovery from OepnShift:

```
$ discodeploy --undeploy
```

Also, best to visit the [Quipucords Deployer Wiki](https://github.com/quipucords/quipucords-deployer/wiki) pages for more detailed documentation.

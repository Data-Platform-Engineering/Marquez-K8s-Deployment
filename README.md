# Marquez-K8s-Deployment
# Marquez [Helm Chart](https://helm.sh)

Helm Chart for [Marquez](https://marquezproject.ai/).

## TL;DR;
Run all commands within the "chart" folder, with default configurations.

```bash
helm install marquez . --dependency-update
```

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

## Installing the Chart

To install the chart with the release name `marquez` using a fresh Postgres instance.

```bash
helm install marquez . --dependency-update --set postgresql.enabled=true
```

> **Note:** For a list of parameters that can be overridden during installation, see the [configuration](#configuration) section.


## Uninstalling the Chart

To uninstall the `marquez ` deployment:

```bash
helm delete marquez
```

## Configuration

### [Marquez](https://github.com/MarquezProject/marquez) **parameters**

| Parameter                    | Description                            | Default                  |
|------------------------------|----------------------------------------|--------------------------|
| `marquez.serviceAccount`     | K8s service account for Marquez Deploy | `default`                |
| `marquez.replicaCount`       | Number of desired replicas             | `1`                      |
| `marquez.image.registry`     | Marquez image registry                 | `docker.io`              |
| `marquez.image.repository`   | Marquez image repository               | `marquezproject/marquez` |
| `marquez.image.tag`          | Marquez image tag                      | `0.15.0`                 |
| `marquez.image.pullPolicy`   | Image pull policy                      | `IfNotPresent`           |
| `marquez.existingSecretName` | Name of an existing secret containing db password ('marquez-db-password' key) | `nil` |
| `marquez.db.host`            | PostgreSQL host                        | `localhost`              |
| `marquez.db.port`            | PostgreSQL port                        | `5432`                   |
| `marquez.db.name`            | PostgreSQL database                    | `marquez`                |
| `marquez.db.user`            | PostgreSQL user                        | `buendia`                |
| `marquez.db.password`        | PostgreSQL password                    | `macondo`                |
| `marquez.migrateOnStartup`   | Execute Flyway migration               | `true`                   |
| `marquez.hostname`           | Marquez hostname                       | `localhost`              |
| `marquez.port`               | API host port                          | `5000`                   |
| `marquez.adminPort`          | Heath/Liveness host port               | `5001`                   |
| `marquez.resources.limits`   | K8s resource limit overrides           | `nil`                    |
| `marquez.resources.requests` | K8s resource requests overrides        | `nil`                    |
| `marquez.podAnnotations`     | Additional pod annotations for Marquez | `{}`                     |
| `marquez.extraContainers`    | Additional container definitions to include inside Marquez Pod | `[]` |

### [Marquez Web UI](https://github.com/MarquezProject/marquez-web) **parameters**

| Parameter                | Description                     | Default        |
|--------------------------|---------------------------------|----------------|
| `web.enabled`            | Enables creation of Web UI      | `true`         |
| `web.replicaCount`       | Number of desired replicas      | `1`            |
| `web.image.registry`     | Marquez Web UI image registry   | `docker.io`    |
| `web.image.repository`   | Marquez Web UI image repository | `marquez-web`  |
| `web.image.tag`          | Marquez Web UI image tag        | `0.15.0`       |
| `web.image.pullPolicy`   | Image pull policy               | `IfNotPresent` |
| `web.port`               | Marquez Web host port           | `5000`         |
| `web.resources.limits`   | K8s resource limit overrides    | `nil`          |
| `web.resources.requests` | K8s resource requests overrides | `nil`          |

### [Postgres](https://github.com/bitnami/charts/blob/master/bitnami/postgresql/values.yaml) (sub-chart) **parameters**

| Parameter                        | Description                     | Default   |
|----------------------------------|---------------------------------|-----------|
| `postgresql.enabled`             | Deploy PostgreSQL container(s)  | `false`   |
| `postgresql.image.tag`           | PostgreSQL image version        | `12.1.0`  |
| `postgresql.auth.username`       | PostgreSQL username             | `buendia` |
| `postgresql.auth.password`       | PostgreSQL password             | `macondo` |
| `postgresql.auth.database`       | PostgreSQL database             | `marquez` |
| `postgresql.auth.existingSecret` | Name of existing secret object  | `nil`     |

### Common **parameters**

| Parameter              | Description                         | Default |
|------------------------|-------------------------------------|---------|
| `global.imageRegistry` | Globally overrides image registry   | `nil`   |
| `commonLabels`         | Labels common to all resources      | `nil`   |
| `commonAnnotations`    | Annotations common to all resources | `nil`   |
| `affinity`             | Affinity for pod assignment         | `nil`   |
| `tolerations`          | Tolerations for pod assignment      | `nil`   |
| `nodeSelector`         | Node labels for pod assignment      | `nil`   |

### Service **parameters**

| Parameter             | Description                         | Default     |
|-----------------------|-------------------------------------|-------------|
| `service.type`        | Networking type of all services     | `ClusterIP` |
| `service.port`        | Port to expose services             | `80`        |
| `service.annotations` | Annotations applied to all services | `nil`       |

### Ingress **parameters**

| Parameter             | Description                        | Default |
|-----------------------|------------------------------------|---------|
| `ingress.enabled`     | Enables ingress settings           | `false` |
| `ingress.annotations` | Annotations applied to ingress     | `nil`   |
| `ingress.hosts`       | Hostname applied to ingress routes | `nil`   |
| `ingress.tls`         | TLS settings for hostname          | `nil`   |

## Local Installation Guide

### Helm Managed Postgres

The quickest way to install Marquez via Kubernetes is to create a local Postgres instance.

```bash
helm install marquez . --dependency-update --set postgresql.enabled=true
```

If you haven't configured ingress within the Helm chart values, then you can use the
following port forwarding rules to support local development.

```bash
kubectl port-forward svc/marquez 5000:80
```

```bash
kubectl port-forward svc/marquez-web 3000:80
```

Once these rules are in place, you can view both the APIs and UI using the
links below.
* http://localhost:5000/api/v1/namespaces
* http://localhost:3000


Plug this pod name into the following command, and it will display logs related
to the database migrations. This makes it simple to see errors dealing with
networking issues, credentials, etc.

```bash
kubectl logs -p <podName>
```

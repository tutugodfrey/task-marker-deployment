# task-marker-deployment
Kubernetes deployment configuration for task marker app

## Argocd set up

Create a namespace for argocd

```bash
kubectl create namespace argocd
```

Deploy argocd k8s resource

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

To see what was created, run

```bash
kubectl get all -n argocd
```

To enable access to the argocd server, we'll change the service type to NodePort. The `argocd-server.yaml` file contain the template to edit the argocd-server resource which was created as ClusterIP by default.

```bash
kubectl apply -f argocd-server.yaml
```

View the server service

```bash
kubectl get service -n argocd
```

The server can be access with a `node ip address` over http on port `30007` and https on port `30008`

### Login to the argocd UI

To get the password to login to argocd UI, execute the comman below

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

**Note:** Default username is `admin`

                         
## Create the backend application

To deploy backend application execute the command below

```bash
kubectl create -f argocd-applications/frontend-app.yaml
```

## Create the frontend application

To deploy the frontend application execute the command below

```bash
kubectl create -f argocd-applications/frontend-app.yaml
```

## Configure argocd image updater

Deploy the argocd image updater resources

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/v0.9.0/manifests/install.yaml
```


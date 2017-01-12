# Kubernetes Ressources & Applications

## Deployment

Deploy an application as a Deployment with a NodePort service:

```
kubectl apply -f 01_deployments/caddy_deployment_service.yaml
```

Test with:

```
kubectl get pods,deployments
kubectl delete pod [id]
kubectl get pods
curl "http://k.mpc.tech:30008"
```

## DeamonSet

Deploy traefik as a DeamonSet:

```
kubectl apply -f 02_daemonsets/traefik_daemontset.yaml
```

Test with:

```
kubectl get pods -o wide
chromium 'http://k.mpc.tech:2727/dashboard/#!/'
```

## Ingress

Deploy an Ingress and a ClusterIP service:

```
kubectl apply -f 03_ingress/caddy_ingress_service.yaml
```

Test with:

```
chromium 'http://k.mpc.tech:2727/dashboard/#!/'
curl "http://t.mpc.tech"
```

## Rolling Update

Update Deployment to v0.2

```
kubectl set image deployment/mycaddy-deployment mycaddy=sontags/mycaddy:v0.2 && kubectl rollout status deployment/mycaddy-deployment
```

Test with:

```
curl "http://k.mpc.tech"
```


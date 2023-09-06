# MongoDB Express Deployment

This project includes Kubernetes YAML configuration for deploying MongoDB Express as a Kubernetes Deployment and Service as well as Mongo DB as satefulset.

## Description

This set of Kubernetes manifests deploys a configMap, kubernetes secrete, Mongodb statefulset, mongoDB Express app as well as Ingress and services within your Kubernetes cluster. MongoDB Express is a web-based MongoDB admin interface.

### Deployment

The main files are `mongodb-deploy.yaml` and `web-app.yaml` -> this is your mongo express app file which defines a Kubernetes Deployment for MongoDB Express.

- First deploy your kubernetes configMap and secret `mongo-config.yaml` & `mongo-secret.yaml`
- Deploy Headless service for statefulset `kubectl apply -f headless-svc.yaml`
- Deploy mongodb statefulset using `kubectl apply -f mongodb-deploy.yaml`
- Configure mongodb cluster **repliset** followinfg below instructions
   
   kubectl exec -it mongo-0 -- mongosh \
   rs.initiate() \
   var cfg = rs.conf() \
   cfg.members[0].host="mongo-0.mongo:27017" \
   rs.reconfig(cfg) \
   rs.status() \
   rs.add("mongo-1.mongo:27017") \
   rs.add("mongo-2.mongo:27017")

   **Make sure you can see all replicasets sync and healthy**
   
- Deploy MongoDb Express `kubectl apply -f mongoDB-express.yaml`
- Deploy ingress `kubectl apply -f ingress.yaml`

### Services
- Service name: `mongo` - Headless service for mongodb statefulset
- Service name: `mongo-express`internal Cluster IP for mongo-express to commuincate externally using ingress
- Ports mapping: Port 8081

## Prerequisites

Before deploying MongoDB Express, ensure you have the following resources and configurations in place:

1. **MongoDB Database**: Ensure you have a MongoDB database deployed and accessible. The `ME_CONFIG_MONGODB_URL` environment variable should point to the database cluster.

2. **Kubernetes Cluster**: You should have a working Kubernetes cluster where you can apply these configurations.

3. **Secrets and ConfigMap**: Create Kubernetes Secrets and a ConfigMap with the necessary MongoDB connection details and mount them into the MongoDB Express Deployment.


# Cleanup
To remove the MongoDB Express Deployment and Service, use the following commands:

### Delete deployments/sattefulset
`kubectl delete -f <all files applied>`

### Delete pvc
`kubectl get pvc`
`kubectl delete <all pvc's>`


# Author
Aminu Ndakun


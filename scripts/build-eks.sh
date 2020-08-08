#########################################################
# YOU MAY NOT NEED TO EXECUTE ALL OF THE COMMANDS  
# USE IT SELECTIVELY     
#########################################################

AWS_REGION="<your-aws-region>"
NODE_TYPE="<instance-node-type>"
CLUSTER_NAME="<your-cluster-name>"
SERVICE_NAME="<your-service-name>"
AWS_PROFILE="<your-aws-profile-name>"

# To create a EKS cluster
eksctl create cluster --name=${CLUSTER_NAME} --nodes=1 --managed --alb-ingress-access --full-ecr-access --region=${AWS_REGION} --node-type=${NODE_TYPE}  --profile=${AWS_PROFILE}

# To install aws-iam-authenticator
brew install aws-iam-authenticator

# To update .kube/config
aws eks --region ${AWS_REGION} update-kubeconfig --name ${CLUSTER_NAME} --profile=${AWS_PROFILE}

# To ensure the ELB service role exists
aws iam get-role --role-name "AWSServiceRoleForElasticLoadBalancing" --profile=${AWS_PROFILE} || aws iam create-service-linked-role --aws-service-name "elasticloadbalancing.amazonaws.com" --profile=${AWS_PROFILE}

# To deploy your manifests 
kubectl apply -f manifests/deployment.yaml 
kubectl apply -f manifests/service.yaml 
kubectl apply -f manifests/ingress.yaml 

# To verifiy your deployments
kubectl get deployment 
kubectl get service 
kubectl get pod

# To debug "Insufficient pods" issue

# Events:
#   Type     Reason            Age                 From               Message
#   ----     ------            ----                ----               -------
#   Warning  FailedScheduling  17s (x14 over 18m)  default-scheduler  0/1 nodes are available: 1 Insufficient pods.

# To get the maximum number of pods per node
kubectl get nodes -o yaml | grep pods

# To check the current pod
kubectl get pods --all-namespaces | grep Running | wc -l

# To check the elb address
kubectl get service ${SERVICE_NAME}  -o json | jq -r '.status.loadBalancer.ingress[].hostname'
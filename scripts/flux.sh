#########################################################
# YOU MAY NOT NEED TO EXECUTE ALL OF THE COMMANDS       
# USE IT SELECTIVELY     
#########################################################

GH_USER="<your-github-user>"
GH_REPO="<your-github-repo>"
GH_MANIFEST="<your-github-manifest-path>"
FLUX_NAMESPACE="<your-flux-namespace>"

# To create a namespace
kubectl create ns ${FLUX_NAMESPACE}

# To install Flux object under ${FLUX_NAMESPACE} namespace
fluxctl install \
    --git-user=${GH_USER} \
    --git-email=${GH_USER}@users.noreply.github.com \
    --git-url=git@github.com:${GH_USER}/${GH_REPO} \
    --git-path=${GH_MANIFEST} \
    --namespace=${FLUX_NAMESPACE} | kubectl apply -f -

# To verify if the deployment is running or not
kubectl get all -n ${FLUX_NAMESPACE}

# To get a deploy key to setup in Github
fluxctl identity --k8s-fwd-ns ${FLUX_NAMESPACE}

# To synchronize your repository
fluxctl sync --k8s-fwd-ns ${FLUX_NAMESPACE}

# To check the current autiomated policies
fluxctl list-controllers --k8s-fwd-ns=${FLUX_NAMESPACE}

# To update the cluster role binding config if you have multiple repositories
kubectl edit clusterrolebinding.rbac.authorization.k8s.io/flux

# To make a release
fluxctl release --k8s-fwd-ns=${FLUX_NAMESPACE} --workload=default:deployment/${FLUX_NAMESPACE} --update-all-images


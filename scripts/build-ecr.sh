#########################################################
# YOU MAY NOT NEED TO EXECUTE ALL OF THE COMMANDS  
# USE IT SELECTIVELY     
#########################################################

APP_NAME="<your-app-name>"
GH_REPO="<your-github-repo>"
AWS_REGION="<your-aws-region>"
AWS_PROFILE="<your-aws-profile-name>"

# To create an ECR repository
aws ecr create-repository --repository-name ${GH_REPO} --region ${AWS_REGION} --profile=${AWS_PROFILE}

# To tag your image
docker tag ${APP_NAME}:latest XXXXXXXXXXXX.dkr.ecr.${AWS_REGION}.amazonaws.com/${APP_NAME}:latest

# To push the image to the repository you just created
docker push XXXXXXXXXXXX.dkr.ecr.${AWS_REGION}.amazonaws.com/${APP_NAME}:latest

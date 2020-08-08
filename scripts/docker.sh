APP_NAME="<your-app-name>"
APP_PORT="<your-port>"
DOCKER_TAG="<your-tag-name>"
IMAGE_ID=$(docker images --format="{{.Repository}} {{.ID}}" | grep "^${DOCKER_TAG} " | cut -d' ' -f2)

# To run your image
docker run -d -p ${APP_PORT}:${APP_PORT} --name ${APP_NAME} ${IMAGE_ID}
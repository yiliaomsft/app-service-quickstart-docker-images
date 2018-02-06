DOCKER_IMAGE_NAME=$1
DOCKER_IMAGE_VERSION=$2

# If script run to error, exist -1;
function _do() 
{
        "$@" || { echo "exec failed: ""$@"; exit -1; }
}

setTag_push_rm(){
    echo "TAG: ${TAG}"
    _do docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_ACCOUNT}"/"${DOCKER_IMAGE_NAME}":"${TAG}"
    testBuildImage=$(docker images | grep "$TAG")
    if [ -z "${testBuildImage}" ]; then 
        echo "FAILED - Set TAG Failed!!!"
        exit 1
    else
        echo "${testBuildImage}"
        echo "${testBuildImage}" >> result.log
        echo "PASSED - Set TAG Successfully!."
        echo "PASSED - Set TAG Successfully!." >> result.log
    fi
    _do docker push "${DOCKER_ACCOUNT}"/"${DOCKER_IMAGE_NAME}":"${TAG}"
    echo "PASSED - Pushed  ${DOCKER_ACCOUNT}/${DOCKER_IMAGE_NAME}:${TAG} Successfully!."
    echo "PASSED - Pushed  ${DOCKER_ACCOUNT}/${DOCKER_IMAGE_NAME}:${TAG} Successfully!." >> result.log
    echo "INFORMATION: Before rmi - docker images"
    _do docker images
    echo "INFORMATION - RM ""${DOCKER_ACCOUNT}"/"${DOCKER_IMAGE_NAME}":"${TAG}"
    _do docker rmi "${DOCKER_ACCOUNT}"/"${DOCKER_IMAGE_NAME}":"${TAG}"
    echo "INFORMATION - After rmi - docker images"
    _do docker images
}

echo "Stage1 - Set Tag and Push"
echo "Stage1 - Set Tag and Push" >> result.log
echo "Build Number: ${TRAVIS_BUILD_NUMBER}"
echo "TRAVIS_EVENT_TYPE: ${TRAVIS_EVENT_TYPE}"
echo "TRAVIS_COMMIT_MESSAGE: ${TRAVIS_COMMIT_MESSAGE}"

# "#sign-off exist!"
if [ $DOCKER_USERNAME == $PROD_DOCKER_USERNAME ]; then
    echo "INFORMATION - This time, push to production docker repo......"    
    TAG=${DOCKER_IMAGE_VERSION}       
else
    echo "INFORMATION - This time, push to Testing docker repo ....."    
    TAG=${DOCKER_IMAGE_VERSION}"-"${TRAVIS_BUILD_NUMBER}        
fi
echo "INFORMATION - Set TAG as ""${TAG}"" and push......" 
setTag_push_rm

echo "========================================"
echo "Stage2 - PULL and Verify"
echo "INFORMATION - Start to Pull ""${DOCKER_ACCOUNT}"/"${DOCKER_IMAGE_NAME}":"${TAG}"
echo "INFORMATION - Before Pull - docker images"
_do docker images
_do docker run -d -p 80:80 --name testdocker $DOCKER_ACCOUNT/${DOCKER_IMAGE_NAME}:"$TAG"
echo "INFORMATION: After Pull - docker images"
_do docker images
testBuildImage=$(docker images | grep "${TAG}")
    if [ -z "$testBuildImage" ]; then 
        echo "FAILED - Docker pull and run Failed!!!"
        docker images
        exit 1
    else
        echo "$testBuildImage"
        echo "$testBuildImage" >> result.log
        echo "PASSED - Docker image pull and run Successfully!. You can manually verify it!"
        echo "PASSED - Docker image pull and run Successfully!. You can manually verify it!" >> result.log
    fi
_do docker stop testdocker
_do docker rm testdocker
_do docker rmi ${DOCKER_ACCOUNT}"/"${DOCKER_IMAGE_NAME}":"${TAG}

# Deal With latest version
if [ $DOCKER_USERNAME == $PROD_DOCKER_USERNAME ]; then #Is it "#sign-off"?
    _do cd ${DOCKER_IMAGE_NAME}
    if test -e latest.txt; then
        LATEST_VERSION=$(cat latest.txt)
        _do cd ..
        echo "LATEST_VERSION:"$LATEST_VERSION
        if [ $DOCKER_IMAGE_VERSION == $LATEST_VERSION ]; then             
            echo "INFORMATION - This time, also need to push as latest version......"
            echo "INFORMATION - This time, also need to push as latest version......" >> result.log    
            TAG="latest"
            echo "INFORMATION - Set TAG as ""${TAG}"" and push......" 
            setTag_push_rm        
        fi
    else
        _do cd ..
    fi    
fi

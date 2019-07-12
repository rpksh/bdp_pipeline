//************ COMMON PARAMETERS ************//

env.GIT_CREDENTIALS = 'ec1cfdb5-30d1-4a1b-a19d-1249661445a0'
env.MANIFEST_GIT_DIR = "dir_pipeline"
env.MANIFEST_GIT_PROD_DIR = "dir_pipeline_prod"
env.APP_DIR = "dir_app"
env.ARTIFACT_DIR = "tenant"
env.KUBECONFIG = "${WORKSPACE}/${APP_NAME}_${DATACENTER}_${ENVIRONMENT}_kubeconfig"
env.DOCKER_REGISTRY = ""
env.SRC_DOCKER_IMAGE = ""
env.APP_VERSION = sh(script: 'echo -n $(date "+0.0.%Y%m%d".${BUILD_NUMBER}."%s")', returnStdout: true)
env.SDKMAN_DIR="/usr/local/sdkman"

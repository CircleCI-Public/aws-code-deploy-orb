#!/bin/sh
ORB_EVAL_APPLICATION_NAME="$(eval echo "${ORB_EVAL_APPLICATION_NAME}")"
ORB_EVAL_DEPLOYMENT_GROUP="$(eval echo "${ORB_EVAL_DEPLOYMENT_GROUP}")"

set +e
aws deploy get-deployment-group \
--application-name "${ORB_EVAL_APPLICATION_NAME}" \
--deployment-group-name "${ORB_EVAL_DEPLOYMENT_GROUP}" \
--profile-name "${ORB_VAL_PROFILE_NAME}" "${ORB_VAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}"

if $? -ne 0; then
  set -e
  echo "No deployment group named ${ORB_EVAL_DEPLOYMENT_GROUP} found. Trying to create a new one"
  aws deploy create-deployment-group \
  --application-name  "${ORB_EVAL_APPLICATION_NAME}" \
  --deployment-group-name "${ORB_EVAL_DEPLOYMENT_GROUP}" \
  --deployment-config-name "${ORB_VAL_DEPLOYMENT_CONFIG}" \
    --service-role-arn "${ORB_VAL_SERVICE_ROLE_ARN}" "${ORB_VAL_ARGUMENTS}"
else
  set -e
  echo "Deployment group named ${ORB_EVAL_DEPLOYMENT_GROUP} already exists. Skipping creation."
fi


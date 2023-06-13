#!/bin/sh
ORB_STR_APPLICATION_NAME="$(circleci env subst "${ORB_STR_APPLICATION_NAME}")"
ORB_STR_DEPLOYMENT_GROUP="$(circleci env subst "${ORB_STR_DEPLOYMENT_GROUP}")"
ORB_STR_REGION="$(circleci env subst "${ORB_STR_REGION}")"
ORB_STR_ARGUMENTS="$(circleci env subst "${ORB_STR_ARGUMENTS}")"
ORB_STR_PROFILE_NAME="$(circleci env subst "${ORB_STR_PROFILE_NAME}")"
ORB_STR_SERVICE_ROLE_ARN="$(circleci env subst "${ORB_STR_SERVICE_ROLE_ARN}")"

set +e
aws deploy get-deployment-group \
--application-name "${ORB_STR_APPLICATION_NAME}" \
--deployment-group-name "${ORB_STR_DEPLOYMENT_GROUP}" \
--region "${ORB_STR_REGION}" \
--profile "${ORB_STR_PROFILE_NAME}" "${ORB_STR_GET_DEPLOYMENT_GROUP_ARGUMENTS}"

if $? -ne 0; then
  set -e
  echo "No deployment group named ${ORB_STR_DEPLOYMENT_GROUP} found. Trying to create a new one"
  aws deploy create-deployment-group \
  --application-name  "${ORB_STR_APPLICATION_NAME}" \
  --deployment-group-name "${ORB_STR_DEPLOYMENT_GROUP}" \
  --deployment-config-name "${ORB_STR_DEPLOYMENT_CONFIG}" \
    --service-role-arn "${ORB_STR_SERVICE_ROLE_ARN}" "${ORB_STR_ARGUMENTS}"
else
  set -e
  echo "Deployment group named ${ORB_STR_DEPLOYMENT_GROUP} already exists. Skipping creation."
fi


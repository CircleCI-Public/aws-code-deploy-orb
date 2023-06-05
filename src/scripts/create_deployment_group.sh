#!/bin/sh
ORB_EVAL_APPLICATION_NAME="$(circleci env subst "${ORB_EVAL_APPLICATION_NAME}")"
ORB_EVAL_DEPLOYMENT_GROUP="$(circleci env subst "${ORB_EVAL_DEPLOYMENT_GROUP}")"
ORB_EVAL_REGION="$(circleci env subst "${ORB_EVAL_REGION}")"
ORB_EVAL_ARGUMENTS="$(circleci env subst "${ORB_EVAL_ARGUMENTS}")"
ORB_EVAL_PROFILE_NAME="$(circleci env subst "${ORB_EVAL_PROFILE_NAME}")"
ORB_EVAL_SERVICE_ROLE_ARN="$(circleci env subst "${ORB_EVAL_SERVICE_ROLE_ARN}")"

set +e
aws deploy get-deployment-group \
--application-name "${ORB_EVAL_APPLICATION_NAME}" \
--deployment-group-name "${ORB_EVAL_DEPLOYMENT_GROUP}" \
--region "${ORB_EVAL_REGION}" \
--profile "${ORB_EVAL_PROFILE_NAME}" "${ORB_EVAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}"

if $? -ne 0; then
  set -e
  echo "No deployment group named ${ORB_EVAL_DEPLOYMENT_GROUP} found. Trying to create a new one"
  aws deploy create-deployment-group \
  --application-name  "${ORB_EVAL_APPLICATION_NAME}" \
  --deployment-group-name "${ORB_EVAL_DEPLOYMENT_GROUP}" \
  --deployment-config-name "${ORB_VAL_DEPLOYMENT_CONFIG}" \
    --service-role-arn "${ORB_EVAL_SERVICE_ROLE_ARN}" "${ORB_EVAL_ARGUMENTS}"
else
  set -e
  echo "Deployment group named ${ORB_EVAL_DEPLOYMENT_GROUP} already exists. Skipping creation."
fi


#!/bin/sh
ORB_EVAL_APPLICATION_NAME="$(eval echo "${ORB_EVAL_APPLICATION_NAME}")"
ORB_EVAL_REGION="$(eval echo "${ORB_EVAL_REGION}")"
ORB_EVAL_PROFILE_NAME="$(eval echo "${ORB_EVAL_PROFILE_NAME}")"
ORB_EVAL_ARGUMENTS="$(eval echo "${ORB_EVAL_ARGUMENTS}")"

set +e
aws deploy get-application \
    --application-name "${ORB_EVAL_APPLICATION_NAME}" --profile "${ORB_EVAL_PROFILE_NAME}" --region "${ORB_EVAL_REGION}" \
    "${ORB_EVAL_ARGUMENTS}" 
if $? -ne 0; then
    set -e
    echo "No application named ${ORB_EVAL_APPLICATION_NAME} found. Trying to create a new one"
else
    set -e
    echo "Application named ${ORB_EVAL_APPLICATION_NAME} already exists. Skipping creation."
fi

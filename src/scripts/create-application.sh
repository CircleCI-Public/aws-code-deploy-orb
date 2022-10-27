#!/bin/sh
ORB_EVAL_APPLICATION_NAME="$(eval echo "${ORB_EVAL_APPLICATION_NAME}")"

set +e
aws deploy get-application --application-name "${ORB_EVAL_APPLICATION_NAME}" --profile "${ORB_VAL_PROFILE_NAME}" "${ORB_VAL_ARGUMENTS}"
if $? -ne 0; then
    set -e
    echo "No application named ${ORB_EVAL_APPLICATION_NAME} found. Trying to create a new one"
else
    set -e
    echo "Application named ${ORB_EVAL_APPLICATION_NAME} already exists. Skipping creation."
fi

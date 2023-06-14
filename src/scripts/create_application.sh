#!/bin/sh
ORB_STR_APPLICATION_NAME="$(circleci env subst "${ORB_STR_APPLICATION_NAME}")"
ORB_STR_REGION="$(circleci env subst "${ORB_STR_REGION}")"
ORB_STR_PROFILE_NAME="$(circleci env subst "${ORB_STR_PROFILE_NAME}")"
ORB_STR_ARGUMENTS="$(circleci env subst "${ORB_STR_ARGUMENTS}")"

set +e
aws deploy get-application \
    --application-name "${ORB_STR_APPLICATION_NAME}" --profile "${ORB_STR_PROFILE_NAME}" --region "${ORB_STR_REGION}" \
    "${ORB_STR_ARGUMENTS}" 
if $? -ne 0; then
    set -e
    echo "No application named ${ORB_STR_APPLICATION_NAME} found. Trying to create a new one"
else
    set -e
    echo "Application named ${ORB_STR_APPLICATION_NAME} already exists. Skipping creation."
fi

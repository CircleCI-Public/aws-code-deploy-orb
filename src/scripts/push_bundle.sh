#!/bin/sh
ORB_STR_APPLICATION_NAME="$(circleci env subst "${ORB_STR_APPLICATION_NAME}")"
ORB_STR_BUNDLE_BUCKET="$(circleci env subst "${ORB_STR_BUNDLE_BUCKET}")"
ORB_STR_BUNDLE_KEY="$(circleci env subst "${ORB_STR_BUNDLE_KEY}")"
ORB_STR_REGION="$(circleci env subst "${ORB_STR_REGION}")"
ORB_STR_ARGUMENTS="$(circleci env subst "${ORB_STR_ARGUMENTS}")"
ORB_STR_PROFILE_NAME="$(circleci env subst "${ORB_STR_PROFILE_NAME}")"
ORB_EVAL_BUNDLE_SOURCE="$(eval echo "${ORB_EVAL_BUNDLE_SOURCE}")"

if [ -n "${ORB_STR_ARGUMENTS}" ]; then 
    set -- "$@" "${ORB_STR_ARGUMENTS}"
fi 

aws deploy push \
    --application-name "${ORB_STR_APPLICATION_NAME}" \
    --source "${ORB_EVAL_BUNDLE_SOURCE}" \
    --profile "${ORB_STR_PROFILE_NAME}" \
    --region "${ORB_STR_REGION}" \
    --s3-location s3://"${ORB_STR_BUNDLE_BUCKET}/${ORB_STR_BUNDLE_KEY}.${ORB_VAL_BUNDLE_TYPE}" "$@"

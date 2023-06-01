#!/bin/sh
ORB_EVAL_APPLICATION_NAME="$(circleci env subst "${ORB_EVAL_APPLICATION_NAME}")"
ORB_EVAL_DEPLOYMENT_GROUP="$(circleci env subst "${ORB_EVAL_DEPLOYMENT_GROUP}")"
ORB_EVAL_BUNDLE_BUCKET="$(circleci env subst "${ORB_EVAL_BUNDLE_BUCKET}")"
ORB_EVAL_BUNDLE_KEY="$(circleci env subst "${ORB_EVAL_BUNDLE_KEY}")"
ORB_EVAL_REGION="$(circleci env subst "${ORB_EVAL_REGION}")"
ORB_EVAL_GET_DEPLOYMENT_GROUP_ARGUMENTS="$(circleci env subst "${ORB_EVAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}")"
ORB_EVAL_BUNDLE_TYPE="$(circleci env subst "${ORB_EVAL_BUNDLE_TYPE}")"
ORB_EVAL_DEPLOY_BUNDLE_ARGUMENTS="$(circleci env subst "${ORB_EVAL_DEPLOY_BUNDLE_ARGUMENTS}")"

if [ -n "${ORB_EVAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}" ]; then 
  set -- "$@" "${ORB_EVAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}"
fi

if [ -n "${ORB_EVAL_DEPLOY_BUNDLE_ARGUMENTS}" ]; then
  set -- "$@" "${ORB_EVAL_DEPLOY_BUNDLE_ARGUMENTS}"
fi 

ID=$(aws deploy create-deployment \
    --application-name "${ORB_EVAL_APPLICATION_NAME}" \
    --deployment-group-name "${ORB_EVAL_DEPLOYMENT_GROUP}" \
    --deployment-config-name "${ORB_VAL_DEPLOYMENT_CONFIG}" \
    --region "${ORB_EVAL_REGION}" \
    --s3-location bucket="${ORB_EVAL_BUNDLE_BUCKET}",bundleType="${ORB_EVAL_BUNDLE_TYPE}",key="${ORB_EVAL_BUNDLE_KEY}"."${ORB_EVAL_BUNDLE_TYPE}" \
    --profile "${ORB_EVAL_PROFILE_NAME}" \
    --output text \
    --query '[deploymentId]' "${ORB_EVAL_DEPLOY_BUNDLE_ARGUMENTS}")
STATUS=$(aws deploy get-deployment \
    --deployment-id "$ID" \
    --output text \
    --profile "${ORB_EVAL_PROFILE_NAME}" \
    --region "${ORB_EVAL_REGION}" \
    --query '[deploymentInfo.status]' \
    "${ORB_EVAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}")
while [ "$STATUS" = "Created" ] || [ "$STATUS" = "InProgress" ] || [ "$STATUS" = "Pending" ] || [ "$STATUS" = "Queued" ] || [ "$STATUS" = "Ready" ]; do
  echo "Status: $STATUS..."
  STATUS=$(aws deploy get-deployment \
            --deployment-id "$ID" \
            --profile "${ORB_EVAL_PROFILE_NAME}" \
            --region "${ORB_EVAL_REGION}" \
            --output text \
            --query '[deploymentInfo.status]'"${ORB_EVAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}")
  sleep 5
done
if [ "$STATUS" = "Succeeded" ]; then
  EXITCODE=0
  echo "Deployment finished."
else
  EXITCODE=1
  echo "Deployment failed!"
fi
aws deploy get-deployment --deployment-id "$ID" \
"${ORB_EVAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}" \
--profile "${ORB_EVAL_PROFILE_NAME}" \
--region "${ORB_EVAL_REGION}" \
--profile "${ORB_EVAL_PROFILE_NAME}"
exit $EXITCODE

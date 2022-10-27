#!/bin/sh
ORB_EVAL_APPLICATION_NAME="$(eval echo "${ORB_EVAL_APPLICATION_NAME}")"
ORB_EVAL_DEPLOYMENT_GROUP="$(eval echo "${ORB_EVAL_DEPLOYMENT_GROUP}")"
ORB_EVAL_BUNDLE_BUCKET="$(eval echo "${ORB_EVAL_BUNDLE_BUCKET}")"
ORB_EVAL_BUNDLE_KEY="$(eval echo "${ORB_EVAL_BUNDLE_KEY}")"

if [ -n "${ORB_VAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}" ]; then 
  set -- "$@" "${ORB_VAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}"
fi

if [ -n "${ORB_VAL_DEPLOY_BUNDLE_ARGUMENTS}" ]; then
  set -- "$@" "${ORB_VAL_DEPLOY_BUNDLE_ARGUMENTS}"
fi 

ID=$(aws deploy create-deployment \
    --application-name "${ORB_EVAL_APPLICATION_NAME}" \
    --deployment-group-name "${ORB_EVAL_DEPLOYMENT_GROUP}" \
    --deployment-config-name "${ORB_VAL_DEPLOYMENT_CONFIG}" \
    --s3-location bucket="${ORB_EVAL_BUNDLE_BUCKET}",bundleType="${ORB_VAL_BUNDLE_TYPE}",key="${ORB_EVAL_BUNDLE_KEY}"."${ORB_VAL_BUNDLE_TYPE}" \
    --profile "${ORB_VAL_PROFILE_NAME}" \
    --output text \
    --query '[deploymentId]' "${ORB_VAL_DEPLOY_BUNDLE_ARGUMENTS}")
STATUS=$(aws deploy get-deployment \
    --deployment-id "$ID" \
    --output text \
    --profile "${ORB_VAL_PROFILE_NAME}" \
    --query '[deploymentInfo.status]' "${ORB_VAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}")
while [ "$STATUS" = "Created" ] || [ "$STATUS" = "InProgress" ] || [ "$STATUS" = "Pending" ] || [ "$STATUS" = "Queued" ] || [ "$STATUS" = "Ready" ]; do
  echo "Status: $STATUS..."
  STATUS=$(aws deploy get-deployment \
            --deployment-id "$ID" \
            --profile "${ORB_VAL_PROFILE_NAME}" \
            --output text \
            --query '[deploymentInfo.status]'"${ORB_VAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}")
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
"${ORB_VAL_GET_DEPLOYMENT_GROUP_ARGUMENTS}" \
--profile "${ORB_VAL_PROFILE_NAME}"
exit $EXITCODE

#!/bin/bash

function notify_to_slack () {
  # format message as a code block ```${msg}```
  SLACK_MESSAGE="\`\`\`$1\`\`\`"
  SLACK_URL=https://hooks.slack.com/services/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

  case "$2" in
    INFO)
      SLACK_ICON=':slack:'
      ;;
    WARNING)
      SLACK_ICON=':warning:'
      ;;
    *)
      SLACK_ICON=':slack:'
      ;;
  esac

  curl -X POST --data "payload={\"text\": \"${SLACK_ICON} ${SLACK_MESSAGE}\"}" ${SLACK_URL}
}

# url from api
url_staging=https://staging-gateway.donexpress.com
url_prod=https://gateway.donexpress.com
url_dev=https://dc0-gateway.donexpress.com

# declare array variable
declare -a ms=("" "/accounts" "/catalog" "/payments" "/logistics" "/forex" "/wallet" "/notifications" "/customer_service" "/files" "/os" "/redirect" "/atm")

# if compared to know what state it has
for i in "${ms[@]}"
do
  fullpathprod=${url_prod}${i}/api/v1
  fullpathstaging=${url_staging}${i}/api/v1
  fullpathdev=${url_dev}${i}/api/v1
  msname=${i}

  status_code_prod=$(curl --head --write-out %{http_code} --silent --output /dev/null ${fullpathprod})
  status_code_staging=$(curl --head --write-out %{http_code} --silent --output /dev/null ${fullpathstaging})
  status_code_dev=$(curl --head --write-out %{http_code} --silent --output /dev/null ${fullpathdev})
  
  echo "${fullpathprod} returned with $status_code_prod"
  echo "${fullpathstaging} returned with $status_code_staging"
  echo "${fullpathdev} returned with $status_code_dev"
  
  if [ $status_code_prod -eq 200 ]
    then
      echo "Everything is fine in the production environments..."
  else
    echo "Will notify through slack..."
    notify_to_slack "${msname} is failing. Please, check the API ${fullpathprod}" "WARNING"
  fi
  if [ $status_code_staging -eq 200 ]
    then
      echo "Everything is fine in the staging environments..."
  else
    echo "Will notify through slack..."
    notify_to_slack "${msname} is failing. Please, check the API ${fullpathstaging}" "WARNING"
  fi
  if [ $status_code_dev -eq 200 ]
    then
      echo "Everything is fine in the development environments..."
  else
    echo "Will notify through slack..."
    notify_to_slack "${msname} is failing. Please, check the API ${fullpathdev}" "WARNING"
  fi
done

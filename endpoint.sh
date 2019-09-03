#!/bin/bash
# var
#SLACK_NOTIFICATIONS_URL=https://hooks.slack.com/services/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

#function send notification slack

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
url=https://staging-gateway.donexpress.com

# declare array variable
declare -a ms=("" "/accounts" "/catalog" "/payments" "/logistics" "/wallet" "/social" "/notifications" "/customer_service" "/files" "/os")

# if compared to know what state it has
for i in "${ms[@]}"
do
  fullpath=${url}${i}/api/v1
  echo "========="
  echo "Calling ${fullpath}"
  status_code=$(curl --write-out %{http_code} --silent --output /dev/null ${fullpath})
  echo "${fullpath} returned with $status_code"
  if [ $status_code -eq 200 ]
    then
      echo "OK"
  else
    echo "Will notify through slack..."
    notify_to_slack "Please, check the API: ${fullpath}" "WARNING"
  fi
  echo "========="
done

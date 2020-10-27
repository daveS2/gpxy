#!/bin/bash
PROJECT="$1"
shift
gcloud compute start-iap-tunnel bastion 8118 --local-host-port=localhost:8118 --project "$PROJECT" --zone europe-west2-a  >/dev/null 2>&1 & pid_iap=$!
while ! nc -z localhost 8118; do
  sleep 0.1
done
HTTPS_PROXY=localhost:8118 $@
kill $pid_iap

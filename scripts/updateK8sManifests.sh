#!/bin/bash
set -x

# Remove old repo if it exists
rm -rf /tmp/temp_repo

REPO_URL="https://5CHanQNEOkpNEIjEMxGVY2SQPKJPmSpvN3xz0xTCGubrRATYDck8JQQJ99BGACAAAAAAAAAAAAASAZDO3uJG@dev.azure.com/harshsingh94636/voting-app/_git/voting-app"

git clone "$REPO_URL" /tmp/temp_repo
cd /tmp/temp_repo

# Show input arguments
echo "✅ Arg 1 (resource name): $1"
echo "✅ Arg 2 (image repo): $2"
echo "✅ Arg 3 (tag): $3"

# Check file exists
ls -l k8s-specifications/$1-deployment.yaml

# Replace image line
sed -i "s|image: .*|image: ayushazurecicd.azurecr.io/$2:$3|" k8s-specifications/$1-deployment.yaml

# Confirm change
grep "image:" k8s-specifications/$1-deployment.yaml

git add .
git commit -m "Update Kubernetes manifest"
git push

# Clean up
rm -rf /tmp/temp_repo

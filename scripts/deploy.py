#!/usr/bin/env python3

import subprocess
import sys
import yaml


if len(sys.argv) < 3:
    print("Usage: scripts/deploy.py [namespace] [deployment_name]")
    sys.exit(1)

namespace = sys.argv[1]
deployment_name = sys.argv[2]

deployment_version = ""

# Get the version of the deployed application
try:
    deployment_version = subprocess.check_output(
        f'kubectl get deployment {deployment_name} -o=jsonpath="{{.metadata.labels.app\.kubernetes\.io\/version}}"',
        shell=True, text=True).strip()
    print(f'Deployment version: {deployment_version}')
except subprocess.CalledProcessError as e:
    subprocess.run(['helm', 'install', 'web-server', 'chart/'])
    sys.exit(0)


# Read the Chart.yaml file
with open('chart/Chart.yaml', 'r') as f:
    chart_data = yaml.safe_load(f)

# Get the chart version
chart_version = chart_data.get('appVersion', '')
print(f'Chart version: {chart_version}')

# Check if the version matches the one in the Helm chart
if deployment_version == chart_version:
    print('The deployment is already running the latest version.')
else:
    print(f'Deploying web-server version: {chart_version}')
    # Run the Helm upgrade command to deploy the new version
    subprocess.run(['helm', 'upgrade', deployment_name, './chart', '--namespace', namespace, '--atomic', '--install'])

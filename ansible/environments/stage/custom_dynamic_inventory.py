#!/usr/bin/env python

import json
import commands

#with best practices :)
hardcoded_file_struct = '{"app":{"children":["appserver"]}, "db":{"children":["dbserver"]}, "appserver":{ "hosts":["127.0.0.1"], "vars":{"db_host": "127.0.0.2"}}, "dbserver":{"hosts":["127.0.0.3"]}}'

cmd = 'gcloud compute instances list --format="json(name,EXTERNAL_IP,INTERNAL_IP)"'
gcloud_json_raw_output = commands.getstatusoutput(cmd)[1]
gcloud_json_output = json.loads(gcloud_json_raw_output)

#get external ip appserver
app_external_ip = gcloud_json_output[0]['networkInterfaces'][0]['accessConfigs'][0]['natIP']
#get external ip dbserver
db_external_ip = gcloud_json_output[1]['networkInterfaces'][0]['accessConfigs'][0]['natIP']
#get internal ip dbserver
db_internal_ip = gcloud_json_output[1]['networkInterfaces'][0]['networkIP']

##creation dynamic json
data = json.loads(hardcoded_file_struct)
#set parsed variables
data['appserver']['hosts'][0] = app_external_ip
data['dbserver']['hosts'][0] = db_external_ip
data['appserver']['vars']['db_host'] = db_internal_ip

print json.dumps(data)

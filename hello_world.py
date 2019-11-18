import boto3
from flask import Flask
app = Flask(__name__)

ddb_client = boto3.client('dynamodb')

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/events/')
def get_all_events():
    response = ddb_client.scan(TableName='events')
    events = response['Items']
    for event in events:
        print("events")
        for k, v in event.items():
            event[k] = event[k]['S']
    return {"events": events}



# Google Cloud functions
Deploy:
```
gcloud functions deploy hello_get --runtime python37 --trigger-http
```

Call:
```
curl "https://REGION-PROJECT_ID.cloudfunctions.net/hello_get" 
```

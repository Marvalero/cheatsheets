# Gcloud

## Configuration

```bash
# Configure
gclound init

# With a service account
gcloud auth activate-service-account SERVICE_ACCOUNT_EMAIL --key-file /path/to/file
```

## VM

```bash
# List Vms
gcloud compute instances list
# List Disk
gcloud compute disks list
```

## IAM

```bash
# Add role roles/container.admin to a service account
gcloud projects add-iam-policy-binding PROJECT_NAME --member serviceAccount:SERVICE_ACCOUNT_EMAIL --role roles/container.admin

# Set GOOGLE_APPLICATION_CREDENTIALS
gcloud auth application-default login
```

## Kubernetes engine

```
# List clusters
gcloud container clusters list

# Autoscale nodes
gcloud beta container clusters update <cluster-name> --enable-autoscaling --min-nodes=3 --max-nodes=7 --zone=<cluster-zone> --node-pool=default-pool

# Disable Autoscale nodes
gcloud beta container clusters update <cluster-name> --enable-autoscaling --min-nodes=3 --max-nodes=7 --zone=<cluster-zone> --node-pool=default-pool

# Add additional zone
gcloud beta container clusters update <cluster-name> --additional-zones=europe-west1-c

# Add node-pool
gcloud beta container node-pools create high-spec --machine-type=n1-highcpu-2 --preemptible --num-nodes=1

# Resize nodes on a zone
gcloud container clusters resize <cluster-name> --size=2

# Delete nodepool
gcloud beta container node-pools delete high-spec
```

## KMS
Encrypted credentials are stored in a bucket. To encrypt and decrypt this credentials we need a CryptoKey and a KeyRing in our Google Cloud KMS.

**Credentials IAM**

In KMS, there are two major permissions to focus on:
* manage KMS resources (`cloudkms.admin`).
* use keys to encrypt and decrypt data (`cloudkms.cryptoKeyEncrypterDecrypter`).

We expect every team lead to have this credentials. To guarantee you can use:

```
# Manage a key
gcloud kms keyrings add-iam-policy-binding $KEYRING_NAME \
    --location global \
    --member user:$USER_EMAIL \
    --role roles/cloudkms.admin

# Encrypt/Decrypt with a key
gcloud kms keyrings add-iam-policy-binding $KEYRING_NAME \
    --location global \
    --member user:$USER_EMAIL \
    --role roles/cloudkms.cryptoKeyEncrypterDecrypter
```

**Viewing Cloud Storage audit logs**

To view the activity for any resource in KMS, return to the Encryption keys page (IAM & admin > Encryption keys), check the box next to your key ring, then click on the Activity tab in the right menu. This will take you to the Cloud Activity UI, where you should see the creation and all modifications made to the KeyRing.

BUCKET_NAME=devops-credentials
KEYRING_NAME=devops
CRYPTOKEY_NAME=credentials
PROJECT_ID=devops

encrypt_file() {
  FILE_NAME=$1
  PLAINTEXT=$(cat $FILE_NAME | base64)

  curl -v "https://cloudkms.googleapis.com/v1/projects/$PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:encrypt" \
    -d "{\"plaintext\":\"$PLAINTEXT\"}" \
    -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
    -H "Content-Type: application/json" | jq .ciphertext -r > $FILE_NAME.encrypted
}

decrypt_file() {
  FILE_NAME=$1

  curl -v "https://cloudkms.googleapis.com/v1/projects/$PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:decrypt" \
    -d "{\"ciphertext\":\"$(cat $FILE_NAME)\"}" \
    -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
    -H "Content-Type:application/json" \
  | jq .plaintext -r | base64 --decode
}

upload_credentials() {
  FILE_NAME=$1

  gsutil cp $FILE_NAME.encrypted gs://${BUCKET_NAME}
}

# example to encrypt:
# encrypt_file importantkey
# upload_credentials importantkey

# example to decrypt:
# decrypt_file importantkey.encrypted

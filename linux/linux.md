# Linux

## security
###  gpg
```bash
# Decrypt
INPUT=${2}
OUTPUT=$(echo "${INPUT}" | sed 's/.gpg$//g')
gpg --decrypt ${INPUT} > ${OUTPUT}

# Encrypt
PUBLIC_KEY_DIRECTORY="./public_keys"
function import_recipients {
    RECIPIENT_LIST=""
    PUBLIC_KEY_DIR_FILES="$(ls -1 ${PUBLIC_KEY_DIRECTORY})"
    for PUBLIC_KEY in ${PUBLIC_KEY_DIR_FILES}; do
      gpg --import ${PUBLIC_KEY_DIRECTORY}/${PUBLIC_KEY}
      RECIPIENT_LIST="${RECIPIENT_LIST} --recipient ${PUBLIC_KEY}"
    done
}
INPUT=${2}
OUTPUT=$(echo "${INPUT}.gpg")
gpg --always-trust --output ${OUTPUT} ${RECIPIENT_LIST} --encrypt ${INPUT}
```

## Networking
```bash
# Reload routing table
sudo ifconfig en0 down && sudo route flush && sudo ifconfig en0 up

# See postgres connections
sudo netstat -tupn | grep postgres | awk 'sub(/:[0-9]+/,"",$5){ print $5 }' | sort | uniq -c
```


## Memory

```bash
# disk usage
sudo du -h --max-depth=1 /
```

## Packages

```bash
# Upgrade kernel distro (you need to restart the server after this)
apt-get dist-upgrade

# Remove a package
apt-get remove PACKAGE
```

# SOPS configuration

## User

```
# Generate user key and store it in safe place.
age-keygen

# Add public key
vim .sops.yaml

# Add private key to sops keys
echo "<PRIVATEKEY>" >> ~/.config/sops/age/keys.txt

# Update secrets
sops updatekeys -y secrets.yaml
```

## Age keys creation

**Note:** The SSH key are generated during first [ NixOS installation ](./installation.md)

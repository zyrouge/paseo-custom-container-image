# paseo-custom-container-image

Container image for Paseo with OpenCode.

```bash
podman pull ghcr.io/zyrouge/paseo-custom:latest

podman run --rm \
    -p 8080:6767 \
    -e PASEO_PASSWORD=change-me \
    -v "$PWD/paseo-home:/home/paseo" \
    -v "$PWD:/workspace" \
    ghcr.io/zyrouge/paseo-custom:latest
```

# License

[Unlicense](./LICENSE)

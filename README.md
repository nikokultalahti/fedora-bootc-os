# fedora-bootc-os &nbsp; [![bluebuild build badge](https://github.com/nikokultalahti/fedora-bootc-os/actions/workflows/build.yml/badge.svg)](https://github.com/nikokultalahti/fedora-bootc-os/actions/workflows/build.yml)

Personal OS image built with [BlueBuild](https://blue-build.org/) on top of Fedora Silverblue 44.

- GNOME as shipped by Silverblue, minus the apps that come from Flathub instead (installed on first boot through Bazaar's Flathub remote)
- Firefox as RPM, RPM Fusion codecs and AMD VA-API hardware video decoding
- Podman, Homebrew (auto-updating) and `chezmoi`
- Automatic staged updates: a daily `bootc upgrade` that applies on the next reboot

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/nikokultalahti/fedora-bootc-os:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/nikokultalahti/fedora-bootc-os:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

You can generate an offline installer ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top), for example:

```bash
sudo bluebuild generate-iso --iso-name fedora-bootc-os.iso image ghcr.io/nikokultalahti/fedora-bootc-os:latest
```

 These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/nikokultalahti/fedora-bootc-os
```

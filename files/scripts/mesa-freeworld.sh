#!/usr/bin/env bash

# Install RPM Fusion's mesa-va-drivers-freeworld (H.264/HEVC VA-API on AMD)
# only when its version matches the Mesa already in the image. RPM Fusion can
# be ahead of or behind Fedora's stable Mesa for a few days after a release,
# and an unpinned install makes dnf downgrade Mesa to match the older build.
# If there is no matching build, warn and continue; a later daily build picks
# it up. Check with `vainfo` after updates.
set -oue pipefail

mesa_version="$(rpm -q --qf '%{VERSION}' mesa-filesystem)"

if dnf5 install -y "mesa-va-drivers-freeworld-${mesa_version}"; then
  echo "Installed mesa-va-drivers-freeworld ${mesa_version}"
else
  echo "WARNING: no mesa-va-drivers-freeworld ${mesa_version} yet, skipping."
  echo "         VA-API hardware decoding will be missing until a later build."
fi

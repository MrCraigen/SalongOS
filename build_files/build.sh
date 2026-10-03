#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux
dnf5 install -y plasma-bigscreen
dnf5 install -y plasma-bigscreen-wayland

# SalongOS tweaks
# The "Steam" icon in Bigscreen switches to Steam Gaming Mode
sed -i 's|^Exec=/usr/bin/bazzite-steam %U$|Exec=steamosctl switch-to-game-mode|' /usr/share/applications/steam.desktop
# Remove the OpenGamepadUI launcher (Bigscreen ignores NoDisplay/Hidden)
rm -f /usr/share/applications/opengamepadui.desktop

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

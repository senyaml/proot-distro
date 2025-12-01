# This is a default distribution plug-in.
# Do not modify this file as your changes will be overwritten on next update.
# If you want customize installation, please make a copy.
DISTRO_NAME="Ubuntu (25.10)"
DISTRO_COMMENT="Regular release (questing)."

TARBALL_URL['aarch64']="https://github.com/termux/proot-distro/releases/download/v4.11.0/ubuntu-noble-aarch64-pd-v4.11.0.tar.xz"
TARBALL_URL['arm']="https://github.com/termux/proot-distro/releases/download/v4.11.0/ubuntu-noble-aarch64-pd-v4.11.0.tar.xz"
TARBALL_URL['x86_64']="https://github.com/termux/proot-distro/releases/download/v4.11.0/ubuntu-noble-aarch64-pd-v4.11.0.tar.xz"

distro_setup() {
	# Configure en_US.UTF-8 locale.
	sed -i -E 's/#[[:space:]]?(en_US.UTF-8[[:space:]]+UTF-8)/\1/g' ./etc/locale.gen
	run_proot_cmd DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

	# Configure Mozilla PPA.
	echo "Configuring PPA repository for Firefox and Thunderbird..."
	run_proot_cmd add-apt-repository --yes --no-update ppa:mozillateam/ppa || true
	cat <<- CONFIG_EOF > ./etc/apt/preferences.d/pin-mozilla-ppa
	Package: *
	Pin: release o=LP-PPA-mozillateam
	Pin-Priority: 9999
	CONFIG_EOF
}

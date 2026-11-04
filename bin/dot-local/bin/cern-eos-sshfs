#!/usr/bin/env bash
#
# Mount CERN EOS via sshfs and symlink specific subdirectories into $HOME.
# Works on Linux and macOS.
#
set -euo pipefail

REMOTE_USER="hepommer"
REMOTE_PATH="/eos"
REMOTE="${REMOTE_USER}@lxplus.cern.ch:${REMOTE_PATH}"
MOUNTPOINT="$HOME/mnt/eos"

# --- Subdirectories to symlink into $HOME -----------------------------
# Add more pairs as needed. Index i of SUBDIRS maps to index i of LINKNAMES.
SUBDIRS=(
	"home-h/$REMOTE_USER"
	# "project/xyz"
)
LINKNAMES=(
	"$HOME/eos-home"
	# "$HOME/eos-xyz"
)
# ------------------------------------------------------------------------

mkdir -p "$MOUNTPOINT"

# Base options common to both platforms.
OPTS=(-o reconnect -o auto_cache)

case "$(uname -s)" in
	Darwin)
		# macFUSE-specific options.
		OPTS+=(
			-o volname=EOS
			-o defer_permissions
			-o negative_vncache
			-o noappledouble
			-o noapplexattr
		)
		;;
	Linux)
		# allow_other lets users other than the one who ran sshfs access the
		# mount. Requires 'user_allow_other' uncommented in /etc/fuse.conf.
		# OPTS+=(-o allow_other)
		;;
	*)
		echo "Unrecognized OS: $(uname -s). Proceeding with base options only." >&2
		;;
esac

# Skip if already mounted.
if mount | grep -q "on $MOUNTPOINT "; then
	echo "Already mounted at $MOUNTPOINT"
else
	echo "Mounting $REMOTE at $MOUNTPOINT ..."
	sshfs "$REMOTE" "$MOUNTPOINT" "${OPTS[@]}"
fi

# Create/update symlinks for the requested subdirectories.
for i in "${!SUBDIRS[@]}"; do
	target="$MOUNTPOINT/${SUBDIRS[$i]}"
	linkname="${LINKNAMES[$i]}"
	ln -sfn "$target" "$linkname"
	echo "Linked $linkname -> $target"
done

echo "Done."

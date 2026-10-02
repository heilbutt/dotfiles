#!/usr/bin/env bash
# Sign a PDF using the pyhanko tool: `sign-pdf input.pdf output.pdf``
# Requires pyhanko to be in the PATH. For example, install with
# `uv tool install pyhanko-cli` to `~/.local/bin`
#
set -euo pipefail

[[ $# -eq 2 ]] || { echo "Usage: ${0##*/} input.pdf output.pdf" >&2; exit 1; }
in="$1"
out="$2"
cert="$HOME/cern-user-certificate.p12"

[[ ! -e "$out" ]] || { echo "Output exists: $out" >&2; exit 1; }
pyhanko sign addsig --field Sig1 --use-pades pkcs12 "$in" "$out" "$cert"
pyhanko sign validate --pretty-print "$out"

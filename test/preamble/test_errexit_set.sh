set -o errexit

source "$PREAMBLE"

if [[ ! -o errexit ]]; then
    echo "errexit was unset!" >&2
    exit 1
fi
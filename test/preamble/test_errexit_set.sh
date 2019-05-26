set -o errexit

source "$PREAMBLE"

if [[ ! -o errexit ]]; then
    echo "errexit was unset!"
    exit 1
fi

echo passed
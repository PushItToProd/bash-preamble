set -euo pipefail

source "$PREAMBLE"

for flag in errexit nounset pipefail; do
    if [[ ! -o $flag ]]; then
        echo "$flag was unset!" >&2
        exit 1
    fi
done
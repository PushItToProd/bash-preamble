# Simple wrapper for invoking preamble commands in isolation from bats tests.
set -euo pipefail
source "$PREAMBLE"

"$@"
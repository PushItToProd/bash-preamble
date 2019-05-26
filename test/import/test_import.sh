set -euo pipefail
source "$PREAMBLE"

MODULE_PATH="$(dirname "$0")/module_path"

importmod foo

foo::bar
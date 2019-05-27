set -euo pipefail
source "$PREAMBLE"

export MODULEPATH="$(dirname "$0")/module_path"

importmod foo

foo::bar
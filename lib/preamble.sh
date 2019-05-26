# Set the given flags
_preamble_set_flags() {
  declare -ag _PREAMBLE_SET_FLAGS=()
  for flag in "$@"; do
    if [[ ! -o "$flag" ]]; then
      _PREAMBLE_SET_FLAGS+=("$flag")
      set -o "$flag"
    fi
  done
}

_preamble_revert_flags() {
  for flag in "${_PREAMBLE_SET_FLAGS[@]}"; do
    set +o "$flag"
  done
  unset -v _PREAMBLE_SET_FLAGS
  unset -f _preamble_set_flags
  unset -f _preamble_revert_flags
}

_preamble_set_flags errexit nounset pipefail

source "$(dirname "${BASH_SOURCE[0]}")/executables.sh"

_preamble_revert_flags
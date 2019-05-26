declare -a _PREAMBLE_SET_FLAGS=()

set_flags() {
    for flag in "$@"; do
        if [[ ! -o "$flag" ]]; then
            _PREAMBLE_SET_FLAGS+=("$flag")
            set -o "$flag"
        fi
    done
}

revert_flags() {
    for flag in "${_PREAMBLE_SET_FLAGS[@]}"; do
        set +o "$flag"
    done
    unset _PREAMBLE_SET_FLAGS
}

set_flags errexit nounset pipefail

source "$( dirname "${BASH_SOURCE[0]}")/executables.sh"

revert_flags
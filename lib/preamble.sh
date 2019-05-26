set_flag() {
    local -r flag="$1"
    declare -g "_preamble_${flag}"=""
    local -n flagset="_preamble_${flag}"

    [[ -o "$flag" ]] && flagset=1 || set -o "$flag"
}

revert_flag() {
    local -r flag="$1"
    unset -v "_preamble_${flag}"
    set +o "$flag"
}

set_flag errexit
set_flag nounset
set_flag pipefail

source "$( dirname "${BASH_SOURCE[0]}")/executables.sh"

revert_flag errexit
revert_flag nounset
revert_flag pipefail
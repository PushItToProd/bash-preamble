source "$PREAMBLE"

set -e
if declare -p _PREAMBLE_SET_FLAGS 2>/dev/null; then
    echo "_PREAMBLE_SET_FLAGS not unset"
    exit 1
fi

if declare -f _preamble_set_flags 2>/dev/null; then
    echo "_preamble_set_flags not unset"
    exit 1
fi

if declare -f _preamble_revert_flags 2>/dev/null; then
    echo "_preamble_revert_flags not unset"
    exit 1
fi

echo $0 passed
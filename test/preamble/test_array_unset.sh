source "$PREAMBLE"

set -e

preamble_funcs=(
    _preamble_set_flags
    _preamble_revert_flags
    _preamble_setup
    _preamble_teardown
)

if declare -p _PREAMBLE_SET_FLAGS 2>/dev/null; then
    echo "_PREAMBLE_SET_FLAGS not unset"
    exit 1
fi

for func in "${preamble_funcs[@]}"; do
    if declare -f "$func" >/dev/null 2>&1; then
        echo "$func not unset"
        exit 1
    fi
done

echo $0 passed
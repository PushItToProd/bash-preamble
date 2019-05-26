source "$PREAMBLE"

if declare -p _PREAMBLE_SET_FLAGS; then
    echo "_PREAMBLE_SET_FLAGS not unset"
    exit 1
fi
source "$PREAMBLE"

fail=false
for flag in errexit nounset pipefail; do
    if [[ -o $flag ]]; then
        echo "$flag was set!"
        fail=true
    fi
done
$fail && exit 1

echo $0 passed
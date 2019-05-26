export PREAMBLE="lib/preamble.sh"

# via https://stackoverflow.com/a/20460402
inString() {
  [ -z "${2##*$1*}" ]
}
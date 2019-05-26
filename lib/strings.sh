string::split() {
  local -r sep="$1"
  local -r string="$2"
  local -r arrayname="$3"

  IFS="$sep" read -ra "$arrayname" <<<"$string"
}

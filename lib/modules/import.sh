_preamble_resolve_module_path() {
  local -r path="$1"
  local -r actual_path="${path/.//}.mod.bash"
  printf "%s" "$actual_path"
}

importmod() {
  local -r mod="$1"
  local -r module_path="$(_preamble_resolve_module_path "$mod")"
  if [[ ! -e "$module_path" ]]; then
    echo "${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: module '$mod' not found"
    return 1
  fi
}
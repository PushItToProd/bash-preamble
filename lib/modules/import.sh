_preamble_resolve_module_path() {
  local -r script_dir="$1"
  local -r module_path="$2"
  local -r actual_path="$script_dir/${module_path/.//}.mod.bash"
  printf "%s" "$actual_path"
}

importmod() {
  local -r mod="$1"
  local -r script_path="${BASH_SOURCE[1]}"
  local -r script_dir="$(dirname "$script_path")"
  local -r module_path="$(_preamble_resolve_module_path "$script_dir" "$mod")"
  if [[ ! -e "$module_path" ]]; then
    echo "$script_path: line ${BASH_LINENO[0]}: module '$mod' not found (searched $module_path)"
    return 1
  fi
  source "$module_path"
}
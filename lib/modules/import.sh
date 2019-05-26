# TODO: _IMPORT__SOURCE_FILE and _DIR should be set by prelude.sh
declare _IMPORT__SOURCE_FILE
declare _IMPORT__SOURCE_DIR
declare _IMPORT__LINE_NUMBER

# Generate a module path.
_import::construct_path() {
  local -r script_dir="$1"
  local -r module_path="$2"
  local -r actual_path="$script_dir/${module_path/.//}.mod.bash"
  printf "%s" "$actual_path"
}

_import::search_module_path() {
  local -r source_file="$1"
  local -r source_path="$(dirname "$source_file")"
  local -r source_line="$2"
  local -r module_path="$2"
  local path_to_module
  local -a module_path_entries=("$source_path")

  if declare -p MODULE_PATH >/dev/null 2>&1; then
    string::split ':' "$MODULE_PATH" module_path_entries
  fi

  for script_dir in "${module_path_entries[@]}"; do
    path_to_module="$(_import::construct_path "$script_dir" "$module_path")"
    if [[ -e "$path_to_module" ]]; then
      source "$path_to_module"
    fi
  done

  echo "$source_file: line $source_line: module '$mod' not found (searched $module_path)"
}

importmod() {
  local -r mod="$1"
  _IMPORT__SOURCE_FILE="${BASH_SOURCE[1]}"
  _IMPORT__SOURCE_DIR="$(dirname "$_IMPORT__SOURCE_FILE")"
  _IMPORT__LINE_NUMBER="${BASH_LINENO[0]}"
  local -r module_path="$(_import::construct_path "$_IMPORT__SOURCE_DIR" "$mod")"

  if [[ ! -e "$module_path" ]]; then
    echo "$_IMPORT__SOURCE_FILE: line $_IMPORT__LINE_NUMBER: module '$mod' not found (searched $module_path)"
    return 1
  fi
  source "$module_path"
}
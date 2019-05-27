# TODO: _IMPORT__SOURCE_FILE and _DIR should be set by prelude.sh
declare _IMPORT__SOURCE_FILE
declare _IMPORT__SOURCE_DIR
declare _IMPORT__LINE_NUMBER

# Resolve a relative module path.
_import::resolve_module_path() {
  local -r module_path="$1"
  printf '%s' "${module_path//.//}.mod.bash"
}

# TODO: reimplement search_module_path

importmod() {
  local -r mod="$1"
  _IMPORT__SOURCE_FILE="${BASH_SOURCE[1]}"
  _IMPORT__SOURCE_DIR="$(realpath $(dirname "$_IMPORT__SOURCE_FILE"))"
  _IMPORT__LINE_NUMBER="${BASH_LINENO[0]}"
  local -r resolved_module_path="$(_import::resolve_module_path "$mod")"
  local -r module_path="$_IMPORT__SOURCE_DIR/$resolved_module_path"

  if [[ ! -e "$module_path" ]]; then
    echo "$_IMPORT__SOURCE_FILE: line $_IMPORT__LINE_NUMBER: module '$mod' not found (searched $module_path)"
    return 1
  fi
  source "$module_path"
}
# TODO: _IMPORT__SOURCE_FILE and _DIR should be set by prelude.sh
declare _IMPORT__SOURCE_FILE
declare _IMPORT__SOURCE_DIR
declare _IMPORT__LINE_NUMBER
declare -a _IMPORT__DEFAULT_MODULEPATH=(
  "$HOME/.local/lib/bashmod"
  "/usr/local/lib/bashmod"
)

# Resolve a relative module path.
_import::resolve_module_path() {
  local -r module_path="$1"
  printf '%s' "${module_path//.//}.mod.bash"
}

# Parse the modulepath into the given array
_import::parse_modulepath() {
  local modulepath_array_name="$1"
  string::split ":" "$MODULEPATH" "$modulepath_array_name"
}

# Search the relative directory and modulepath for the module, returning its
# location.
_import::search_module_path() {
  local -r module_path="$1"
  local -r resolved_module_path="$(_import::resolve_module_path "$module_path")"

  local -a modulepath=()
  local -a parsed_modulepath=()
  local try_path

  # Parse modulepath.
  if declare -p MODULEPATH >/dev/null 2>&1; then
    _import::parse_modulepath parsed_modulepath
  fi
  modulepath=(
    "$_IMPORT__SOURCE_DIR"
    "${parsed_modulepath[@]}"
    "${_IMPORT_DEFAULT_MODULEPATH[@]}"
  )

  for path in "${modulepath[@]}"; do
    try_path="$path/$resolved_module_path"
    if [[ -e "$try_path" ]]; then
      printf '%s' "$try_path"
      return 0
    fi
  done

  echo "$_IMPORT__SOURCE_FILE: line $_IMPORT__LINE_NUMBER: module" \
       "'$module_path' not found (searched ${modulepath[*]})" >&2
  return 1
}

importmod() {
  local -r module_path="$1"
  _IMPORT__SOURCE_FILE="${BASH_SOURCE[1]}"
  _IMPORT__SOURCE_DIR="$(realpath "$(dirname "$_IMPORT__SOURCE_FILE")")"
  _IMPORT__LINE_NUMBER="${BASH_LINENO[0]}"
  local path_to_module
  path_to_module="$(_import::search_module_path "$module_path")"
  source "$path_to_module"
}
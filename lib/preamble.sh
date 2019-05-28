##### Helper Methods #####

# Get the full directory name of the given file, resolving any symlinks inthe
# process.
safe_dirname() {
  cd -P "$(dirname "$1")" >/dev/null 2>&1
  pwd
}

is_symlink() {
  [[ -h "$1" ]]
}

is_absolute_path() {
  [[ "$1" == /* ]]
}

is_relative_path() {
  ! is_absolute_path "$1"
}

# Resolve nested and relative symlinks.
# (based on https://stackoverflow.com/a/246128)
# TODO: check if there's any reason to prefer this over `realpath`
safe_readlink() {
  local SOURCE="$1"
  local DIR
  while is_symlink "$SOURCE"; do
    DIR="$(safe_dirname "$SOURCE")"
    SOURCE="$(readlink "$SOURCE")"
    if is_relative_path "$SOURCE"; then
      SOURCE="$DIR/$SOURCE"
    fi
  done
  printf "$(safe_dirname "$SOURCE")"
}

# variables to unset on teardown
_PREAMBLE_PRIVATE_VARS=(
  _PREAMBLE_SET_FLAGS
  _PREAMBLE_SOURCE_PATH
  _PREAMBLE_PRIVATE_FUNCS
  _PREAMBLE_PRIVATE_VARS
)

# functions to unset on teardown
_PREAMBLE_PRIVATE_FUNCS=(
  _preamble_set_flags
  _preamble_revert_flags
  _preamble_setup
  _preamble_teardown
)

# Set the given flags
_preamble_set_flags() {
  for flag in "$@"; do
    if [[ ! -o "$flag" ]]; then
      _PREAMBLE_SET_FLAGS+=("$flag")
      set -o "$flag"
    fi
  done
}

_preamble_revert_flags() {
  for flag in "${_PREAMBLE_SET_FLAGS[@]}"; do
    set +o "$flag"
  done
}

_preamble_setup() {
  # Find the real path to preamble.sh.
  declare -g _PREAMBLE_SOURCE_PATH="$(safe_dirname ${BASH_SOURCE[0]})"

  # Create the array used by _preamble_set_flags.
  declare -ag _PREAMBLE_SET_FLAGS=()
  _preamble_set_flags errexit nounset pipefail
}

_preamble_teardown() {
  _preamble_revert_flags
  unset -f "${_PREAMBLE_PRIVATE_FUNCS[@]}"
  unset -v "${_PREAMBLE_PRIVATE_VARS[@]}"
}


_preamble_setup

source "$_PREAMBLE_SOURCE_PATH/loader.sh"

_preamble_teardown
#!/usr/bin/env bats

@test "string::split" {
  source ./lib/strings.sh
  local -a testarray
  string::split ":" "foo:bar:baz" testarray
  [ "${testarray[0]}" == foo ]
  [ "${testarray[1]}" == bar ]
  [ "${testarray[2]}" == baz ]
}

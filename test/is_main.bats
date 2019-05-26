#!/usr/bin/env bats

@test "is_main detects when it's main" {
    load common
    result="$(bash test/is_main/sourcable.sh)"
    [ "$result" == "sourcable.sh running as main" ]
}

@test "is_main detects when it's sourced" {
    load common
    result="$(bash test/is_main/main.sh)"
    [ "$result" == "sourcable.sh sourced" ]
}

@test "is_main detects when it's main even if symlinked" {
    load common
    result="$(bash test/is_main/sourcable-symlink)"
    [ "$result" == "sourcable.sh running as main" ]
}
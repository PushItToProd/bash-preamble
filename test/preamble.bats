@test "sourcing preamble doesn't pollute shell flags" {
    load common
    run bash test/preamble/test_noset.sh
    # echo "# $output" >&3
    [ "$status" -eq 0 ]
}

@test "sourcing preamble doesn't unset an already-set flag" {
    load common
    run bash test/preamble/test_noset.sh
    # echo "# $output" >&3
    [ "$status" -eq 0 ]
}

@test "sourcing preamble doesn't unset multiple already-set flags" {
    load common
    run bash test/preamble/test_noset.sh
    # echo "# $output" >&3
    [ "$status" -eq 0 ]
}

@test "sourcing preamble doesn't pollute the environment" {
    load common
    run bash test/preamble/test_array_unset.sh
    if [[ $status -ne 0 ]]; then
        echo "# $output" >&3
    fi
    [ "$status" -eq 0 ]
}
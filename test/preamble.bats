@test "test sourcing preamble.sh" {
    load common
    run preamble/test_noset.sh
}

@test "test sourcing preamble.sh with one flag set" {
    load common
    run preamble/test_noset.sh
}

@test "test sourcing preamble.sh with all flags set" {
    load common
    run preamble/test_noset.sh
}
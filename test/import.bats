#!/usr/bin/env bats

@test "relative imports work" {
    load common
    run bash test/import/test_relative_import.sh
    if [ "$status" -ne 0 ]; then
        echo "$output" >&3
    fi
    [ "$status" -eq 0 ]
    [ "$output" == "foo::bar() called" ]
}

@test "modulepath imports work" {
    load common
    run bash test/import/test_import.sh
    if [ "$status" -ne 0 ]; then
        echo "$output" >&3
    fi
    [ "$status" -eq 0 ]
    [ "$output" == "foo::bar() called" ]
}

@test "nonexistent imports fail" {
    load common
    run bash test/import/test_nonexistent_import.sh
    if [ "$status" -ne 1 ]; then
        echo "$output" >&3
    fi
    [ "$status" -eq 1 ]
    inString "test/import/test_nonexistent_import.sh: line 4: module 'nonexistent_module' not found" "${lines[0]}"
}

@test "module search finds relative modules" {
    load common
    run bash test/import/search_module_path.sh module_path.foo
    [ "$status" -eq 0 ]
    [ "$output" == "./test/import/module_path/foo.mod.bash" ]
}

@test "module search finds modules on a custom path" {
    load common
    export MODULEPATH="test/import/module_path"
    run bash test/import/search_module_path.sh foo
    [ "$status" -eq 0 ]
    [ "$output" == "./test/import/module_path/foo.mod.bash" ]
    unset MODULEPATH
}
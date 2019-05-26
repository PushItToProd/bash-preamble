# Checks whether it's called from the top of a function. Use this to make a
# script both sourceable and directly invokable.
is_main() {
    # If is_main is called from the top level of a function, then the
    # BASH_SOURCE array will only have two entries: the main file and this one.
    [[ "${#BASH_SOURCE[@]}" -eq 2 ]]
}
# preamble import

## Terminology

* package: a directory containing bash modules
* module: a unit of bash code contained in a module file
* module file: a `.mod.bash` file containing bash code
* module name: the prefix of the module filename. e.g. `foo.mod.bash` has a
  module name of `foo`
* qualified module name: a period-delimited path specifying a module contained
  by a package
* module path: the resolved relative path of a module (not to be confused with
  `MODULEPATH`)
  * e.g. `foo.bar.baz` resolves to `foo/bar/baz.mod.bash`
* module search path: a filesystem path to search for a module
* `MODULEPATH`: an environment variable containing a colon-delimited list of
  paths to search when finding a module

## Module finding logic

Given an import statement like `importmod foo.bar.baz`, we first compute the
path we will check when searching each potential module location. This path is
`foo/bar/baz.mod.bash`.

Next, we identify the list of paths to search. The first is always the
fully-resolved path of the directory containing the script where `importmod` was
called. Then we search each entry on `MODULEPATH`. Then we search the default
system modulepath: 

* ~/.local/lib/bashmod
* /usr/local/lib/bashmod

### Pseudocode

Given:

- import invocation: `importmod a.b.c`
- imported from a script file `~/libscript.sh`, a symlink to
  `~/mylib/libscript.sh`, which is a symlink to `/usr/local/mylib/libscript.sh`
- `MODULEPATH` is set to `/opt/bashmod`

The following needs to be done:

1. Resolve the module name `a.b.c` (`_import::resolve_module_name`)
    - Result: `a/b/c.mod.bash`
2. Find the module if it exists. Check the following paths until one exists or
   there is nowhere left to search.  (`_import::search_module_path`)
    - Relative to the real location of the script.
      - Fully resolve symlinks to get `/usr/local/mylib`
      - Check if `/usr/local/mylib/a/b/c.mod.bash` exists
    - In `MODULEPATH` locations:
      - Check if `/opt/bashmod/a/b/c.mod.bash` exists
    - In default `MODULEPATH` locations:
      - Check if `~/.local/lib/bashmod/a/b/c.mod.bash` exists
      - Check if `/usr/local/lib/bashmod/a/b/c.mod.bash` exists
    - If the module was not found, throw an error.
3. Source the script path that was found.


# vim-elixir-compiler

A Vim plugin for automatically compiling Elixir Mix project files on save.
This project is inspired by [`vim-erlang-compiler`][vim-erlang-compiler].

Development is still in progress, and further improvements are needed.

## Installation

TBD.

## Usage

1.  Open a file from an Elixir Mix project root. The project root must contain
    a `mix.exs` file:

    ```
    $ vim lib/example.ex
    $ vim test/example.exs
    $ vim -p test/example.exs lib/example.ex
    ```

2.  Modify the file and save your changes.

3.  If there are compilation errors, a popup buffer will appear.

4.  Fix the errors and save the file again — the buffer will close
    automatically once the code compiles successfully.

## Known Issues, planned improvements

*   Compilation commands are hardcoded.
    The plugin compiles code using `mix compile`.
    For test files, it uses:
    ```
    mix run -e 'Kernel.ParallelCompiler.compile(["test/example.exs"])'
    ```
    This may not fit all use cases and could overwrite existing build files.
    A more flexible and safe compilation method is needed.

*   Test files will only produce their own debug output if the project source
    compiles successfully, as `Kernel.ParallelCompiler` requires a valid build.

*   The debug window displays compilation errors for all project files, not
    just the one being edited.

*   The plugin still requires improvements, including better documentation,
    adherence to best practices, and additional configuration options.

*   In order to decide whether to show an error message for tests,
    now the "Compilation error" string is matche to the standard output of
    the test compile command. This may be improved by matching inside Elixir
    and returning exit code 1.

## Contributing

Feedback and ideas are welcome!

[vim-erlang-compiler]: https://github.com/vim-erlang/vim-erlang-compiler

# vim-elixir-compiler

A Vim plugin for automatically compiling Elixir Mix project files on save.
This project is inspired by [`vim-erlang-compiler`][vim-erlang-compiler].

## Installation

<details>
<summary>Vim's built-in package manager</summary>

This is the recommended installation method if you use at least Vim 8 and you
don't use another package manager.

Information about Vim's built-in package manager: [`:help packages`].

Installation steps:

1.  Clone this repository (you can replace `foo` with the directory name of your
    choice):

    ```sh
    $ git clone https://github.com/mijito-wx/vim-elixir-compiler.git \
          ~/.vim/pack/foo/start/vim-elixir-compiler
    ```

2.  Restart Vim.

3.  Generate help page (replace `foo` with the same directory name as above):

    ```
    :helptags ~/.vim/pack/foo/start/vim-elixir-compiler/doc
    ```
</details>

<details>
<summary>Vundle</summary>

Information about Vundle: [Vundle repository].

Installation steps:

1.  Add `vim-elixir-compiler` to your plugin list in `.vimrc` by inserting
    the line that starts with `Plugin`:

    ```
    call vundle#begin()
      [...]
      Plugin 'mijito-wx/vim-elixir-compiler'
      [...]
    call vundle#end()
    ```

2.  Restart Vim.

3.  Run `:PluginInstall`.
</details>

<details>
<summary>Pathogen</summary>

Information about Pathogen: [Pathogen repository].

Installation steps:

1.  Clone this repository:

    ```
    $ git clone https://github.com/mijito-wx/vim-elixir-compiler.git \
          ~/.vim/bundle/vim-elixir-compiler
    ```

2.  Restart Vim.

3.  Generate help page:

    ```
    :Helptags
    ```
</details>

<details>
<summary>Vim-Plug</summary>

Information about Vim-Plug: [vim-plug repository].

Installation steps:

1.  Add `vim-elixir-compiler` to your plugin list in `.vimrc` by inserting the
    line that starts with `Plug`:

    ```
    call plug#begin()
      [...]
      Plug 'mijito-wx/vim-elixir-compiler'
      [...]
    call plug#end()
    ```

2.  Restart Vim.

3.  Run `:PlugInstall`.
</details>

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

*   Development is still in progress, and further improvements are needed.

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

[`:help packages`]: https://vimhelp.org/repeat.txt.html#packages
[Pathogen repository]: https://github.com/tpope/vim-pathogen
[vim-erlang-compiler]: https://github.com/vim-erlang/vim-erlang-compiler
[vim-plug repository]: https://github.com/junegunn/vim-plug
[Vundle repository]: https://github.com/VundleVim/Vundle.vim

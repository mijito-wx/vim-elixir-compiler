if exists('g:loaded_elixir_compiler')
    finish
endif

let g:loaded_elixir_compiler = 1

command ElixirToggleShowErrors call elixir_compiler#ToggleShowErrors()
autocmd VimEnter *.ex,*.exs call elixir_compiler#EnableShowErrors()

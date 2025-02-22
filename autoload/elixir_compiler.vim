" vim-elixir-compiler file
" Language:     Elixir
" Author:       mijito wx <mijito-wx@proton.me>
" License:      Vim license

if exists('g:autoloaded_elixir_compiler')
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

let g:autoloaded_elixir_compiler = 1
let s:show_errors = 0

function! elixir_compiler#ProjectExists()
    return filereadable(getcwd() . '/mix.exs')
endfunction

function! elixir_compiler#EnableShowErrors()
    if !elixir_compiler#ProjectExists()
        return
    endif
    augroup elixir_compiler
        autocmd!
        autocmd BufWritePost *.ex,*.exs call elixir_compiler#AutoRun()
        autocmd BufUnload,BufDelete *.ex,*.exs call elixir_compiler#Unload()
    augroup END
    let s:show_errors = 1
endfunction

function! elixir_compiler#DisableShowErrors()
    augroup elixir_compiler
        autocmd!
    augroup END
    let s:show_errors = 0
endfunction

function! elixir_compiler#ToggleShowErrors()
    if s:show_errors
        call elixir_compiler#DisableShowErrors()
        echo "Showing Elixir errors off."
    else
        call elixir_compiler#EnableShowErrors()
        echo "Showing Elixir errors on."
    endif
endfunction

function! elixir_compiler#AutoRun()
    if !elixir_compiler#ProjectExists()
        return
    endif
    if !exists("g:elixir_compiler_buffers")
        let g:elixir_compiler_buffers = {}
    endif
    let l:orig_win = winnr()
    let l:filepath = expand('%:p')
    let l:rel_filepath = expand('%:.')
    let l:is_test = l:rel_filepath =~# '^test/' || l:rel_filepath =~# '/test/'
    let l:cmd = l:is_test
          \ ? 'mix run -e ''Kernel.ParallelCompiler.compile(["' . shellescape(l:filepath) . '"])'''
          \ : 'mix compile'
    let l:output = system(l:cmd)
    let l:exit_code = v:shell_error
    if l:is_test && l:output =~# '\<Compilation error\>'
        let l:exit_code = 1
    endif
    if has_key(g:elixir_compiler_buffers, l:filepath) &&
         \ bufexists(g:elixir_compiler_buffers[l:filepath])
        silent! execute 'bdelete! ' . g:elixir_compiler_buffers[l:filepath]
        call remove(g:elixir_compiler_buffers, l:filepath)
    endif
    if l:exit_code == 0 | return | endif
    below new
    let g:elixir_compiler_buffers[l:filepath] = bufnr('%')
    setlocal buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(l:output, "\n"))
    execute l:orig_win . 'wincmd w'
endfunction

function! elixir_compiler#Unload()
  if !exists("g:elixir_compiler_buffers")
      return
  endif
  let l:filepath = expand('%:p')
  if has_key(g:elixir_compiler_buffers, l:filepath) &&
       \  bufexists(g:elixir_compiler_buffers[l:filepath])
    silent! execute 'bdelete! ' . g:elixir_compiler_buffers[l:filepath]
    call remove(g:elixir_compiler_buffers, l:filepath)
  endif
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

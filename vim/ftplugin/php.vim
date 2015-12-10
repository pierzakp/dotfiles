" Indentation
    set softtabstop=4  " tab = 4 space
    set shiftwidth=4
    set expandtab      " no more tabs, only spaces!

" Editor
    set list
    set listchars=trail:¤,tab:>-,nbsp:•     " Show blank spaces and tabs at the end of a line

" PDV
    let g:pdv_cfg_Author = "Olivier Dolbeau <contact@odolbeau.fr>"
    nnoremap <leader>d :call PhpDocSingle()<CR>
    vnoremap <leader>d :call PhpDocRange()<CR>

" php-getter-setter (avoid conflict with command-t)
    map <buffer> <leader>gs <Plug>PhpgetsetInsertBothGetterSetter
    map <buffer> <leader>g <Plug>PhpgetsetInsertGetterOnly
    map <buffer> <leader>s <Plug>PhpgetsetInsertSetterOnly

    "set path+=**

" jump to a twig view in symfony
    function! s:SfJumpToView()
        mark C
        normal! ]M
        let end = line(".")
        normal! [m
        try
            call search('\v[^.:]+\.html\.twig', '', end)
            normal! gf
        catch
            normal! g`C
            echohl WarningMsg | echomsg "Template file not found" | echohl None
        endtry
    endfunction
    com! SfJumpToView call s:SfJumpToView()

" create a mapping only in a Controller file
    autocmd BufEnter *Controller.php nmap <buffer><leader>v :SfJumpToView<CR>

" TagList settings
    let Tlist_Auto_Open=0
    let Tlist_Use_Right_Window=0
    let Tlist_Sort_Type = "name"            " order by
    let tlist_php_settings = 'php;c:class;d:constant;f:function' " don't show variables in php

" PHP refactoring
    let g:php_refactor_command='php /usr/local/bin/refactor.phar'

" PHP namespaces
    inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
    noremap <Leader>u :call PhpInsertUse()<CR>

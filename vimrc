" Brief help:
" :PluginList - list of configured plugins
" :PluginInstall - install plugins, append '!' to update or just type
" :PluginUpdate
" :PluginSearch foo - search for foo, append '!' to refresh local cache
" :PluginClean - confirms removal of unused plugins, append '!' to auto
" approve removal
"
" See :h vundle for more details.

" Basics
    set nocompatible " Use defauts Vim.
    filetype off " Deactivate filetype for pathogen to load snipmate correctly.

    " Set the runtime path to include Vundle and initialize.
    set rtp+=~/.vim/bundle/vundle/ 
    call vundle#rc()

    " Plug-in manager for Vim.
    Plugin 'gmarik/vundle'

" Plugins

    " The NERD tree allows you to explore your filesystem and to open files
    " and directories.
    Plugin 'scrooloose/nerdtree'

    " Plugin for easy commenting.
    Plugin 'scrooloose/nerdcommenter'

    " Precision colorscheme.
    Plugin 'altercation/vim-colors-solarized'

    " The taglist plugin groups and displays the functions, classes,
    " structures, enumerations, macro definitions and other parts of a source
    " code file in a Vim window.
    Plugin 'vim-scripts/taglist.vim'

    " Git wrapper.
    Plugin 'tpope/vim-fugitive'

    " Syntax checking hacks for vim.
    Plugin 'scrooloose/syntastic'

    " Vim script for text filtering and alignment.
    Plugin 'godlygeek/tabular'

    " The plugin provides mappings to easily delete, change and add such 
    " surroundings in pairs.
    Plugin 'tpope/vim-surround'

    " A text object for manipulating comma-delimited lists.
    Plugin 'austintaylor/vim-commaobject'

    " Vim Markdown runtime files.
    Plugin 'tpope/vim-markdown'

    " A Vim plugin which shows a git diff in the gutter (sign column) and
    " stages/reverts hunks.
    Plugin 'airblade/vim-gitgutter'

    " Light and configurable statusline/tabline for Vim.
    Plugin 'itchyny/lightline.vim'

    " Simple tmux statusline generator with support for powerline symbols and
    " lightline integration.
    Plugin 'edkolev/tmuxline.vim'

    " Provides automatic closing of quotes, parenthesis, brackets.
    Plugin 'Raimondi/delimitMate'

    " All of the plugins should be added before the following line.
    call vundle#end()

" Filetype
    filetype on " Enable filetype detection.
    filetype plugin on " Enable filetype plugins.
    filetype indent on " Enable filetype indentation.

" Encoding
    set ff=unix " Unix EOL.
    set fileencoding=UTF-8 " Speak UTF-8.
    set encoding=UTF-8 " Display UTF-8.

" Color
    syntax enable " Enable syntax highlight.
    set background=dark " Dark background is better!
    let php_sql_query = 1 " Enable SQL queries highlight in php strings.
    let php_htmlInStrings = 1 " Enable HTML highlight in php strings.
    if has('gui_running')
        let g:solarized_style="light"
        let g:solarized_contrast="high"
        colorscheme solarized
    else
        colorscheme desertEx
    endif

" UI
    set cursorline " Highlight the current line.
    set scrolloff=8 " Keep x line for scope while scrolling.
    set sidescrolloff=8 " Same.
    set showmatch " Show matching bracket.

" Statusline
    set number " Show line numbers in gutter.
    set showcmd " Show the command being typed.

    set laststatus=2

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    set statusline=%<%f\  " Filename.
    set statusline+=%w%h%m%r " Options.
    set statusline+=\ [%{&ff}/%Y] " Show filetype in statusline.
    set statusline+=\ [%{getcwd()}] " Current dir.
    set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info.

" Editor
    set bs=indent,eol,start " Backspace works everywhere.
    set ruler " Show current cursor position.
    set history=2000 " Increase history size.
    set undolevels=2000 " Increase history size.
    set visualbell " No beeping.
    set noerrorbells " No beeping.
    set nobackup " No backup file!
    set noswapfile " No more swap file!

" Search
    set hlsearch " Highlight matches.

" Indentation
    set autoindent " Automatic indentation.
    set shiftround " When at 3 spaces, and I hit > ... go to 4, not 7.
    set tabstop=4 " Tab will be represented with 4 columns.
    set softtabstop=4 " when in insert mode <tab> is pressed move 4 columns.
    set shiftwidth=4 " Indentation is 4 columns.
    set expandtab
    set smartindent

" Keymap
    " Changing leader
    let mapleader   = ","
    let g:mapleader = ","

    " Quickly edit/reload the vimrc file
    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>

    " Switch to paste mode to copy a large alount of text
    set pastetoggle=<F4>

" Undo
    set undodir=~/.vim/backups
    set undofile

" NERDTree
    let g:NERDTreeWinPos = "left"
    let g:NERDTreeWinSize = 50
    nnoremap <leader>t :NERDTreeToggle<CR>
    nnoremap <leader>o :NERDTreeFind<CR>
    let Tlist_Use_Right_Window = 1
    let Tlist_WinWidth = 60
    nnoremap <leader>v :TlistToggle<CR>

" Tabular mapping
    nmap <Leader>a= :Tab /=<CR>
    vmap <Leader>a= :Tab /=<CR>
    nmap <Leader>a=> :Tab /=><CR>
    vmap <Leader>a=> :Tab /=><CR>
    nmap <Leader>a: :Tab /:\zs<CR>
    vmap <Leader>a: :Tab /:\zs<CR>

" Syntastic
    let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

" Highlight column 80 + column 120 & after
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/

" Git gutter
    :nmap ]h <Plug>GitGutterNextHunk
    :nmap [h <Plug>GitGutterPrevHunk

" Lightline
    let g:lightline = {
      \ 'colorscheme': 'solarized_dark',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

    function! LightLineModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! LightLineReadonly()
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
    endfunction

    function! LightLineFilename()
        return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
            \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
            \  &ft == 'unite' ? unite#get_status_string() :
            \  &ft == 'vimshell' ? vimshell#get_status_string() :
            \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
            \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
    endfunction

    function! LightLineFugitive()
        if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? "\ue0a0 "._ : ''
        endif
        return ''
    endfunction

    function! LightLineFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! LightLineFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! LightLineFileencoding()
        return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! LightLineMode()
        return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction


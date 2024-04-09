" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set clipboard=unnamed
" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.
"""""""""""""""""""""""""""""""""""""
" Automatic installation of vim-plug if not found
" --sync flag is for blocking  execution until the installer finishes
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
" May increase start up time
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

""""""""""""""""""""""""""""""""""""""
call plug#begin()
" +-------------------+
" |  Development Env  |
" +-------------------+
" Prettier code formatting tool
Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" file tree view
Plug 'preservim/nerdtree'

"Asynchronous Lint Engine
Plug 'dense-analysis/ale'

" Javascript syntax highlighting
Plug 'pangloss/vim-javascript'

" Autocomplete
Plug 'Valloric/YouCompleteMe'
call plug#end()
"""""""""""""""""""""""""""""""""""""""
" Plugin Configurations
" ALE - run fixers to format code in Vim buffer
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

" Fix files automatically on save
let g:ale_fix_on_save = 1

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.
" +--------------------+
" |  Soft Wrap Toggle  |
" +--------------------+
map <leader>w :call ToggleWrap()<CR>

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" +----------------+
" |  Code Folding  |
" +----------------+
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" +-----------------------+
" |   Cursor Block/Beam   |
" +-----------------------+
" change cursor betwen NORMAL and INSERT modes
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * startinsert
autocmd VimLeave * silent !echo -ne "\e[5 q"
augroup END

" +--------------------+
" |   Soft Wrap Text   |
" +--------------------+
" remap and the prepended "g's" to navigate "display" lines
let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction

" More Vimscripts code goes here.

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}

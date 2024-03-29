" PLUGINS & ITS OPTIONS

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim' " a simple statusline & tabline
Plug 'itchyny/vim-gitbranch' " a function returns the name of the git branch
Plug 'neoclide/coc.nvim', {'branch': 'release'} " a intellisense engine for vim 8
Plug 'taikusa/java-syntax.vim', {'branch': 'arrange-original'} " a java syntax highlight
Plug 'leafgarland/typescript-vim' " a typescript highlight
Plug 'lervag/vimtex' " for using coc-vimtex
Plug 'taikusa/gruvbox', {'branch': 'arrange-original'} " a colorscheme
call plug#end()

" auto install missing plugins, if any
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \|   source $HOME/.local/share/nvim/init.vim
  \| endif

" lightline.vim options
let g:lightline = {
      \ 'colorscheme' : 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" coc.nvim options and mappings
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
set pumheight=10

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" java-syntax.vim options
highlight link JavaIdentifier NONE

" vimtex options
let g:tex_flavor = 'latex'

" highlight the words the cursor on
if exists(':CocActionAsync')
    autocmd CursorHold * silent call CocActionAsync('highlight')
endif
if exists(':CocAction')
    command! -nargs=0 CocOrganizeImport :call CocAction('runCommand', 'editor.action.organizeImport')
endif

" To recognize filetype
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.ts set filetype=typescript
    autocmd BufNewFile,BufRead *.vue set filetype=typescript
augroup END

" OPTIONS

set visualbell
set noerrorbells

set expandtab " convert tabs to spaces
set smarttab " insert 'tabstop' number of spaces 
set shiftwidth=0 " when shifting, indent using n spaces
set tabstop=2 " indent using n spaces
set autoindent " inherit the indentation of previous lines
set shiftround " when shifting lines, round to the nearest indentation

autocmd FileType java setlocal tabstop=4

set hlsearch " enable search highlighting
set ignorecase " ignore case when searching
set smartcase " automatically switch sensitive when the query contains an uppercase
set incsearch " shows even partial matches

set noshowmode " get rid of showing mode
set showcmd " show command
set showmatch " highlight braces matching
set number " show line numbers on side
set title " set the filename currently being edited the title

set linebreak " avoid wrapping a line in the middle of a word
set wrap " enable line wrapping
set wildmenu " visualize autocomplete for commands
set lazyredraw " redraw only when you need

set confirm " confirm if close an unsaved file
set hidden " hide files in the background instead of closing them
set noswapfile " disable swap files

set clipboard&
set clipboard^=unnamed " mac:unnamed, ubuntu:unnamedplus
set cursorline " highlight line the cursor on
set colorcolumn=80
set scrolloff=4 " keep n line of above/below the cursor
set matchtime=1 " limit time to show 'showmatch' to n millisecond

set laststatus=2 " always display the statusline
set background=dark " use colors that suit a dark backgroud
set mouse=a

set whichwrap+=h,l
set matchpairs & matchpairs+=<:> " add '<>' to braces set
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set backspace=indent,eol,start
set foldmethod=marker " fold contents in marker like {{{ - }}}

set display+=lastline " always try to show a paragraph' last line
set encoding=utf-8 " use an encoding that supports unicode

set shell=$SHELL

syntax enable " enable syntax highlighting
colorscheme gruvbox " a colorsheme
let g:gruvbox_italic = 1
let g:gruvbox_improved_warnings = 1
let g:gruvbox_hls_cursor = 'aqua'
let g:loaded_matchparen = 1

" NETRW

let g:netrw_liststyle = 3 " show like tree
let g:netrw_banner = 0 " disable netrw banner
let g:netrw_altv = 1 " open at right instead of left
let g:netrw_alto = 0 " open at bottom instead of top
let g:netrw_preview = 1 " open new file at right always

" MAPPINGS

" don't start a new line with Enter when autocomplete
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

" yank from the cursor to the end of the line
nnoremap Y y$

" cut and paste without overwriting the register
xnoremap p pgvy
xnoremap P Pgvy
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C

" no highlight
nnoremap <C-h> :noh<CR>

" move even on wrapped lines as usual
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
vnoremap B ^
nnoremap E $
vnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" remain transparate even on vim
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE

" highlight only column number
highlight CursorLine ctermbg=NONE

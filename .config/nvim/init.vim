" TheSilhouette's vim config file

let mapleader = "-"
let localleader = "\\"

" SETTINGS SOLELY FOR VIMRC {{{ 
" special settings for this vim file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" some quality of life options
set number
set numberwidth=4
set nocompatible
set encoding=UTF8
set laststatus=2
set noshowmode
set hidden
set linespace=2
" spaces
set smarttab
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2

" preserve tabs in Makefiles
autocmd FileType make setlocal noexpandtab

" some quality of life keys
" remove the current line in insert mode
inoremap <c-d> <esc>ddi
" return to normal mode with home row keys
inoremap jk <esc>
nnoremap <c-s> :w<cr>

" switch tabs
nnoremap <f1> :tabp<cr>
nnoremap <f2> :tabn<cr>
" switch splits
nnoremap ;h <c-w>h
nnoremap ;l <c-w>l
nnoremap ;j <c-w>j
nnoremap ;k <c-w>k

" toggle case of a string in normal mode, without getting into visual mode
nnoremap <c-u> viw~<esc>

" remapping operators
" this selects the inner stuff between parenthesis
onoremap p i(


let g:vimwiki_list = [{'path': '~/Documents/vimwiki/'}]

" Automatic vimplug install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins to Install {{{
call plug#begin()
  Plug 'vimwiki/vimwiki'
  Plug 'ap/vim-css-color'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'josa42/vim-lightline-coc'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'jiangmiao/auto-pairs'
  Plug 'mattn/emmet-vim'
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'mkitt/tabline.vim'
call plug#end()

" }}}

" set colour themes
set termguicolors
colorscheme PaperColor

lua require('plugins')

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>


" easier switching windows
nnoremap <A-h> <c-w>h
nnoremap <A-j> <c-w>j
nnoremap <A-k> <c-w>k
nnoremap <A-l> <c-w>l

set splitbelow
set splitright

let g:lightline = {
  \   'active': {
  \     'left': [['mode', 'paste'], ['readonly', 'filename', 'modified'], [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]]
  \   }
  \ }

" register components:
call lightline#coc#register()

" coc.nvim plugins
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-prettier', 'coc-deno', 'coc-clangd', 'coc-css', 'coc-emmet', 'coc-html',  'coc-lua', 'coc-ltex', 'coc-lightbulb', 'coc-markdownlint', 'coc-tsserver']

" fzf
nnoremap <C-p> :Files<cr>

" emmet
autocmd FileType css html imap <tab> <plug>(emmet-expand-abbr)

" Conqueror of Completion Settings --- {{{
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" only complete if there is a selected item
if exists('*complete_info')
  inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
" navigate the completion list!
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>as  <Plug>(coc-codeaction-selected)
nmap <leader>as  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>a  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>f  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)
" }}}
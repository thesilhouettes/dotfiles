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
syntax on
set nocompatible
highlight CursorLine cterm=underline
highlight Folded ctermbg=NONE ctermfg=Yellow
highlight PMenu ctermbg=White ctermfg=Black
set encoding=UTF8
filetype plugin on
set laststatus=2
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'deus'
  \ }

" spaces
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
inoremap <esc> <nop>
" easier saving
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


" Smart Comments  (actually not that smart though) {{{
"autocmd FileType javascript,c,cpp nnoremap <buffer> <localleader>c I//<esc>
"autocmd FileType vim nnoremap <buffer> <localleader>cI"<esc>
" }}}

let g:vimwiki_list = [{'path': '~/Documents/vimwiki/'}]
" Plugins to Install {{{
call plug#begin()
  Plug 'mhinz/vim-startify'
  Plug 'vimwiki/vimwiki'
  Plug 'ap/vim-css-color'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'josa42/vim-lightline-coc'
  Plug 'voldikss/vim-floaterm'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'scrooloose/nerdcommenter'
call plug#end()

" }}}


let g:lightline = {
  \   'active': {
  \     'left': [['mode', 'paste'], ['readonly', 'filename', 'modified'], [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]]
  \   }
  \ }

" register components:
call lightline#coc#register()

nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
nnoremap   <silent>   <F10>   :FloatermKill<CR>
tnoremap   <silent>   <F10>   <C-\><C-n>:FloatermKill<CR>

nnoremap <c-p> :Files<cr>
nnoremap <c-o> :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

" Conquare of Completion Settings {{{
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"" }}}

" ** Plugins **
" Download plug.vim if it doesn't exist yet
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin("~/.vim/plugged")
    Plug 'scrooloose/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'sheerun/vim-polyglot'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'nanotech/jellybeans.vim'
    Plug 'lifepillar/vim-solarized8'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'mhinz/vim-signify'
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source ~/.vimrc
\| endif

" ** Plugin Config **
" Coc
let g:coc_global_extensions = ['coc-rls', 'coc-tsserver', 'coc-vimlsp', 'coc-go', 'coc-omnisharp']
let g:coc_user_config = {"coc.preferences.formatOnSaveFiletypes": ["rust", "typescript", "go"]}
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
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
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Jellybeans
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
if has('termguicolors') && &termguicolors
    let g:jellybeans_overrides['background']['guibg'] = 'none'
endif

" ** Editor Config **
syntax on
set ignorecase
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number relativenumber
set cursorline
set cursorlineopt=line
hi cursorline term=bold cterm=bold guibg=grey40
set noswapfile
set splitright
set clipboard+=unnamedplus
set background=light
colorscheme jellybeans
set encoding=UTF-8
let g:airline_theme='fruit_punch'
let g:airline_powerline_fonts = 1
set undofile
set undodir^=~/.vim/backup//
let g:signify_sign_add = '│'
let g:signify_sign_delete = '│'
let g:signify_sign_change = '│'
highlight SignifySignAdd ctermfg=green guifg=#00ff00 cterm=NONE gui=NONE
highlight SignifySignDelte ctermfg=red guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE
set signcolumn=yes
highlight clear SignColumn

" ** Key Mappings **
nnoremap <Space> <nop>
let mapleader=" "
nnoremap <Leader>d <C-d>
nnoremap <Leader>u <C-u>
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>v <C-w>v
nnoremap <Leader>s <C-w>s
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>p :bp<CR>
tnoremap <Esc> <C-\><C-n>
cabbrev h vert h
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf  <Plug>(coc-fix-current)

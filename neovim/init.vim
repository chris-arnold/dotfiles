set nocompatible              " be iMproved, required
filetype off                  " required

let g:python_host_prog='/usr/local/bin/python2'
let g:python3_host_prog='/usr/local/bin/python3'

call plug#begin('~/.local/share/nvim/plugged')

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Numkil/ag.nvim'
" Plug 'roxma/nvim-completion-manager'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'janko-m/vim-test'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/echodoc.vim'
Plug 'mhinz/vim-grepper'
Plug 'kannokanno/previm'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'mustache/vim-mustache-handlebars'
" Plug 'pangloss/vim-javascript'
Plug 'maciakl/vim-neatstatus'
Plug 'chr4/nginx.vim'
Plug 'scrooloose/nerdtree'
Plug 'liuchengxu/vim-which-key'

call plug#end()

let mapleader = '\'
nnoremap <silent> <leader> :WhichKey '\'<CR><Paste>
set hidden
set nofoldenable

" vim-plug commands for above:
"   PlugInstall [name ...]
"   PlugUpdate [name ...]
"   PlugClean[!]
"   PlugUpgrade
"   PlugStatus
"   PlugDiff
"   PlugSnapshot[!] [output path]

" DEOPLETE
let g:deoplete#enable_at_startup = 1

" ALE
let g:ale_linters = {'javascript': ['eslint']}
" let g:ale_python_flake8_executable = $HOME . '/Library/Python/2.7/bin/flake8'
let g:ale_python_flake8_executable = '/Users/carnold/Library/Python/2.7/bin/flake8'
let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_options = '--config /Users/carnold/.config/flake8'
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_open_list = 1
nnoremap <silent> <leader>n :ALELint<CR>
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)

" LANGUAGE SERVER CONFIGURATION
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ["$HOME/Projects/langserver/javascript-typescript-langserver/lib/language-server-stdio.js"],
    \ 'Dockerfile': ['docker-langserver'],
    \ 'groovy': ['java', '-jar', "$HOME/Projects/langserver/language-servers/groovy-language-server/build/libs/groovy-language-server-0.5.0-all.jar"],
    \ 'python': ['$HOME/Library/Python/3.7/bin/pyls'],
    \ 'lua': ['lua-lsp'],
    \ 'go': ['go-langserver'],
    \ }

" Syntax-specific
let g:groovy_allow_cpp_keywords = 1  " disable groovy syntax flagging C++ keywords

" NERDTree
" open on empty args to `vim`
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <leader>r :NERDTreeToggle<CR>
map <leader>' :NERDTreeToggle<CR>

" Indent Guides
let g:indent_guides_auto_colors = 0
nnoremap <leader>i :IndentGuidesToggle<CR>
hi IndentGuidesOdd ctermbg=233

nnoremap <silent> gp :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

set shell=/usr/local/bin/zsh

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Filetypes for syntax highlighting
autocmd BufNewFile,BufRead *.groovy  setlocal ft=groovy
autocmd BufNewFile,BufRead Jenkinsfile* setlocal ft=groovy
autocmd BufNewFile,BufRead Dockerfile* setlocal ft=dockerfile
autocmd BufNewFile,BufRead *.json setlocal ft=json
autocmd BufNewFile,BufRead nginx.conf setlocal ft=nginx
autocmd BufNewFile,BufRead *.go setlocal ft=go tabstop=4

" Highlight after column 80
" :match ErrorMsg '\%>80v.\+'

" Clear search highighting
nnoremap <silent> <leader>c :nohlsearch<CR>

" Count number of words under cursor
map ,* *<C-O>:%s///gn<CR>

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Toggle paste mode.
nnoremap <leader>p :set paste!<CR>

" Toggle for seeing line breaks and trailing spaces.
nnoremap <leader>l :set list!<CR>
set listchars=tab:>-,eol:¬,nbsp:▪,trail:▪

" NeatStatusLine customizations
let g:NeatStatusLine_color_normal = 'ctermfg=Magenta ctermbg=Black'
let g:NeatStatusLine_color_insert = 'ctermfg=Black ctermbg=Yellow'
let g:NeatStatusLine_color_replace = 'ctermfg=Black ctermbg=Red'
let g:NeatStatusLine_color_filetype = 'ctermfg=0 ctermbg=NONE'
let g:NeatStatusLine_color_modified = 'ctermbg=Black ctermfg=Yellow'
let g:NeatStatusLine_color_line = 'ctermbg=Black ctermfg=Cyan'


"""""""""""""""""""""""""""""""""""
" HIGHLIGHTING/COLORS
"""""""""""""""""""""""""""""""""""
syntax enable
set t_Co=16
set background=dark
hi ColorColumn ctermfg=686 ctermbg=565
hi DiffAdd ctermfg=black ctermbg=17
hi DiffChange ctermfg=black ctermbg=232
hi DiffDelete ctermfg=black ctermbg=88
hi DiffText ctermfg=black ctermbg=233
hi Directory ctermfg=14
hi Error ctermfg=black
hi ErrorMsg ctermfg=black
hi FoldColumn ctermfg=1 ctermbg=8
hi Folded ctermfg=1 ctermbg=8
hi Ignore ctermfg=55
hi IncSearch ctermbg=21 ctermfg=33
hi PmenuSbar ctermbg=black ctermfg=white
hi PmenuSel ctermbg=black ctermfg=white
hi PmenuThumb ctermbg=black ctermfg=white
hi Question ctermfg=6
hi Search ctermbg=20 ctermfg=31
hi SignColumn ctermbg=NONE
hi Special ctermfg=3
hi StatusLine ctermfg=233 ctermbg=darkgreen
hi StatusLineNC ctermfg=233 ctermbg=239
hi TabLine ctermbg=black
hi TabLineFill ctermbg=red ctermfg=black
hi Underlined ctermfg=32
hi WildMenu ctermfg=4 ctermbg=236
hi Comment ctermfg=darkgreen ctermbg=233
hi Constant ctermfg=5
hi Function ctermfg=1
hi Identifier ctermfg=NONE cterm=NONE
hi Operator ctermfg=10
hi PreProc ctermfg=1
hi String ctermfg=darkmagenta
hi Todo ctermbg=25 ctermfg=White
hi Type ctermfg=9
hi pythonAttribute ctermfg=2
hi pythonBuiltin ctermfg=4
hi pythonDocString ctermfg=darkgreen ctermbg=233
hi yamlBlockMappingKey ctermfg=1
hi xmlTagName ctermfg=1
hi xmlEndTag ctermfg=1
hi IndentGuidesEven ctermbg=NONE

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Netrw options/bindings
let g:netrw_banner = 0
let g:netrw_browse_split = 2  " 1-hsplit 2-vsplit 3-newtab 4-prevwin
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

set splitbelow
set splitright

map <leader>[ :vertical resize -10<CR>
map <leader>] :vertical resize +10<CR>
map <leader>- :resize -10<CR>
map <leader>= :resize +10<CR>
map <C-w><C-[> :vertical resize -10<CR>
map <C-w><c-]> :vertical resize +10<CR>

" Navigation bindings
map gr gT
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" <Tab> and <Shift-Tab> for autocompletion selection
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Have <c-c> trigger <ESC> so InsertLeave is fired
inoremap <c-c> <ESC>

" Grepper
nnoremap <silent> <leader>g :Grepper -cword -noprompt<cr>

" AG
" Always search from project root (.git or other svn dir).
let g:ag_working_path_mode="r"

" FZF
nnoremap <leader>t :GFiles<CR>
nnoremap <leader>y :Files<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Move the recording binding to Ctrl-q because I fat finger it too often.
nnoremap q <NOP>
noremap <C-q> q

" vim-test
let test#strategy = 'neovim'
let test#python#runner = 'pytest'
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ta :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

" Copy/cut visual selection to clipboard (pbcopy).
vnoremap <C-c> :w !pbcopy<CR><CR> 

" Replace occurances of word under cursor.
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Misc vim options
set backspace=indent,eol,start
set ignorecase
set gcr+=a:blinkon0
set mouse=a
set noerrorbells
set nostartofline
set number
set scrolloff=5
set showcmd
set showmatch
" set hlsearch
" set title

" Tabs
" set smartindent
" set autoindent
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4
" set copyindent
" set tabstop=4
" set shiftround

" File type-specific settings
set modeline

au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

au FileType javascript set shiftwidth=2
au FileType javascript set softtabstop=2
au FileType javascript set tabstop=2


autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

autocmd FileType groovy set smartindent autoindent

" Persistent undo
set undofile
set undolevels=10000
set undoreload=100000

" Backup
set nobackup
set nowritebackup

" Performance
set synmaxcol=256

" Open buffers with cursor set to its last position
autocmd BufReadPost *
  \ if line("'\'") > 0 && line("'\'") <= line("$") |
    \   exe "normal g`\"" |
      \ endif

" Previm
let g:previm_open_cmd = 'open -a Firefox'
nnoremap <leader>m :PrevimOpen<CR>
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mmd,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

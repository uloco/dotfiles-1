" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs'
Plug 'w0rp/ale'
Plug 'joshdick/onedark.vim'

" vim syntaxing might slow down vim
Plug 'pangloss/vim-javascript'

Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'
" Plug 'mklabs/split-term.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ryanoasis/vim-devicons'
" requires fzy and rg or ag
Plug 'cloudhead/neovim-fuzzy'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/Tabmerge'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

" autocomplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" linting
let g:ale_fixers = {
\  'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1


" basic settings
syntax on
autocmd FileType vue syntax sync fromstart
colorscheme onedark
let g:airline_theme='deus'
let g:airline_powerline_fonts=1
" number seems to slow down vim
" set number relativenumber
set rnu
set incsearch
nnoremap <Space> :nohl <Enter>
set tabstop=2
set shiftwidth=2
set expandtab
" navigate with alt
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>s :vnew<CR>
nnoremap <Leader>r :Tabmerge right<CR>

set ignorecase
set smartcase

nnoremap <Leader>m :tabm 

" ternjs
nnoremap :rn :TernRename<CR>
nnoremap :gd :TernDef<CR>
autocmd FileType riot call tern#Enable()
autocmd FileType riot setlocal completeopt-=preview

" nerdtred
let g:NERDTreeWinSize=40
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
" autoclose vim if only nerd tree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowLineNumbers=1
set encoding=utf8
" fileicon settings
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = 'v'
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let NERDTreeQuitOnOpen=1
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['vue'] = '3AFFDB'


" gitgutter
let g:gitgutter_map_key = 0
set updatetime=100

" performance
set lazyredraw

" terminal
" Create a new terminal in a vertical split
tnoremap <Leader>l <C-\><C-n>:vsp<CR><C-w><C-w>:term<CR>
noremap <Leader>l :vsp<CR><C-w><C-w>:term<CR>
inoremap <Leader>l <Esc>:vsp<CR><C-w><C-w>:term<CR>

" Create a new terminal in a horizontal split
tnoremap <Leader>j <C-\><C-n>:sp<CR><C-w><C-w>:term<CR>
noremap <Leader>j :sp<CR><C-w><C-w>:term<CR>
inoremap <Leader>j <Esc>:sp<CR><C-w><C-w>:term<CR>

" Create a new terminal in a new tab
noremap <Leader>c :tabnew<CR>:term<CR>

" Switches back to vim mode in terminal, can then close with :q
tnoremap <Esc> <C-\><C-n>

" Fuzzy finder
let g:fuzzy_opencmd = 'edit'
nnoremap <C-p> :FuzzyOpen<CR>

" string search
nnoremap <Leader>f :FuzzyGrep<CR>

" trailing whitespaces
set list listchars=tab:>\ ,trail:-,eol:↵

" syntaxing
let g:tigris#on_the_fly_enabled = 1
let g:tigris#delay = 500


" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
  endif

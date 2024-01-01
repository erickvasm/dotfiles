" ---------------------
" 1. MAIN CONFIGURATION
" ---------------------
filetype plugin indent on
filetype plugin on
set termguicolors
set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
set showcmd
set ruler
set cursorline
set encoding=utf8
set showmatch
set termguicolors
set sw=2
set wrap linebreak
set hlsearch                   
set incsearch                   
set ignorecase                  
set smartcase 
set laststatus=2
set noshowmode

" ------------
" 2. VIM-PLUG
" ------------
call plug#begin()

" THEME
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plugin 'NLKNguyen/papercolor-theme'

" TABS
Plug 'vim-airline/vim-airline'
Plug 'romgrk/barbar.nvim'

" TREE
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ICONS
Plug 'ryanoasis/vim-devicons' 
Plug 'kyazdani42/nvim-web-devicons'

" TYPING
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-autopairs'

" PRETTIER
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" AUTOCOMPLETE
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" SYNTAX
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" COLORS
Plug 'lilydjwg/colorizer'
Plug 'junegunn/rainbow_parentheses.vim'

" TELESCOPE
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" GIT
Plug 'APZelos/blamer.nvim'

" GITHUBCOPILOT
Plug 'github/copilot.vim'

" IDE
Plug 'numToStr/Comment.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'yggdroot/indentline'
Plug 'lukas-reineke/indent-blankline.nvim'

" LSP AND MASON
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'


call plug#end()

" -----------------
" 3. CONFIGURATION
" -----------------
" AYU THEME
" let ayucolor="dark" 

" MASON VIM
lua require('mason').setup()
lua require('mason-lspconfig').setup()

" GIT BLAME
let g:blamer_enabled = 1

" NERDTree
let NERDTreeQuitOnOpen=1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

let g:NERDTreeGitStatusUseNerdFonts = 1 
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1

" AIRLINE
let g:airline#extensions#tabline#enabled = 0
let g:airline_section_c_only_filename = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = "onedark"

" PRETTIER
let g:prettier#quickfix_enabled = 0
autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync

"------------------
" 4. CUSTOM MAPING
"-----------------
let mapleader=" "

" SAVE
nmap <C-s> :w<CR>
nmap <C-q> :q<CR>

" ALL TEXT, PASTE, COPY, RENDO, CUT
nmap <C-v> "+P
nmap <C-a> ggVG
nmap <C-z> :undo<CR>
nmap <C-y> :redo<CR>
nmap <C-x> dd

" SEARCH AND REPLACE
nmap <C-r> :%s///gc<Left><Left>
nmap <C-f> / 

" SPLIT S
nmap <Leader>s :vsp<CR>

" INIT.VIM
nmap <leader>r :so ~/.config/nvim/init.vim<CR>

" BUFFERS
nmap <Leader>qq :NERDTreeToggle<CR>
nmap \\ <leader>qq
nmap <Tab> :bnext<CR>
nmap <Leader>t :enew<CR>
nmap <Leader>oo :Buffers<CR>
nnoremap <Leader>q :bdelete<CR>

" SPLIT
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><

" SEARCH FILES
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>

" SCROOLLING
nnoremap <silent> <right> :vertical resize +5<CR>
nnoremap <silent> <left> :vertical resize -5<CR>
nnoremap <silent> <up> :resize +5<CR>
nnoremap <silent> <down> :resize -5<CR>

nmap <Leader>es <Plug>(easymotion-s2)

" DEFINITION.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" PRETTIER
nmap <Leader>p :Prettier<CR>

" THEME TRANSPARENT
function! TransparentBackground()
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    set fillchars+=vert:\│
    highlight WinSeparator gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
    highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
endfunction

# Para desactivar el tema TransparentBackground solo hay que cambiarlo por set background dark o ligth
augroup MyColors
    autocmd!
    autocmd ColorScheme dracula call DraculaTweaks()
    autocmd ColorScheme * call TransparentBackground() 
augroup END

color onedark

syntax on

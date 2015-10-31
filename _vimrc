set nocompatible                    "关闭兼容模式
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" =====================
" 多语言环境
"    默认为 UTF-8 编码
" =====================
if has("multi_byte")
    " vim的默认编码，如果打开的文件编码和此编码不一致，vim会将编码切换此此属性配置编码再显示
    set encoding=utf-8
    " English messages only
    "language messages zh_CN.utf-8

    if has('win32')
        language english
        let &termencoding=&encoding
    endif

    " Vim在读取文件的时候，会根据这里的编码自动检测
    " 如果检测失败则尝试下一个，直到检测成功为止。如果一直没有转换成功，则此值会为空
    set fencs=utf-8,gbk,chinese,latin1

    " fileencoding(fenc):
    " 这个项目配置的是新建文件和保存文件时文件的编码，如果它的值与enc不一样
    " 那么保存的时候Vim会自动把文件内容由enc的编码转换为fenc配置编码再保存。
    " 而读取文件的时候，该选项的值会自动同步为fencs配置的有效编码。

    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

"菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim


"历史
set history=400

"行控制
set linebreak
set nocompatible
set textwidth=170
set wrap

"行号和标尺
set number
set ruler
set rulerformat=%15(%c%V\ %p%%%)
set relativenumber                  "设置相对行号

" 命令行于状态行
" TODO
set ch=1
set stl=%F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %=[Line]%l/%L\ %=\[%P]
" %= 表示后面的内容居右
set ls=2 " 始终显示状态行

" 搜索
set hlsearch
set noincsearch

" 制表符
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" 状态栏显示目前所执行的指令
set showcmd

" 缩进
set autoindent
set smartindent

" 自动重新读入
set autoread

"标签页
set tabpagemax=8
set showtabline=2

" 控制台响铃
set noerrorbells
set novisualbell

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

" 设定在任何模式下鼠标都可用
set mouse=a

" 备份和缓存
set nobackup
set noswapfile

" 自动完成
set complete=.,w,b,k,t,i
set completeopt=longest,menu

" 代码折叠
set foldmethod=indent
set foldlevel=100

" =========
" AutoCmd
" =========
if has("autocmd")
    filetype plugin indent on

    " 括号自动补全
    func! AutoClose()
        :inoremap ( ()<ESC>i
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap < <><ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
    endf

    func! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf

    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=80
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END

    "auto close quotation marks for PHP, Javascript, etc, file
    au FileType php,c,python,javascript,html,css exe AutoClose()

    " Auto Check Syntax
    au BufWritePost,FileWritePost *.js,*.php call CheckSyntax(1)

    " JavaScript 语法高亮
    au FileType html,javascript let g:javascript_enable_domhtmlcss = 1

    " 给 Javascript 文件添加 Dict
    if has('gui_macvim') || has('unix')
        au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
    else
        au FileType javascript setlocal dict+=$VIM/vimfiles/dict/javascript.dict
    endif

    " 格式化 JavaScript 文件
    au FileType javascript map <f10> :call g:Jsbeautify()<cr>
    command Jsb :call g:Jsbeautify()
    au FileType javascript set omnifunc=javascriptcomplete#CompleteJS

    " 给 CSS 文件添加 Dict
    if has('gui_macvim') || has('unix')
        au FileType css setlocal dict+=~/.vim/dict/css.dict
    else
        au FileType css setlocal dict+=$VIM/vimfiles/dict/css.dict
    endif

    " 增加 ActionScript 语法支持
    au BufNewFile,BufRead *.as setf actionscript

    " 自动最大化窗口
    if has('gui_running')
        if has("win32")
            au GUIEnter * simalt ~x
        endif
    endif
endif

" =========
" 图形界面
" =========

if has('gui_running')
    " 不显示菜单和工具栏
    set guioptions-=m
    set guioptions-=T

    " 高亮光标所在的行
    set cursorline

    " 编辑器配色
    colorscheme iColin

    if has("win32")
        " Windows 兼容配置
        source $VIMRUNTIME/mswin.vim

        " f11 最大化
        map <f11> :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>

        " 字体配置
        ""exec 'set guifont='.iconv('Courier\ New', &enc, 'gbk').':h12:cANSI'
        exec 'set guifont='.iconv('Yahei_Mono', &enc, 'gbk').':h12:cANSI'
        exec 'set guifontwide='.iconv('Yahei_Mono', &enc, 'gbk').':h11'

    endif

    "if has("unix") && !has('gui_macvim')
        "set guifont=Courier New\ 10\ Pitch\ 11
        "set guifontwide=Courier New\ 11
    "endif
endif

" 标签相关的快捷键
nmap <C-t> :tabnew<cr>
nmap <C-p> :tabprevious<cr>
nmap <C-n> :tabnext<cr>
nmap <C-k> :tabclose<cr>
nmap <C-Tab> :tabnext<cr>
"for i in range(1, &tabpagemax)
"    exec 'nmap <A-'.i.'> '.i.'gt'
"endfor

" Automatic updating vimrc
if has("autocmd")
" autocmd bufwritepost _vimrc source $MYVIMRC
endif

"显示空格和tab
set list listchars=tab:→\ ,trail:·
"set list listchars=eol:¬,tab:\ ,trail:.

" 清除搜索高亮
nmap <Leader>c <ESC>/```<ESC><cr>

" css格式化
func! CssFormat()
    :%s/\n//g
    :%s/}/}\r/g
    :%s/\*\//\*\/\r/g
    :%s/{\s/{/g
    :%s/;\s/;/g
    :%s/\(\w\){/\1 {/g
endfunction
nmap <F7> :call CssFormat()<cr>

au BufNewFile,BufRead *.less set filetype=less


" 图片转换
nmap <F9> :/a_\(\d\+\).\(\(jpg\)\\|\(png\)\)
nmap <F10> :%s/a_\(\d\+\).\(\(jpg\)\\|\(png\)\)/{@img_\1}/g

imap <silent> <C-C> <C-R>=string(eval(input("input:")))/40.0<CR>

"================= Vundle start ===========================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Shougo/neocomplcache.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"let g:neocomplcache_enable_at_startup = 1

" 在浏览器预览 for win32
function! ViewInBrowser(name)
    let file = expand("%:p")
    exec ":update " . file
    let l:browsers = {
        \"cr":"C:/Program Files (x86)/Google/Chrome/Application/chrome.exe",
        \"ff":"D:/Program Files (x86)/Mozilla Firefox/firefox.exe",
        \"ie":"C:/progra~1/intern~1/iexplore.exe",
    \}
    let htdocs='E:\\apmxe\\htdocs\\'
    let strpos = stridx(file, substitute(htdocs, '\\\\', '\', "g"))
    if strpos == -1
       exec ":silent !start ". l:browsers[a:name] ." file://" . file
    else
        let file=substitute(file, htdocs, "http://127.0.0.1:8090/", "g")
        let file=substitute(file, '\\', '/', "g")
        exec ":silent !start ". l:browsers[a:name] file
    endif
endfunction
nmap <f4>cr :call ViewInBrowser("cr")<cr>
nmap <f4>ff :call ViewInBrowser("ff")<cr>

" 在浏览器预览 for Mac
"function! ViewInBrowser(name)
"    let file = expand("%:p")
"    let l:browsers = {
"        \"cr":"open -a \"Google Chrome\"",
"        \"ff":"open -a Firefox",
"    \}
"    let htdocs='/Users/leon1/'
"    let strpos = stridx(file, substitute(htdocs, '\\\\', '\', "g"))
"    let file = '"'. file . '"'
"    exec ":update " .file
"    "echo file .' ## '. htdocs
"    if strpos == -1
"        exec ":silent ! ". l:browsers[a:name] ." file://". file
"    else
"        let file=substitute(file, htdocs, "http://127.0.0.1:8090/", "g")
"        let file=substitute(file, '\\', '/', "g")
"        exec ":silent ! ". l:browsers[a:name] file
"    endif
"endfunction
"nmap <Leader>cr :call ViewInBrowser("cr")<cr>
"nmap <Leader>ff :call ViewInBrowser("ff")<cr>

"Arrow keys are evil
map <up>  <nop>
map <down>  <nop>
map <left>  <nop>
map <right>  <nop>
"屏幕上下边缘时自动滚动
set scrolloff=3
"去到匹配的括号然后回来 时间是1/10秒的倍数
set showmatch
set matchtime=1

set ignorecase "忽略大小写
set smartcase  "大写时搜大写，小写时搜大小写

set shiftround "tab时取整


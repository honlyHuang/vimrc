set nocompatible
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


"================= Vundle start ===========================
set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=$vim/vimfiles/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'

 " My Bundles here:
 "
 " original repos on github
Bundle 'mattn/zencoding-vim'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'
" vim-scripts repos
" Bundle 'L9'
" Bundle 'FuzzyFinder'
 " non github repos
 "Bundle 'git://git.wincent.com/command-t.git'
 " git repos on your local machine (ie. when working on your own plugin)
 "Bundle 'file:///Users/gmarik/path/to/plugin'
 " ...

 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..
 " ================== Vundle end =============================



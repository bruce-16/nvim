# 工作台配置
我的工作集: 
1. neovim
2. tmux
3. iterm2

neovim 编辑器配置，使用 Lua 作为配置语言，入口为 `init.lua`。

# 目录
目录结构不会变化，具体文件还会更新
```shell
.
├── README.md
├── ftdetect
│   └── json.lua
├── init.lua
├── lua
│   ├── autocommands.lua
│   ├── basic.lua
│   ├── colorscheme.lua
│   ├── custom-func
│   │   └── work.lua
│   ├── keybindings.lua
│   ├── lsp
│   │   ├── cmp.lua
│   │   ├── config
│   │   │   ├── css.lua
│   │   │   ├── cssmodule.lua
│   │   │   ├── html.lua
│   │   │   ├── json.lua
│   │   │   ├── lua.lua
│   │   │   ├── rust.lua
│   │   │   ├── rust_analyzer.lua
│   │   │   └── ts.lua
│   │   ├── handlers.lua
│   │   ├── lsp-installer.lua
│   │   ├── null-ls.lua
│   │   ├── setup.lua
│   │   └── ui.lua
│   ├── plugin-config
│   │   ├── autopairs.lua
│   │   ├── bufferline.lua
│   │   ├── comment.lua
│   │   ├── cursorline.lua
│   │   ├── dashboard.lua
│   │   ├── diffview.lua
│   │   ├── gitsigns.lua
│   │   ├── hop.lua
│   │   ├── illuminate.lua
│   │   ├── impatient.lua
│   │   ├── lsp_signature.lua
│   │   ├── lspsaga.lua
│   │   ├── lualine.lua
│   │   ├── markdown-preview.lua
│   │   ├── nvim-tree.lua
│   │   ├── nvim-treesitter.lua
│   │   ├── project.lua
│   │   ├── telescope
│   │   │   └── custom-finder.lua
│   │   ├── telescope.lua
│   │   ├── toggleterm.lua
│   │   └── which-key.lua
│   └── plugins.lua
├── plugin
│   └── packer_compiled.lua
├── snippets
│   ├── lua.json
│   ├── package.json
│   └── ts.json
```
# Start
## 依赖安装
1. python
1. node
3. 安装 [packer]( https://github.com/wbthomason/packer.nvim )
4. 安装 [Nerd Font]( https://www.nerdfonts.com/ )
5. 安装 [sharkdp/fd (finder)](https://github.com/sharkdp/fd)
6. 安装 [fzf](https://github.com/junegunn/fzf)
7. 安装 [Ag](https://github.com/ggreer/the_silver_searcher#installing)
## 拉取代码
clone 该仓库放在 `~/.config/nvim` 下。
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
## nvim 里面用 packer 安装依赖
使用 packer 安装其他 plugins
```vim
:PackerSync
```
重新启动 nvim

# tmux & alacritty
先按照官网下载两个软件

## tmux 需要追加的配置
1. 使用 on-my-tmux 作为初始配置，搜索安即可
2. 在 ` ~/.tmux.conf.local ` 中追加用于 vim & tmux 分屏之间的跳转的配置
```tmux
# https://github.com/aserowy/tmux.nvim
is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' { if -F '#{pane_at_left}' '' 'select-pane -L' }
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' { if -F '#{pane_at_bottom}' '' 'select-pane -D' }
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' { if -F '#{pane_at_top}' '' 'select-pane -U' }
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' { if -F '#{pane_at_right}' '' 'select-pane -R' }

bind-key -T copy-mode-vi 'C-h' if -F '#{pane_at_left}' '' 'select-pane -L'
bind-key -T copy-mode-vi 'C-j' if -F '#{pane_at_bottom}' '' 'select-pane -D'
bind-key -T copy-mode-vi 'C-k' if -F '#{pane_at_top}' '' 'select-pane -U'
bind-key -T copy-mode-vi 'C-l' if -F '#{pane_at_right}' '' 'select-pane -R'
```

# 终端配置
**最后还是用回了 iterm2 终端，其他配置太麻烦了，总是有一些奇奇怪怪的问题要花时间去解决**
## alacritty 配置（弃用）
暂时使用官网默认，下载配置文件，根据需要去掉些许配置, 基本配置，不太重要
```yml
window:
  dimensions:
    columns: 120
    lines: 80
  position:
    x: 0
    y: 0
  padding:
    x: 0
    y: 0
  decorations: buttonless
scrolling:
  history: 10000
  multiplier: 3
font:
  normal:
    family: Hack Nerd Font
    style: Regular
  bold:
    family: Hack Nerd Font
    style: Bold
  italic:
    family: Hack Nerd Font
    style: Italic
  bold_italic:
    family: Hack Nerd Font
    style: Bold Italic
  size: 16.0
  vi_mode_cursor:
    text: CellBackground
    cursor: CellForeground
cursor:
  style:
    shape: Block
    blinking: On
  vi_mode_style: Block
  blink_interval: 500
live_config_reload: true
shell:
 program: /usr/local/bin/zsh
 args:
   - --login
key_bindings:
  - { key: T,         mods: Command,                    action: CreateNewWindow }
schemes:
  tokyo-night: &tokyo-night
    primary:
      background: '0x1a1b26'
      foreground: '0xa9b1d6'
    normal:
      black:   '0x32344a'
      red:     '0xf7768e'
      green:   '0x9ece6a'
      yellow:  '0xe0af68'
      blue:    '0x7aa2f7'
      magenta: '0xad8ee6'
      cyan:    '0x449dab'
      white:   '0x787c99'
    bright:
      black:   '0x444b6a'
      red:     '0xff7a93'
      green:   '0xb9f27c'
      yellow:  '0xff9e64'
      blue:    '0x7da6ff'
      magenta: '0xbb9af7'
      cyan:    '0x0db9d7'
      white:   '0xacb0d0'
  tokyo-night-storm: &tokyo-night-storm
    primary:
      background: '0x24283b'
      foreground: '0xa9b1d6'
    normal:
      black:   '0x32344a'
      red:     '0xf7768e'
      green:   '0x9ece6a'
      yellow:  '0xe0af68'
      blue:    '0x7aa2f7'
      magenta: '0xad8ee6'
      cyan:    '0x449dab'
      white:   '0x9699a8'
    bright:
      black:   '0x444b6a'
      red:     '0xff7a93'
      green:   '0xb9f27c'
      yellow:  '0xff9e64'
      blue:    '0x7da6ff'
      magenta: '0xbb9af7'
      cyan:    '0x0db9d7'
      white:   '0xacb0d0'
colors: *tokyo-night-storm
```

## kitty 终端的一些配置（弃用）
由于 alacritty 对中文输入法不太友好，最后使用 kitty，但是只是简单配置

主要是配置了一下主题，不太重要，就不贴配置了

# 工作台配置
我的工作集: 
1. neovim
2. tmux
3. alacritty

主要为 neovim 编辑器配置，使用 Lua 作为配置语言，入口为 `init.lua`。

# 目录
目录结构不会变化，具体文件还会更新
```shell
├── README.md
├── init.lua
├── lua
│   ├── basic.lua
│   ├── colorscheme.lua
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
│   │   ├── null-ls.lua
│   │   ├── setup.lua
│   │   └── ui.lua
│   ├── plugin-config
│   │   ├── autopairs.lua
│   │   ├── bufferline.lua
│   │   ├── dashboard.lua
│   │   ├── diffview.lua
│   │   ├── gitsigns.lua
│   │   ├── lsp_signature.lua
│   │   ├── lualine.lua
│   │   ├── markdown-preview.lua
│   │   ├── nvim-comment.lua
│   │   ├── nvim-tree.lua
│   │   ├── nvim-treesitter.lua
│   │   ├── project.lua
│   │   └── telescope.lua
│   └── plugins.lua
├── plugin
│   └── packer_compiled.lua
```
# Start
## 依赖安装
1. 安装 [packer]( https://github.com/wbthomason/packer.nvim )
2. 安装 [Nerd Font]( https://www.nerdfonts.com/ )
3. 安装 [sharkdp/fd (finder)](https://github.com/sharkdp/fd)
4. 安装 [fzf](https://github.com/junegunn/fzf)
5. 安装 [Ag](https://github.com/ggreer/the_silver_searcher#installing)
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
# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\' 'select-pane -l'

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'C-\' select-pane -l


forward_programs="view|n?vim?|fzf|lazygit|ssh"

should_forward="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?($forward_programs)(diff)?$'"

bind-key -n 'C-h' if-shell "$should_forward" "send-keys C-h" "select-pane -L"
bind-key -n 'C-j' if-shell "$should_forward" "send-keys C-j" "select-pane -D"
bind-key -n 'C-k' if-shell "$should_forward" "send-keys C-k" "select-pane -U"
bind-key -n 'C-l' if-shell "$should_forward" "send-keys C-l" "select-pane -R"
bind-key -n 'C-\' if-shell "$should_forward" "send-keys C-\\" "select-pane -l"
```
## alacritty 配置
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


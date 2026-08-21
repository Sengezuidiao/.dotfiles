# dotfiles

用 [GNU Stow](https://www.gnu.org/software/stow/) 管理的配置文件仓库。

- **stow 目录（放包的地方）**：`~/.dotfiles`
- **目标目录（链接落到哪）**：默认是 stow 目录的**父级**，即 `~`
- 每个子目录是一个 **stow 包**，包内的路径结构决定链接会出现在 `~` 下的哪个位置

## 包 → 目标 映射

| 包 | 源文件（`~/.dotfiles/` 下） | 生成的链接 |
|---|---|---|
| `zsh` | `zsh/.zshrc` | `~/.zshrc` |
| `zsh` | `zsh/.zshenv` | `~/.zshenv` |
| `zsh` | `zsh/.zprofile` | `~/.zprofile` |
| `zsh` | `zsh/.config/zsh/*` | `~/.config/zsh/*` |
| `vim` | `vim/.vimrc` | `~/.vimrc` |
| `tmux` | `tmux/.tmux.conf` | `~/.tmux.conf` |
| `zim` | `zim/.zimrc` | `~/.zimrc` |
| `bash` | `bash/.bashrc` | `~/.bashrc`（**Linux 专用**，macOS 不 stow） |
| `config` | `config/.config/yazi` | `~/.config/yazi` |

> `zsh` 和 `config` 两个包都用**折叠（folding）**机制落到 `~/.config/`，见下文 —— 这是最容易忘、也最容易踩坑的地方。

## 常用命令（速查）

```bash
cd ~/.dotfiles

# 预览会做什么，不改任何东西（改前先跑这个）
stow -n -v <包名>

# 安装一个包（生成 symlink）
stow <包名>
stow zsh                # 例：只装 zsh

# 一次性装多个 / 全部
stow bash config tmux vim zim zsh   # macOS 跳过 bash（Linux 专用）

# 更新：文件内容变了之后，重新 stow
stow -R <包名>          # restow = 先卸载再重装

# 卸载：删掉某个包生成的 symlink
stow -D <包名>

# 目标目录已存在同名文件、stow 报冲突时，接管它
# （把现有文件「收编」进包，再换成 symlink；之后务必 git diff 检查被收编的内容）
stow --adopt <包名>
```

要点：

- `stow` 默认把链接落在 stow 目录的父级（`~`）。要落别处用 `-t`：`stow -t ~/.config config`。
- `--adopt` 会把**当前机器上的真实文件**搬进包并覆盖包内旧内容，用完一定要 `git diff` 看被覆盖了什么。

## `.config` 折叠机制（关键）

`~/.config` 本身是个已经存在的真实目录，不能也不该被 symlink 替换。所以 `zsh` 和 `config` 两个包都不生成 `~/.config` 的链接，而是**折叠进去**：

- `zsh` 包内结构是 `zsh/.config/zsh`
- `config` 包内结构是 `config/.config/yazi`
- `stow <包名>` 时 stow 发现 `~/.config` 已存在，就**下沉一级**，只在里面生成相对链接：
  - `~/.config/zsh  -> ../.dotfiles/zsh/.config/zsh`
  - `~/.config/yazi -> ../.dotfiles/config/.config/yazi`

两个注意点：

1. 包内目录必须**字面叫 `.config`**（带点），stow 才会正确折叠。
2. 折叠的前提是 `~/.config` 已经存在 —— 新机器上 macOS/Homebrew 一般会自带，没有就先 `mkdir -p ~/.config`。

## 新机器初始化

```bash
git clone git@github.com:Sengezuidiao/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 如果 zsh 等文件已经存在（登录 shell 自带），先收编再 stow
stow --adopt zsh
stow bash config tmux vim zim zsh   # macOS 跳过 bash（Linux 专用）
```

之后 `source ~/.zshrc` 或重开终端。首次启动 zsh 会自动下载 zimfw 插件管理器。

## zsh 配置说明

- 入口 `zsh/.zshrc` 只做两件事：按顺序 `source ~/.config/zsh/` 下的模块，然后引导 zimfw。
- 模块按关注点拆在 `~/.config/zsh/`：`env.zsh`（环境变量）、`aliases.zsh`、`vi.zsh`（vi 键位 + 光标）、`plugins.zsh`（fzf/autosuggest 引导）、`qt.zsh`（Linux Qt）、`yazi.zsh`。
- **vi 模式**由 `vi.zsh` 的 `bindkey -v` + 光标函数管理；zim 的 `input` 模块负责终端按键（方向键/Home/End/Delete/`edit-command-line` 等），二者互补。
- **代理**：`env.zsh` 里 `all_proxy=http://127.0.0.1:7890` 常开。
- **Linux Qt/clash**：`qt.zsh` 默认关闭，需要时 `export DOTFILES_LINUX_QT=1` 再开新 shell。
- `fzf.zsh` 是 `fzf --zsh` 的生成产物，已在 `.gitignore`，不入库；首次启动（已装 fzf）自动生成。

## 已知问题 / TODO（改前先看这）

- ~~`.zimrc` 手写绝对链接~~ ✅ 已修复：`~/.zimrc` 已改为 stow 管理的相对链接 `-> .dotfiles/zim/.zimrc`。
- ~~`zimrc` 重复两份~~ ✅ 已去重：删掉 `config/.config/zsh/zimrc`，唯一来源为 `zim/.zimrc`。
- ~~`bash` 包未 stow~~ ✅ 已定性：`bash` 是 **Linux 机器专用**包（`.bashrc` 里硬编码了 `/home/ggbond`、`/home/linuxbrew` 等 Linux 路径），本机（macOS/zsh）**故意不 stow**，仅作 Linux 部署用。
- ~~旧 `~/.config` 仓库残留~~ ✅ 已清理：`~/.config/.git` 已删除，`~/.config` 现在是纯运行时目录（`clash/ copyq/ coc/ QtProject/ nvim/ ...` 不再被当仓库管）。注意 `~/.config/nvim` 是**独立仓库**（`Sengezuidiao/nvim`），与 dotfiles 无关；原 `Sengezuidiao/.config` 远程仓库在 GitHub 上已不存在。
- ~~fzf 补全重复加载~~ ✅ 已去重：删掉旧版 `completion.zsh`（205 行），统一由 `fzf --zsh` 生成的 `fzf.zsh` 提供。
- ~~`plugins.zsh` 死代码~~ ✅ 已清理：原来引用已删除的 `~/.config/zsh/zimrc`，现改为 fzf/autosuggest 引导。
- ~~`CMAKE_PREFIX_PATH` 缺 `$`~~ ✅ 已修复：`zsh/.zprofile` 改为 `$QT6_DIR`。

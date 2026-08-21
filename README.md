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
| `zprofile` | `zprofile/.zprofile` | `~/.zprofile` |
| `vim` | `vim/.vimrc` | `~/.vimrc` |
| `tmux` | `tmux/.tmux.conf` | `~/.tmux.conf` |
| `zim` | `zim/.zimrc` | `~/.zimrc` |
| `bash` | `bash/.bashrc` | `~/.bashrc`（**Linux 专用**，macOS 不 stow） |
| `config` | `config/.config/yazi` | `~/.config/yazi` |
| `config` | `config/.config/zsh` | `~/.config/zsh` |

> `config` 包用的是**折叠（folding）**机制，见下文 —— 这是最容易忘、也最容易踩坑的地方。

## 常用命令（速查）

```bash
cd ~/.dotfiles

# 预览会做什么，不改任何东西（改前先跑这个）
stow -n -v <包名>

# 安装一个包（生成 symlink）
stow <包名>
stow zsh                # 例：只装 zsh

# 一次性装多个 / 全部
stow bash config tmux vim zim zprofile zsh   # macOS 跳过 bash（Linux 专用）

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

## `config` 包的折叠机制（关键）

`~/.config` 本身是个已经存在的真实目录，不能也不该被 symlink 替换。所以 `config` 包不生成 `~/.config` 的链接，而是**折叠进去**：

- 包内结构是 `config/.config/yazi`、`config/.config/zsh`
- `stow config` 时 stow 发现 `~/.config` 已存在，就**下沉一级**，只在里面生成两个相对链接：
  - `~/.config/yazi -> ../.dotfiles/config/.config/yazi`
  - `~/.config/zsh  -> ../.dotfiles/config/.config/zsh`

两个注意点：

1. 包内目录必须**字面叫 `.config`**（带点），stow 才会正确折叠。
2. 折叠的前提是 `~/.config` 已经存在 —— 新机器上 macOS/Homebrew 一般会自带，没有就先 `mkdir -p ~/.config`。

## 新机器初始化

```bash
git clone git@github.com:Sengezuidiao/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 如果 zsh 等文件已经存在（登录 shell 自带），先收编再 stow
stow --adopt zsh
stow bash config tmux vim zim zprofile zsh   # macOS 跳过 bash（Linux 专用）
```

之后 `source ~/.zshrc` 或重开终端。首次启动 zsh 会自动下载 zimfw 插件管理器。

## 已知问题 / TODO（改前先看这）

- ~~`.zimrc` 手写绝对链接~~ ✅ 已修复：`~/.zimrc` 已改为 stow 管理的相对链接 `-> .dotfiles/zim/.zimrc`。
- ~~`zimrc` 重复两份~~ ✅ 已去重：删掉 `config/.config/zsh/zimrc`，唯一来源为 `zim/.zimrc`。
- ~~`bash` 包未 stow~~ ✅ 已定性：`bash` 是 **Linux 机器专用**包（`.bashrc` 里硬编码了 `/home/ggbond`、`/home/linuxbrew` 等 Linux 路径），本机（macOS/zsh）**故意不 stow**，仅作 Linux 部署用。
- ~~旧 `~/.config` 仓库残留~~ ✅ 已清理：`~/.config/.git` 已删除，`~/.config` 现在是纯运行时目录（`clash/ copyq/ coc/ QtProject/ nvim/ ...` 不再被当仓库管）。注意 `~/.config/nvim` 是**独立仓库**（`Sengezuidiao/nvim`），与 dotfiles 无关；原 `Sengezuidiao/.config` 远程仓库在 GitHub 上已不存在。

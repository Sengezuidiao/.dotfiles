# yazi 配置

[yazi](https://github.com/sxyazi/yazi) 终端文件管理器。本目录由 stow 的 `config` 包管理,`~/.config/yazi` 是指向这里的符号链接(`~/.config/yazi -> ../.dotfiles/config/.config/yazi`)。

## 目录结构

```
yazi/
├── yazi.toml      # 主配置(manager/preview/open/tasks/plugin 等)
├── keymap.toml    # 自定义按键(只覆盖默认按键,不是完整 keymap)
├── theme.toml     # 主题入口,指向 flavor(见下)
├── init.lua       # 插件入口(激活 full-border)
├── package.toml   # 依赖清单(唯一来源,plugins/ 和 flavors/ 由此派生)
├── plugins/       # ← gitignore,由 `ya pkg` 自动生成
└── flavors/       # ← gitignore,由 `ya pkg` 自动生成
```

## 依赖管理(重要)

**`plugins/` 和 `flavors/` 不入库**,`package.toml` 是唯一来源。插件/flavor 用 `ya pkg` 管理,**不要手动往这两个目录拷文件**。

| 命令 | 作用 |
|---|---|
| `ya pkg add <id>` | 添加依赖:下载 + 写入 package.toml + 锁定 rev/hash |
| `ya pkg install` | 按 package.toml 安装所有依赖(新机器 clone 后第一次跑) |
| `ya pkg upgrade` | 升级所有依赖到最新版本 |
| `ya pkg delete <id>` | 删除某个依赖 |
| `ya pkg list` | 列出当前依赖及锁定版本 |

`<id>` 格式:`owner/repo` 或 monorepo 子目录 `owner/repo:subdir`。当前依赖:

- 插件 `full-border` → `yazi-rs/plugins:full-border`(边框美化,在 `init.lua` 里 `require("full-border"):setup()` 激活)
- 主题 `gruvbox-dark` → `bennyyip/gruvbox-dark`(在 `theme.toml` 里 `dark = "gruvbox-dark"` 引用)

新机器初始化:

```bash
ya pkg install   # 一次性拉齐 plugin + flavor
```

## 升级 yazi

yazi 用 Homebrew 装,升级后跑一次 `ya pkg upgrade` 让依赖跟上(部分插件对 yazi 版本有要求,如 yaziline 需要较新版本):

```bash
brew upgrade yazi
ya pkg upgrade
```

## 常用按键速查

默认按键已经比较全,这里只列高频的(链式键是顺序按下,不是同时按):

| 键 | 作用 |
|---|---|
| `h j k l` / 方向键 | 左/下/上/进入 导航 |
| `g` `g` / `G` | 跳到顶部 / 底部 |
| `z` / `Z` | 用 fzf / zoxide 跳转目录 |
| `Space` | 选中/取消选中;`v` 进入选择模式 |
| `y` `x` `p` `P` | 复制 / 剪切 / 粘贴 / 粘贴(覆盖) |
| `d` `D` | 移到废纸篓 / 永久删除 |
| `a` `r` | 新建文件(加 `/` 建目录)/ 重命名 |
| `.` | 切换显示隐藏文件 |
| `/` `?` `n` `N` | 查找 / 反向查找 / 下一个 / 上一个 |
| `f` / `s` / `S` | 过滤 / 按文件名搜(fd)/ 按内容搜(rg) |
| `c` `c` `d` `f` `n` | 复制路径 / 目录 / 文件名 / 去扩展名 |
| `,` `m` `s` `a` `n` `e` | 按 时间/大小/字母/自然/扩展名 排序(大写反转) |
| `t` `t` / `1-9` / `[` `]` | 新建标签 / 切换标签 / 前后标签 |
| `w` | 打开任务管理器 |
| `q` / `Q` | 退出(保留 cwd)/ 退出(不保留 cwd) |
| `<C-p>` | **自定义**:Quick Look 预览当前文件(macOS) |

> 退出后保留当前目录,用 `y` 启动而不是 `yazi`(shell wrapper)。完整默认按键见 [yazi keymap 文档](https://yazi-rs.github.io/docs/quick-start)。

## 本仓库对默认配置的改动

- `yazi.toml` 基本是官方默认模板,只微调:`linemode = "size"`(按大小显示)、`scrolloff = 5`、`mouse_events` 加了 `drag`、`sort_fallback = "alphabetical"`、`[confirm]` 开启删除/退出确认。
- `keymap.toml` 只有一条 `<C-p>` → Quick Look 预览。
- `init.lua` 只激活 `full-border` 插件。

## 常见问题

- **改了 package.toml 但插件没变化**:先 `ya pkg install`。
- **`ya pkg` 报「检测到本地改动,已中止」**:说明有人手动改了 `plugins/` 或 `flavors/` 里的文件。删掉该目录重跑,或 `ya pkg install --discard` 丢弃本地改动。
- **主题不生效**:确认 `flavors/gruvbox-dark.yazi/` 存在(`ya pkg install`),且 `theme.toml` 里 `dark = "gruvbox-dark"`。

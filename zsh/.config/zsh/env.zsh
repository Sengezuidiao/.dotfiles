# 环境变量

# PATH
export PATH=$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export LOCALBIN=$XDG_CONFIG_HOME/bin
export PATH=$PATH:$LOCALBIN

# Homebrew：登录 shell 已在 .zprofile 初始化，这里兜底非登录 shell
export HOMEBREW_DOWNLOAD_CONCURRENCY=auto
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

# 默认编辑器
export EDITOR=nvim

# 终端输出中文
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# clash 代理（常开）
export all_proxy=http://127.0.0.1:7890

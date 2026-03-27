export PATH=$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export LOCALBIN=$XDG_CONFIG_HOME/bin
export PATH=$PATH:$LOCALBIN
export PATH=$PATH:/usr/local/bin

# homebrew
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/sbin
export PATH=$PATH:$HOME/.linuxbrew/bin
export PATH=$PATH:$HOME/.linuxbrew/sbin
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:/opt/homebrew/sbin
export HOMEBREW_DOWNLOAD_CONCURRENCY=auto
# --- Homebrew 自动初始化 (macOS + Linux 通用) ---
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi
# --- End Homebrew 初始化 ---

# yazi
export EDITOR=nvim

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


# 终端输出中文
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# clash 代理
export all_proxy=http://127.0.0.1:7890

export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# fzf config
FZF_CONFIG="$HOME/.config/zsh/fzf.zsh"
# 如果配置文件不存在就生成
if [ ! -f "$FZF_CONFIG" ]; then
    fzf --zsh > "$FZF_CONFIG"
fi
# 加载配置
source "$FZF_CONFIG"

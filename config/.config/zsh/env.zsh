export PATH=$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export LOCALBIN=$XDG_CONFIG_HOME/bin
export PATH=$PATH:$LOCALBIN
export PATH=$PATH:/usr/local/bin

# homebrew
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
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export all_proxy=socks5://127.0.0.1:7890

export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

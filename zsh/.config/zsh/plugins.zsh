# 插件引导：第三方工具（fzf、zsh-autosuggestions）的初始化配置

# zsh-autosuggestions（zim 模块）：异步渲染 + 手动重绑定（避免与 vi 键位冲突）
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# fzf 集成：key bindings + completion 由 fzf --zsh 生成的单一文件统一提供
FZF_CONFIG="$HOME/.config/zsh/fzf.zsh"
# 文件不存在则生成（首次启动需已安装 fzf）
if [ ! -f "$FZF_CONFIG" ]; then
    fzf --zsh > "$FZF_CONFIG"
fi
source "$FZF_CONFIG"

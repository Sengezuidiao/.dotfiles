# 绑定 Ctrl+V 快捷键为 edit-command-line，这个功能会用你默认的编辑器（比如 vim 或 nano）打开当前命令行进行编辑
bindkey '^v' edit-command-line
# viins 下完全模拟 Emacs 行为
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^Y' yank
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line



# 启用 vi 模式（Zsh 默认是 Emacs 模式）。vi 模式包含两种 keymap：viins（插入模式）和 vicmd（普通命令模式）
bindkey -v
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
	echo -ne '\e[5 q'
}

_fix_cursor() {
	echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

KEYTIMEOUT=1

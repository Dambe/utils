# vim:ft=zsh ts=4 sw=2 sts=2

# Must use Powerline font, for \uxxxx to render.
# color codes: bash 256 colors
# https://superuser.com/questions/1425184/remote-zsh-doesnt-print-in-256-color-though-terminal-can-print
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
# %F{8} = dark grey
# %F{9} = redish
# %F{10} = greenish
# %F{11} = yellowish
ZSH_THEME_GIT_PROMPT_PREFIX="%{%F{69}%}\ue725 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{%F{202}%} \u2301"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{%F{green}%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg_bold[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

PROMPT='
%{%F{blue}%}%{%F{34}%} %~ $(git_prompt_info)$(virtualenv_prompt_info)
%{%F{blue}%}%{%F{227}%}❭ %{$reset_color%}'

RPROMPT='$(ruby_prompt_info)'

VIRTUAL_ENV_DISABLE_PROMPT=0
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX=" %{%F{green}%}🐍"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX


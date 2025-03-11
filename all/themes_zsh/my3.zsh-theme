# af-magic.zsh-theme
#
# Author: Andy Fleming
# URL: http://andyfleming.com/

# dashed separator size
function afmagic_dashes {
  # check either virtualenv or condaenv variables
  local python_env_dir="${VIRTUAL_ENV:-$CONDA_DEFAULT_ENV}"
  local python_env="${python_env_dir##*/}"

  # if there is a python virtual environment and it is displayed in
  # the prompt, account for it when returning the number of dashes
  if [[ -n "$python_env" && "$PS1" = *\(${python_env}\)* ]]; then
    echo $(( COLUMNS - ${#python_env} - 3 ))
  else
    echo $COLUMNS
  fi
}

# primary prompt: dashed separator, directory and vcs info
PS1="${FG[237]}\${(l.\$(afmagic_dashes)..-.)}%{$reset_color%}
${FG[2]}%~\$(git_prompt_info) \$(hg_prompt_info)${FG[2]}%(!.#.)%{$reset_color%}"
#emoji:  󱙳
PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: return code, virtualenv and context (user@host)
RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi
RPS1+=" ${FG[237]}%\%\%{$reset_color%}" #n@m

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[075]}(${FG[078]}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${FG[075]})%{$reset_color%}"


ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"


# format for git_prompt_long_sha() and git_prompt_short_sha()
zsh_theme_git_prompt_sha_before="➤ %{$fg_bold[yellow]%}"
zsh_theme_git_prompt_sha_after="%{$reset_color%}"



# hg settings
ZSH_THEME_HG_PROMPT_PREFIX=" ${FG[075]}(${FG[078]}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="${FG[075]})%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" ${FG[075]}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"







function git_time_since_commit() {
    local COLOR MINUTES HOURS DAYS SUB_HOURS SUB_MINUTES
    local last_commit seconds_since_last_commit

    # Only proceed if there is actually a commit
    if ! last_commit=$(command git -c log.showSignature=false log --pretty=format:'%at' -1 2>/dev/null); then
        echo "$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL @debian%{$reset_color%}"
        return
    fi

    # Totals
    seconds_since_last_commit=$(( EPOCHSECONDS - last_commit ))
    MINUTES=$(( seconds_since_last_commit / 60 ))
    HOURS=$(( MINUTES / 60 ))

    # Sub-hours and sub-minutes
    DAYS=$(( HOURS / 24 ))
    SUB_HOURS=$(( HOURS % 24 ))
    SUB_MINUTES=$(( MINUTES % 60 ))

    if [[ -z "$(command git status -s 2>/dev/null)" ]]; then
        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
    else
        if [[ "$MINUTES" -gt 30 ]]; then
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
        elif [[ "$MINUTES" -gt 10 ]]; then
            COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
        fi
    fi

    if [[ "$HOURS" -gt 24 ]]; then
        echo "[${COLOR}${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}]"
    elif [[ "$MINUTES" -gt 60 ]]; then
        echo "[${COLOR}${HOURS}h${SUB_MINUTES}m%{$reset_color%}]"
    else
        echo "[${COLOR}${MINUTES}m%{$reset_color%}]"
    fi
}

RPROMPT='${return_status}$(git_time_since_commit)$(git_prompt_status)%{$reset_color%}'

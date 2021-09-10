# Based on gnzh theme
# List of unicode symbols: https://unicode-table.com/en/blocks/dingbats/

setopt prompt_subst  #replace variables at every iteration

# Adds dynamic check of git status
add-zsh-hook precmd prompt_set

prompt_set () {

  local prompt_user prompt_host prompt_end

  # Check the UID
  if [[ $UID -ne 0 ]]; then # normal user
    prompt_user='%F{green}%n%f'
    prompt_end='➤'
  else # root
    prompt_user='%F{red}%n%f'
    prompt_end='%F{red}➤%f'
  fi

  # Check if we are on SSH or not
  local current_time="%B[%b%T%B]%b"
  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    prompt_host="%F{red}$(hostname -s)%f" # SSH
    local user_host_time="${current_time} ${prompt_user}%F{cyan}@${prompt_host}"
  else
    local user_host_time="${current_time}"
  fi

  local current_dir="%B%F{blue}%30<…<%~%<<%f%b"

  local git_info
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    git_info=" %20>…>$(git_prompt_info)%>>"
  else
    git_info=""
  fi

  local conda_env
  if [ -n "${CONDA_DEFAULT_ENV}" ]; then
    conda_env=" %F{172}❮%20>…>${CONDA_DEFAULT_ENV}%>>❯%f"
  else
    conda_env=""
  fi

  PROMPT="╭─${user_host_time} ${current_dir}${git_info}${conda_env}
╰─${prompt_end} "

}

RPROMPT="%(?..%F{red}%? ↵%f)"  #return code
ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{yellow}%b"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"

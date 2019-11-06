# Based on gnzh theme
# List of unicode symbols: https://unicode-table.com/en/blocks/dingbats/

setopt prompt_subst  #replace variables at every iteration

# Adds dynamic check of git status
add-zsh-hook precmd prompt_set

prompt_set () {

  local PR_USER PR_USER_OP PR_PROMPT PR_HOST

  # Check the UID
  if [[ $UID -ne 0 ]]; then # normal user
    PR_USER='%F{green}%n%f'
    PR_USER_OP='%F{green}%#%f'
    PR_PROMPT='%f➤ %f'
  else # root
    PR_USER='%F{red}%n%f'
    PR_USER_OP='%F{red}%#%f'
    PR_PROMPT='%F{red}➤ %f'
  fi

  # Check if we are on SSH or not
  local current_time="%B[%b%T%B]%b"
  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    PR_HOST='%F{red}%M%f' # SSH
    local user_host_time="${current_time} ${PR_USER}%F{cyan}@${PR_HOST}"
  else
    local user_host_time="${current_time}"
  fi

  local current_dir="%B%F{blue}%30<…<%~%<<%f%b"

  # define how the prompt will look like
  PROMPT="${user_host_time} ${current_dir}"

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
╰─${PR_PROMPT} "

}

# Sets what gets preserved
RPROMPT="%(?..%F{red}%? ↵%f)"  #return code
ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{yellow}%b"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"

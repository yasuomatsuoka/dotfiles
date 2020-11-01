alias gs "git status"
function docker-login -d "login docker"
  docker exec -it $argv[1] bash -c "su - $argv[2]"
end

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# fzf
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

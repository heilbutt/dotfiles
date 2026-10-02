# Homebrew completions (Apple Silicon prefix hardcoded to avoid spawning `brew`)
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
	fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit

# Rebuild the dump at most once a day, otherwise use the cached one (faster startup)
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
	compinit
else
	compinit -C
fi

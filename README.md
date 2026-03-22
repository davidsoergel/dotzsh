dotzsh
======

_My ZSH configuration_

Lorax zsh config files
----------------------

.zshrc files should generally go in .zsh, which is in git.  The home dir should contain only the stub .zshenv (see .zshenv.home) to set $ZDOTDIR, .zshrc.local, and .zshenv.local.

I originally had separate branches for different machines, in order to store the .zshrc.local files too.  This turned out to be too much hassle, so never mind that.

The order of loading is:

 * .zshenv
 * .zprofile (login shells)
 * .zshrc
 * .zlogin (login shells)

Tmux
----

The *.tmux files support tmux operation with ssh-agent propagation.  To activate these, call them from .zshrc.local and .zlogin.local on the tmux host.

Tmux subshells are started as interactive non-login shells.

So the upshot is:

### Elysium (local laptop)

 * .zshenv
 * .zshenv.local
 * .zprofile
 * .zprofile.local
 * .zshrc
 * .zshrc.local
 * .zlogin
 * .zlogin.local

### Lorax (tmux host)

 * .zshenv
 * .zshenv.local
 * .zprofile
 * .zprofile.local -> .zprofile.tmux
 * .zshrc
 * .zshrc.local -> .zshrc.tmux
 * .zlogin
 * .zlogin.local -> .zlogin.tmux


### Lorax (tmux subshell)

 * .zshenv
 * .zshenv.local
 * .zshrc
 * .zshrc.local -> .zshrc.tmux


Homebrew
--------

Homebrew is initialized in `.zshenv` so it's available in all shell types (interactive, non-interactive, scripts). The init block handles three locations in order:

 * `/opt/homebrew` — Apple Silicon Mac
 * `/usr/local` — Intel Mac
 * `/home/linuxbrew/.linuxbrew` — Linux

On macOS, zsh plugins (`zsh-syntax-highlighting`, `zsh-history-substring-search`) and tools (`fnm`, `zoxide`) are expected to be installed via Homebrew. `zshrc/handy` and `zshrc/fnm` guard their setup with `$+commands[brew]` / `$+commands[fnm]` / `$+commands[zoxide]` so the config degrades gracefully on machines where they aren't present.

On Linux without Homebrew, those plugins won't load. To enable them, install via your distro's package manager and source the plugin files from `.zshrc.local` on that machine.


SSH files
---------

ssh files can be linked from the active locations, or just used as prototypes and copied if there are local differences.




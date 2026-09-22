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

Homebrew's `shellenv` is applied by `brew-shellenv`, which is sourced **twice**, by design:

 * from `.zshenv`, so the prefix is on `PATH` in every shell type (interactive, non-interactive, scripts);
 * again from `.zprofile`, because on macOS `/etc/zprofile` runs `path_helper` *after* `.zshenv`. That rebuilds `PATH` from `/etc/paths` and `/etc/paths.d`, demoting the Homebrew prefix behind `/usr/bin`. `.zprofile` runs after `/etc/zprofile`, so re-asserting there wins.

Without the second pass, brew-installed tools silently lose to the system ones — on this setup `openssl` was resolving to `/usr/bin/openssl`, which is LibreSSL, not Homebrew's OpenSSL 3.

Sourcing it twice needs a dedupe, and `typeset -U path` does **not** provide one here: `brew shellenv` assigns to the scalar `PATH`, while zsh enforces `-U` only on assignment to the tied array `path`. `brew-shellenv` therefore re-assigns the array after the eval, which collapses the stale entry and keeps the newly prepended one.

The prefix is auto-detected, in order:

 * `/opt/homebrew` — Apple Silicon Mac
 * `/usr/local` — Intel Mac
 * `/home/linuxbrew/.linuxbrew` — Linux

On macOS, zsh plugins (`zsh-syntax-highlighting`, `zsh-history-substring-search`) and tools (`fnm`, `zoxide`) are expected to be installed via Homebrew — run `install-dependencies.sh` on a new machine. `zshrc/fnm` and `zshrc/handy` guard the *tools* on `$+commands[fnm]` / `$+commands[zoxide]`, and the two *plugins* on whether their files are readable.

That distinction matters: `$+commands[brew]` only says Homebrew exists, not that these formulae are installed. Guarding the plugins on `brew` alone meant that on a machine with Homebrew but without them, `source` aborted with "no such file or directory" (exit 127) — which is exactly what happened here when the Homebrew prefix moved from `/usr/local` to `/opt/homebrew` and the plugins were left behind.

On Linux without Homebrew, those plugins won't load. To enable them, install via your distro's package manager and source the plugin files from `.zshrc.local` on that machine.


SSH files
---------

ssh files can be linked from the active locations, or just used as prototypes and copied if there are local differences.




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


SSH files
---------

ssh files can be linked from the active locations, or just used as prototypes and copied if there are local differences.




# functions are in ~/loraxhome
# (or ~/loraxhome-edit for testing)

fpath=($ZDOTDIR $fpath)

# Window Titles
setupWindowTitles() {
	#print -Pn "\e]0;%n@%m: %~\a"
	print -Pn "\e]0;(%m: %~)\a"
	t() { DSTASK="$*" ; print -Pn "\e]0;$DSTASK (%m: %~)\a" } 
        chpwd() {print -Pn "\e]0;$DSTASK (%m: %~)\a"}
}
case $TERM in
    xterm*) setupWindowTitles ;;
    linux) setupWindowTitles ;;
esac

# Calculator
calc(){ awk "BEGIN{ print $* }" ;}


# Command Aliases
#alias vi=vim
alias ls-al='ls -alh'
alias la='ls -alh'
alias h='history'
alias mkdir='nocorrect mkdir'

#alias fixssh='source $HOME/bin/fixssh'

# Global aliases
alias -g L='| less'

lessc() {
# http://unix.stackexchange.com/questions/29023/how-to-display-tsv-csv-in-console-when-empty-cells-are-missed-by-column-t
sed ':x s/\(^\|\t\)\t/\1 \t/; t x' < $1 | column -t -s $'\t' | less
}

# SSH Aliases
alias lorax='ssh lorax; chpwd'
alias blake='ssh blake; chpwd'
alias emerge='ssh emerge; chpwd'
alias dev='ssh dev.davidsoergel.com; chpwd'
alias loraxroot='ssh root@lorax.org; chpwd'
alias devroot='ssh root@dev.davidsoergel.com; chpwd'

# Setup History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zshhistory


# Variables used by zsh
LISTMAX=1000  # "Never" ask
LOGCHECK=60
WATCHFMT="[%B%t%b] %B%n%b has %a %B%l%b from %B%M%b"
TMOUT=0
MAILCHECK=0


# Prompts
#autoload -U promptinit
#promptinit
#prompt adam1
autoload loraxprompt
loraxprompt
#source ~/loraxhome-edit/adam1-vcsinfo


# Completions
autoload -U compinit
compinit -C # don't perform security check

# Fink
if [[ -x /sw/bin/init.sh ]]; then
	source  /sw/bin/init.sh   
fi

# Options
setopt                       \
     NO_all_export           \
        always_last_prompt   \
     NO_always_to_end          \
        append_history         \
        auto_cd                \
        auto_list              \
        auto_menu              \
     NO_auto_name_dirs         \
        auto_param_keys        \
        auto_param_slash       \
        auto_pushd             \
        auto_remove_slash      \
     NO_auto_resume            \
        bad_pattern            \
        bang_hist              \
     NO_beep                   \
     NO_brace_ccl              \
        correct_all            \
     NO_bsd_echo               \
        cdable_vars            \
     NO_chase_links            \
     NO_clobber                \
        complete_aliases       \
        complete_in_word       \
     NO_correct                \
        correct_all            \
     NO_csh_junkie_history     \
     NO_csh_junkie_loops       \
     NO_csh_junkie_quotes      \
     NO_csh_null_glob          \
        equals                 \
        extended_glob          \
        extended_history       \
        function_argzero       \
        glob                   \
     NO_glob_assign            \
        glob_complete          \
     NO_glob_dots              \
     NO_glob_subst             \
        hash_cmds              \
        hash_dirs              \
        hash_list_all          \
        hist_allow_clobber     \
        hist_beep              \
        hist_ignore_dups       \
        hist_ignore_space      \
     NO_hist_no_store          \
        hist_verify            \
        hist_expire_dups_first \
     NO_hist_ignore_all_dups   \
        hist_no_functions      \
     NO_hist_save_no_dups      \
        hist_reduce_blanks     \
     NO_ignore_braces          \
     NO_ignore_eof             \
        inc_append_history     \
        interactive_comments   \
     NO_ksh_glob               \
     NO_list_ambiguous         \
     NO_list_beep              \
        list_packed            \
        list_types             \
        long_list_jobs         \
        magic_equal_subst      \
     NO_mail_warning           \
     NO_mark_dirs              \
     NO_menu_complete          \
        multios                \
        nohup                  \
        nomatch                \
        notify                 \
     NO_null_glob              \
        numeric_glob_sort      \
     NO_overstrike             \
        path_dirs              \
        posix_builtins         \
     NO_print_exit_value       \
        prompt_cr              \
        prompt_subst           \
        pushd_ignore_dups      \
     NO_pushd_minus            \
        pushd_silent           \
        pushd_to_home          \
        rc_expand_param        \
     NO_rc_quotes              \
     NO_rm_star_silent         \
     NO_rm_star_wait           \
        share_history          \
     NO_sh_file_expansion      \
        sh_option_letters      \
        short_loops            \
        sh_word_split          \
     NO_single_line_zle        \
     NO_sun_keyboard_hack      \
        unset                  \
     NO_verbose                \
        zle                  
        
        
# reverse unwanted aliasing of `which' by distribution startup
# files (e.g. /etc/profile.d/which*.sh); zsh's 'which' is perfectly
# good as is.

alias which >&/dev/null && unalias which

# run-help

alias run-help >&/dev/null && unalias run-help
autoload run-help

# zwget from http://www.zsh.org/mla/users/2011/msg00742.html
zwget() {
    emulate -LR zsh
    local scheme empty server resource fd headerline
    IFS=/ read scheme empty server resource <<<$1
    case $scheme in
    (https:) print -u2 SSL unsupported, falling back on HTTP ;&
    (http:)
        zmodload zsh/net/tcp
        ztcp $server 80 && fd=$REPLY || return 1;;
    (*) print -u2 $scheme unsupported; return 1;;
    esac
    print -l -u$fd -- \
        "GET /$resource HTTP/1.0"$'\015' \
        "Host: $server"$'\015' \
        'Connection: close'$'\015' $'\015'
    while IFS= read -u $fd -r headerline
    do
	[[ $headerline == $'\015' ]] && break
    done
    while IFS= read -u $fd -r -e; do :; done
    ztcp -c $fd
}

function laststatus { return $? }

#http://www.zsh.org/mla/users/2008/msg01153.html
urlencode() {
    setopt localoptions extendedglob
    input=( ${(s::)1} )
    print ${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-])/%${(l:2::0:)$(([##16]#match))}}
}

# previously I set this in .zshrc.local, presumably because I thought this repo might be public.  But it isn't, right?  And automatically propagating it is much more convenient.
export PROWLKEY=1dc0ee00c8b90e021ec55eeb20bbb7e8e824606f

prowl() {
    if laststatus; then result=OK; else result=ERROR; fi
    description=`tail -10 <&0`
    descriptionu=`urlencode "$description"`
    host=`hostname`
    zwget "http://prowlapp.com/publicapi/add?apikey=$PROWLKEY&application=$host&event=$1%20%3A%20$result&description=$descriptionu&priority=$2"
}

alias fixssh='source ~/.zsh/updatessh'
alias sshinfo='source ~/.zsh/sshinfo'

echo ------------------ SSH Keys ------------------- 
ssh-add -l
echo

# local customizations
source ~/.zshrc.local


echo -----------------------------------------------
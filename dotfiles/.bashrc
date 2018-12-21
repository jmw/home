set -o vi

# Sanity
alias vi='vim'
alias cls='clear'

alias duk='du -k | sort -rn | less'
alias duh='du -h'
alias findbroken='find . -type f -name ".*sw*"'
alias la='ls -al'
alias lac='ls -al | wc -l'
alias ldir='ls -al | egrep "^d"'
alias lah='ls -a | egrep "^\."'
alias lahc='ls -a | egrep "^\." | wc -l'
alias lar='ls -altr'
alias lat='ls -alt'
alias ll='ls -l'
alias lr='ls -ltr'
alias lsn='ls -al | nms -a'
alias lss='ls -althrS'
alias skyron='ssh -p 1100 joe@skyron.ddns.net'

# Employer/project-specific aliases
alias code='cd ~/code'
alias amops='aws-mfa --profile=rally-ops'
alias amdev='aws-mfa --profile=rally-dev'
alias amprod='aws-mfa --profile=rally-prod'
alias py3='source ~/.virtualenv/py3/bin/activate'

# emacs aliases
alias e='emacsclient -c -n'
alias kmacs='emacsclient -e "(kill-emacs)"'
alias dmacs='emacs --daemon'

# current dttm:
alias now='date "+%Y-%m-%d %H:%M:%S"'

# current dttm:
alias etime='date "+%s"'

# 
alias cdp='pushd'

# detailed ls (ls + which)
lsw()
{
  which $1 2>&1 >/dev/null
  if [[ $? == 0 ]]
  then
    ls -al $(which -a $1)
  fi
}

# read first 2 lines of (pipe-delimited) $1 and pipe them into vim, splitting each row into a separate window, one field per line
ccc()
{
  head -2 $1 | vim -c ":call SplitPipeSplit()" -
}

# Remove backslashes, pipe-dquotes, and dquote-pipes from $1
nobs()
{
    echo "Removing BS from $1..."
    cat $1 | sed 's/|"/|/g' | sed 's/"|/|/g' | sed 's/^"//' | sed 's/"$//' | sed 's/| */|/g' >no_bs_$1
    echo "...done.  Output file is no_bs_$1"
}

# Run dos2unix, iconv, and remove backslashes, pipe-dquotes, and dquote-pipes from $1
cleanup()
{
    if [[ -e $1 ]]
    then
        echo "Cleaning up $1..."
        dos2unix $1
        iconv -f ISO-8859-1 -t UTF-8 $1 | sed 's/|"/|/g' | sed 's/"|/|/g' | sed 's/^"//' | sed 's/"$//' | sed 's/| */|/g' > $1.cleaned
        echo "...finished cleaning up $1.  Output file is $1.cleaned."
    fi
}

# make/change dir: cd to $1; mkdir first if it doesn't exist
mcd()
{
    if [[ -d $1 ]]
    then
        cd $1
    else
        mkdir -p $1
        cd $1
    fi
}

# OS X: pipe command output to system clipboard
ccp()
{
    if [[ -p /dev/stdin ]] ; then
        # stdin is a pipe
        # stdin -> clipboard
        pbcopy
    else
        # stdin is not a pipe
        # clipboard -> stdout
        pbpaste
    fi
}

alias cpwd='pwd | ccp'
alias cdc='cd `ccp`'

# Pipe the first line of $1 into vim
fl()
{
    head -1 $1 | vim -
}

# Pipe the first 25 or $2 lines of $1 into vim
#vhead()
#{
#    head -25 $1 | vim -
#}
vhead()
{
    count=16
    if [[ $# -eq 2 ]]
    then
        count=$2
    fi
    cmd=`printf "head -%d $1" $count`
    $cmd | vim -
}

f2p()
{
    if [[ -f $1 ]] ; then
        echo "copying $1 to clipboard"
        cat $1 | pbcopy
    else
        echo "file $1 doesn't exist"
    fi
}

mtdir()
{
    ticketname=$@
    ticketdir="${ticketname// /_}"
    echo "Name: |$ticketdir|"
    if [[ -d ~/$ticketdir ]]
    then
        echo "$ticketdir already exists"
    else
        mkdir -p ~/$ticketdir
        echo "Successfully created ~/$ticketdir"
    fi
}

# jj: keep cheatsheets as man-like pages instead of raw text files
mdless() {
      pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

jjedit() { vim ~/.notes/$1; }

jj() { mdless ~/.notes/"$1"; }

jjls() { ls ~/.notes; }


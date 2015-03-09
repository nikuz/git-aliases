GIt Aliases
===========

Custom Git aliases manager. Included some common aliases (see below). 

Getting:
```
git clone https://github.com/nikuz/git-aliases.git
```

Install
-------
```
./install.sh
Your original /home/username/.bash_profile has been backed up to /home/username/.bash_profile.bak

aliasName
aliasDescription
Install it? y
```

Installation proceeds interactively. Will ask you for each included alias to install it. You can say `./install.sh -q` for quiet mode. In quiet mode will be installed all included aliases, and shown statistics after install is complete.

You can install only needed alias by name:
```
./install.sh co ci br
```

Also in quiet mode:
```
./install.sh -q co ci br
```

Aliases will installed `--global` in git config. Also will be created bash_profile aliases with ```g``` prefix. 
```
alias gbr='git br'
alias gci='git ci'
```

You need update profile environment, for start using it.
```
. /home/username/.bash_profile
```

All installed aliases and modules will stored in `/home/username/.git_aliases/` folder. You can edit them there after installing for change them functionality.

Delete
-------
By name:
```
./delete.sh co ci br
```

All in quiet mode:
```
./delete.sh -q -all
```

Will delete file from `/home/username/.git_aliases/`, git alias from `--global` git config, alias from `.bash_profile`.

Create new one
-------
```
./create.sh
```

Will ask you some question:
```
Alias name: ***
Short description: ***
It's background module? y/n
It's "before push" module? y/n
New alias placed here:
.git_aliases/newAlias.sh

Do you want edit it now? y/n
Do you want install it now? y/n
```

In this way will create new alias, which you need edit and install after creating.

Included aliases and modules
-------
This alias manager supplied with some default aliases and modules.

Modules:
* `_clean.sh` - check that "working directory clean"
* `_config` - some common variables
* `_help` - for showing aliases help by `aliasName -h`
* `_printColor` - for print colored terminal log
* `_printMultiline` - for print functions answers in multiline mode
* `_question` - for getting answers from user
* `_beforePush` - will run modules that registered as `beforePushModules` in `_config` before commit and push local changes to remote origin. If `beforePush` module return `False`, commit and push will rejected.
* `__grunt` - this is one of `beforePushModules`. Will run grunt tasks, if `Gruntfile.js` is present in working directory and tasks registered through `grunt.registerTask`

Below presented aliases. Format of them presentation must not be changed. It required for `_help` module.

### Aliases

git aliases - galiases<br>
usage: galiases<br>
Show list of installed aliases

### Br

git br - gbr<br>
usage: gbr branchName_issueNumber<br>
Will create new branch from actual master and goes into new branch. `issueNumber` is required. Will ask if not defined.

### Ci

git ci - gci<br>
usage: gci [comment]<br>
Will run `beforePushModules`. If success passed, will `git add .`, `git commit -m "comment #issueNumber"`.
If comment don't defined, comment will be is the "fix" string.

### Co

git co - gco<br>
usage: gco<br>
Git pull current branch from remote origin to local. And print `git status`

### Go

git go - ggo<br>
usage: goo branch_name<br>
Goes to branch_name if it exists.

### List

git list - glist<br>
usage: glist [revision_hash]<br>
Print list of committed files from last commit or from defined commit.

### Ph

git ph - gph<br>
usage: gph [branch_name]<br>
Will run `beforePushModules`. If success passed, will `git push origin branch_name:branch_name`.
If branch_name don't defined, will push current branch.

### Pl

git pl - gpl<br>
usage: gpl [branch_name]<br>
`git pull origin branch_name:branch_name`. If branch_name don't defined, will pull current branch.

### St

git st - gst<br>
usage: gst [<options>...] [--] [<pathspec>...]<br>
Git status

### I

git i - gi<br>
usage: gi<br>
Git branch

### Rmc

git rmc - grmc<br>
usage: grmc<br>
rm -rf conflicted files

### Rmb

git rmb - grmb<br>
usage: grmb [branches]<br>
Delete defined branches, or all branches exclude master and current branch.

### Inmaster

git inmaster - ginmaster<br>
usage: ginmaster<br>
Merge current branch with master and push master to origin.

### Fth

git fth - gfth<br>
usage: gfth [branchName]<br>
Git fetch remote branch to local repository and checkout to new branch

### Clear

git clear - gclear<br>
usage: gclear [files]<br>
Clear unstaged changes. If files don't defined, will clear all unstaged changes.

### Sth

git sth - gsth<br>
usage: gsth [command]<br>
Git stash. Will run `git add .` before stash.

### Df

git df - gdf<br>
usage: gdf [<options>...] [--] [<pathspec>...]<br>
Git diff

### Rs

git rs - grs<br>
usage: grs<br>
Remove last commit from log, files stay modified.

### L

git l - gl<br>
usage: gl<br>
git log --graph

### Delete

./delete.sh (aliasName | -all) <br>
Delete aliases by name. Can take many aliases by one time.<br>
For delete all aliases. Need request --all

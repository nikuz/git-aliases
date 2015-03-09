GIt Aliases
===========

Aliases
-------
aliases description

- - -
Br
--

ci branchName_issueNumber<br>
Will create new branch from actual master and goes into new branch.
issueNumber is required. Will ask if not defined.

- - -
Ci
--

ci description<br>
multiline 1<br>

multiline 2<br>

- - -
Co
--

Git pull current branch

- - -
Go
--

Git checkout

- - -
List
----

list [ revision_hash ]<br>
Print list of files from last commit or from defined commit.

- - -
Ph
--

Git push alias

- - -
Pl
--

Git pull alias

- - -
St
--

st [<options>...] [--] [<pathspec>...]
Git status
- - -
I
--

Git branch
- - -
Rmc
--

rm -rf conflicted files
- - -
Rmb
--

rmb [branches]<br>
Delete defined branches, or all branches exclude master and current branch.
- - -
Inmaster
--

Merge current branch with master and push master to origin.
- - -
Fetch
--

fetch [branchName]
Git fetch remote branch to local repository and checkout to new branch
- - -
Clear
--

clear [files]
Clear unstaged changes
- - -
Sth
--

sth [command]
Git stash
- - -
Df
--

df [<options>...] [--] [<pathspec>...]
Git diff
- - -
Rs
--

git reset --soft HEAD^<br>
Git reset last commit

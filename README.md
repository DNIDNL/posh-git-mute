posh-git-mute
=============


Just some aliases thrown in for "muting" files in git easier,

instead of 

git update-index --assume-unchanged [filename]

You just do 

git-mute-on [filename]

when you want to mute a file

and 

git-mute-off [filename]

for "unmuting"

git-mute-list does a ls-files and shows all files that are currently muted

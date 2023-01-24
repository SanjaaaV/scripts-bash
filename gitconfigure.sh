#!/bin/bash
#Script asks user (interactively) for username, email, editor, alias to add... In order to configure Git.
echo "Your username for git account?"
read userNamegit
git config --global user.name $userNamegit
echo "Your email for git account?"
read userEmailgit
git config --global user.email $userEmailgit
echo "Which editor you want to use?"
read userEditorgit
git config --global core.editor $userEditorgit
echo "Would you like to create alias?y/n"
read YNAlias
while [ "$YNAlias" = y ]
do
        echo "Type git-command:"
        read gitCommand
        echo "Type git-alias:"
        read gitAlias
        git config --global alias.$gitAlias $gitCommand
        echo "Would you like to create alias?y/n"
        read YNAlias
done
exit

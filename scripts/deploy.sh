#!/bin/bash
__CALL__=$1 

function __profiler__ {
   echo ""
   echo -e " \e[42;1m ------- TRAVIS -------"
   echo "token: $__TOKEN_GITHUB__"
   echo "arg: $__PREVIEW__" 
   echo "arg: $__BODY_OK__"
   echo "arg: $__BODY_KO__"
   echo "arg: $__ORG_DEPLOY__"
   echo "arg: $__REPO_DEPLOY__"
   echo "arg: $__JSON__"
   echo "arg: $__ORG_TARGET_IT_RECT__"
   echo "branch: $TRAVIS_BRANCH"
   echo "arg: $__CALL__"
   echo " -------     -------"
   
   echo "" 

   echo -e " \e[42;1m ------- SSH -------"
   eval "$(ssh-agent -s)"
   echo " -------     -------"
}

function __execute__ {
   if [ "$TRAVIS_BRANCH" = "master" ] || [ "$TRAVIS_BRANCH" = "main" ] ; then
     
     #curl -i -H "$__PREVIEW__" -H "$__JSON__" -H "Authorization: token $__TOKEN_GITHUB__" -d "$__BODY_OK__" https://api.github.com/repos/gh-un-it-rect/$__REPO_DEPLOY__
     
     echo -e " \e[42;1m ------- GIT -------"
     
     git config --global user.name $__USER_NAME__
     git config --global user.email $__USER_EMAIL__
     
     git clone https://$__TOKEN_GITHUB__@github.com/$__ORG_DEPLOY__/$__REPO_DEPLOY__.git
     git pull
      
     cd $__REPO_DEPLOY__/scripts/
     chmod +x deploy.sh
     sh deploy.sh $__CALL__
     
     #curl -i -H "$__PREVIEW__" -H "$__JSON__" -H "Authorization: token $__TOKEN_GITHUB__" -d "$__BODY_KO__" https://api.github.com/repos/$__ORG_DEPLOY__/$__REPO_DEPLOY__
      
     quit 0
     
   else
     echo -e "\e[31mPor favor recuerde que solo pueden deployar en rama Master o Main\e[0m"
     echo -e "\e[31mhttps://github.com/gh-un-it-rect/000-deploy/settings/branches\e[0m"
     quit 1
   fi
}

function quit {
   echo "exit "$1
   exit $1
}

function __main__ {
  __profiler__
  __execute__
}

__main__

#!/bin/bash
# -*- ENCODING: UTF-8 -*-


read -p "Projects folder name(ENTER default): " PROJECTS
read -p "Homestead folder name(ENTER default): " HOMESTEAD
read -p "IP virtualBox(ENTER default): " IPVIRTUALBOX
read -p "Name Virtual hosts(ENTER default): " NAMEVIRTUALHOST

while true 
do
     read -p "You have your ssh key(Y/N)?: " BOOLSSH
     if [ "$BOOLSSH" == "N" ]; then
        ssh-keygen -t rsa 
       break
     fi
     if [ "$BOOLSSH" == "Y" ]; then

       break
     fi

done

if [[ -z "$PROJECTS" ]]; then
   PROJECTS='projects'
fi

if [[ -z "$HOMESTEAD" ]]; then
   HOMESTEAD='Homestead'
fi

if [[ -z "$IPVIRTUALBOX" ]]; then
   IPVIRTUALBOX='192.168.10.10'
fi

if [[ -z "$NAMEVIRTUALHOST" ]]; then
   NAMEVIRTUALHOST='dev.template'
fi

mkdir  $HOME/$PROJECTS
echo "DocumentRoot created!"

git clone https://github.com/elNapoli/Homestead.git $HOME/$PROJECTS/$HOMESTEAD



sed -i 's/projects/'$PROJECTS'/g' $HOME/$PROJECTS/$HOMESTEAD/'homestead_init/Homestead.yaml' 

sed -i 's/192.168.10.10/'$IPVIRTUALBOX'/g' $HOME/$PROJECTS/$HOMESTEAD/'homestead_init/Homestead.yaml'

sed -i 's/dev.template/'$NAMEVIRTUALHOST'/g' $HOME/$PROJECTS/$HOMESTEAD/'homestead_init/Homestead.yaml'

sed -i 's/projects/'$PROJECTS'/g' $HOME/$PROJECTS/$HOMESTEAD/'homestead_init/after.sh'

git clone https://github.com/elNapoli/template.git $HOME/$PROJECTS'/template'

cd $HOME/$PROJECTS/$HOMESTEAD
vagrant up
echo '####################################################################################################################'
echo '### documentRoot    : '$HOME/$PROJECTS/'                                                                           #'
echo '### ipVirtualHost   : '$IPVIRTUALBOX'                                                                              #'
echo '### nameVirtualHost : '$NAMEVIRTUALHOST'                                                                           #'
echo '####################################################################################################################'
echo 'No olvides escribir "'$IPVIRTUALBOX' '$NAMEVIRTUALHOST'" en tu /etc/hosts'

exit


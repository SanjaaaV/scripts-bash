#!/bin/bash
#Script removes exited containers, unused images and unused volumes-Docker.
option1=$1
option2=$2
if [ "$option1" = '-h' ] || [ "$option1" = "" ]; then
        echo "
        Help:

        Remove exited containers (-c)

        Remove unused images (-i)

        Remove unused volumes (-v)

        Remove all above (-all)

        Type '-dry-run' as second argument to see explanation for option.
 ______________________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
Unused images:
        $(sudo docker images -f dangling=true)
Unused volumes:
        $(sudo docker volume ls --filter 'dangling=true')"
fi


#Containers
if [ "$option1" = '-c' ] && [ "$option2" = "" ];then
        echo "This option will remove all exited containers.

__________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
_________________________________________________
         Are you sure you want to continue?y/n"

        read econ
        if [ "$econ" = y ];then
         sudo docker rm $(sudo docker ps -q -f status=exited)
        echo "
__________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
_________________________________________________"

        elif [ "$econ" = n ];then
        exit
        fi

fi
if [ "$option1" = '-c' ] && [ "$option2" = '-dry-run' ];then
        echo "This option removes all exited containers.
_________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
_________________________________________________
         You want to proceed?y/n"
         read proceedEC
        if [ "$proceedEC" = y ]; then
        echo " Are you sure you want to remove exited containers?y/n"
        read EC
                if [ "$EC" = y ]; then
                 sudo docker rm $(sudo docker ps -q -f status=exited)
                echo "
__________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
_________________________________________________"

                elif [ "$EC" = n ];then
                exit
                fi
         elif [ "$proceedEC" = n ];then
         exit
         fi
fi



#Images
if [ "$option1" = '-i' ] && [ "$option2" = "" ];then
        echo "This option will remove all unused images.

__________________________________________________
Unused images:
         $(sudo docker images -f dangling=true)
_________________________________________________
         Are you sure you want to continue?y/n"

        read uimg
        if [ "$uimg" = y ];then
        sudo docker image prune
        echo "
________________________________________________
Unused images:
         $(sudo docker images -f dangling=true)
_________________________________________________"

        elif [ "$uimg" = n ];then
        exit
        fi

fi
if [ "$option1" = '-i' ] && [ "$option2" = '-dry-run' ];then
        echo "This option removes all unused images.
_________________________________________________
Unused images:
          $(sudo docker images -f "dangling=true")
_________________________________________________
         You want to proceed?y/n"
         read proceedUI
        if [ "$proceedUI" = y ]; then
        echo " Are you sure you want to remove all unused images?y/n"
        read UI
                if [ "$UI" = y ]; then
                 sudo docker image prune
                 echo "
__________________________________________________
Unused images:
          $(sudo docker images -f dangling=true)
_________________________________________________"

                 elif [ "$UI" = n ];then
                 exit
                 fi
         elif [ "$proceedUI" = n ];then
         exit
         fi
fi



#Volumes
if [ "$option1" = '-v' ] && [ "$option2" = "" ];then
        echo "This option will remove all unused volumes.

__________________________________________________
Unused volumes:
         $(sudo docker volume ls -f dangling=true)
_________________________________________________
         Are you sure you want to continue?y/n"

        read uvol
        if [ "$uvol" = y ];then
        sudo docker volume prune
        echo "
________________________________________________
Unused volumes:
         $(sudo docker volume ls -f dangling=true)
_________________________________________________"

        elif [ "$uvol" = n ];then
        exit
        fi


fi
if [ "$option1" = '-v' ] && [ "$option2" = '-dry-run' ];then
        echo "This option removes all unused volumes.
_________________________________________________
Unused volumes:
          $(sudo docker volume ls -f dangling=true)
_________________________________________________
         You want to proceed?y/n"
         read proceedUV
        if [ "$proceedUV" = y ]; then
        echo " Are you sure you want to remove all unused volumes?y/n"
        read UV
                if [ "$UV" = y ]; then
                 sudo docker volume prune
                 echo "
__________________________________________________
Unused volumes:
          $(sudo docker volume ls -f dangling=true)
_________________________________________________"

                 elif [ "$UV" = n ];then
                 exit
                 fi
         elif [ "$proceedUV" = n ];then
         exit
         fi
fi




#ALL
if [ "$option1" = '-all' ] && [ "$option2" = "" ];then
        echo "This option will removes all exited containers and unused images and volumes.

__________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
Unused images:
        $(sudo docker images -f dangling=true)
Unused volumes:
         $(sudo docker volume ls -f dangling=true)
_________________________________________________
         Are you sure you want to continue?y/n"

        read uvol
        if [ "$all" = y ];then
         sudo docker rm $(sudo docker ps -q -f status=exited)
        sudo docker image prune
        sudo docker volume prune
        echo "
________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
Unused images:
        $(sudo docker images -f dangling=true)
Unused volumes:
         $(sudo docker volume ls -f dangling=true)
_________________________________________________"

        elif [ "$all" = n ];then
        exit
        fi
fi

if [ "$option1" = '-all' ] && [ "$option2" = '-dry-run' ];then
        echo "This option remove all exited containers and unused images and volumes.
_________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
Unused images:
        $(sudo docker images -f dangling=true)
Unused volumes:
          $(sudo docker volume ls -f dangling=true)
_________________________________________________
         You want to proceed?y/n"
         read proceedALL
        if [ "$proceedALL" = y ]; then
        echo " Are you sure you want to remove all exited containers and unused volumes and images?y/n"
        read ALL
                if [ "$ALL" = y ]; then
                  sudo docker rm $(sudo docker ps -q -f status=exited)
                 sudo docker image prune
                 sudo docker volume prune
                 echo "
__________________________________________________
Exited containers:
         $(sudo docker ps -f status=exited)
Unused images:
        $(sudo docker images -f dangling=true)
Unused volumes:
          $(sudo docker volume ls -f dangling=true)
_________________________________________________"

                 elif [ "$ALL" = n ];then
                 exit
                 fi
         elif [ "$proceedALL" = n ];then
         exit
         fi
fi

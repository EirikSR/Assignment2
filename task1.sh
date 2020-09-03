
#echo "Set working directory:"
#read Wd
Wd="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
Wd+="/"
#echo $SCRIPTPATH
#Wd="C:/Users/Eirik/In3110/Assignment2/"

echo "Enter source directory"
read src

lst=()
#src="origin0"
if [ -d "$Wd$src" ]; then
    echo "Directory $Wd$src exists."
    lst+=("$Wd$src")
else
    echo "Directory $Wd$src does not exist, press 1 to retry, enter to abort"
    read src2
    if [ "$src2" == "1" ]; then
        sh task1.sh && exit
    else
        exit
    fi
fi

echo "Enter target directory"
read dst
#dst="goal"

if [ -d "$Wd$dst" ]; then
    echo "Directory $Wd$dst exists."
    lst+=("$Wd$dst")
else
    printf "Directory $Wd$dst does not exist,\n press 1 to create folder with same name as input\n2 for new folder with date-time name\n 3 to retry"
    read dst2
    if [ "$dst2" == "1"]; then
        mkdir $Wd$dst
        echo "$Wd$dst created"
        dst=$dst2
        lst+=("$Wd$dst")
    elif [ "$dst2" == "2" ]; then
        DATE=$(date '+%Y-%m-%d-%H:%M:%S')
        mkdir "$DATE"
        echo "$DATE created"
        dst="$DATE"
        lst+=("$Wd$dst")
    else
        echo "aborting"
        sh task1.sh && exit
    fi
fi
echo
if [ "${#lst[@]}" == "2" ]; then
    echo "Select filetype to be transferred ('all' or specify file type without '.')"
    read FileT

    if [ "$FileT" == "all" ]; then
        echo "Moving from" ${lst[0]} "to" ${lst[1]}
        cp $src/* $dst -i
    else
        echo "Moving from" ${lst[0]} "to" ${lst[1]}
        cp /$src/*.$FileT /$dst -i
    fi
fi

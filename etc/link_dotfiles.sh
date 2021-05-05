#!/bin/bash

# moves here and gets config
cd $(dirname $0)
source ./config.sh
cd ../

# link all of them without ignores
for target in *
do
    # ignore untargets
    if [[ ${IGNORES[@]} =~ ${target} ]]; then continue; fi

    # get pathes
    config_name=$(echo ${target} | tr "[:lower:]" "[:upper:]" | tr -d ".")_PATH
    destination_path=$(eval 'echo $'$config_name'')
    target_path=$(pwd)/${target}

    # check if the path is set
    if [ -z ${destination_path} ]
    then
        echo info: the path of ./${target} is unset in ./etc/config.sh
        continue
    fi

    # if it is ok, link the target
    if [ -h ${destination_path} ]
    then
        echo failed: linked ${destination_path} exists, rename or remove it
        continue
    elif [ -e ${destination_path} ]
    then
        mv ${destination_path} ${destination_path}.old \
            && echo info: ${destination_path} exists, rename ${destination_path} to ${destination_path}.old \
            || echo failed: could not rename ${destination_path} to ${destination_path}.old
    else
        #echo info: .${target} doesn\'t exists
        :
    fi

    ln -sf ${target_path} $destination_path \
        && echo ok: linked ${target_path} to ${destination_path} \
        || echo failed: could not link ${target_path} to ${destination_path}
done

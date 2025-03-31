#!/bin/bash
removeTashkeel(){
    str="$1"
    newStr=''

    for ((i=0;i<${#str};i++))
    do
        case ${str:$i:1} in
            َ) newStr+='' ;;
            ُ) newStr+='' ;;
            ِ) newStr+='' ;;
            ّ) newStr+='' ;;
            ْ) newStr+='' ;;
            *) newStr+=${str:$i:1} ;;

        esac
    done
}

# if an option is passed
case "$1" in
    -f | --file)
        shift
        str=$(cat "$1")
        removeTashkeel "$str"
        echo $newStr >> "$1"
        printf "new text appended to %s\n" "$1"
        exit 0
        ;;
    -h | --help)
        printf ''' -f , --file [path]
        Use the file in the path, remove tashkeel, append the new text to the file\n'''
        exit 0
        ;;
    *)
        removeTashkeel "$1"
        echo $newStr | xclip -selection clipboard
        printf "copied to clipboard\n"
        exit 0
esac

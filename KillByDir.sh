# !/bin/sh/

Dir=$1
echo $Dir
Port=`cat $Dir/*.json | grep Port  | grep -v "3306"| cut -d \: -f2 | sort -n |uniq`
for port in $Port
do
    tmpStr=$port
    Process=`netstat -nap | grep "$tmpStr" | awk '{print $7}' | cut -d \/ -f1 | sort -n | uniq`
    for p in $Process
    do
        echo $p
    done
done

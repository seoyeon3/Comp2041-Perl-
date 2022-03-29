#!/bin/dash
d=$(diff -s a .girt/index/a/latest|cut -d' ' -f1)
echo $d
if [ $d = "Files" ]; then
	echo "Identical"
else
    echo different
fi    

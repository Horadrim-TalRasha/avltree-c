# /bin/sh

res=`grep "0 errors from 0 contexts" valgrind.log | wc -l`
if [ $res = "1" ]; then
    return 0
else
    return 1
fi

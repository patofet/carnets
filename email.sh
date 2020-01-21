#!/bin/bash
entrada="ent.csv"
sortida="emails.txt"
cnt=1
total=`wc -l $entrada | cut -f 1 -d' '`
emailsFinals=""
while [ $cnt -le $total ]
do
  line=`cat $entrada | head --lines=$cnt | tail --lines=1`
  email=`echo "$line" | cut -f 6 -d','`
  if [ $cnt -eq 1 ]
  then
	emailsFinals="$email"
  else
	emailsFinals="$emailsFinals,$email"
  fi
  let cnt=cnt+1
done
echo "$emailsFinals" > "$sortida"

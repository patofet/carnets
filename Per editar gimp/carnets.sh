#!/bin/bash
ori="original.png"
entrada="ent.csv"
sortida="sort"
cnt=1
total=`wc -l $entrada | cut -f 1 -d' '`
echo "$total"

while [ $cnt -le $total ]
do
  line=`cat $entrada | head --lines=$cnt | tail --lines=1`
  nom=`echo "$line" | cut -f 2 -d',' | tr "[:upper:]" "[:lower:]" | sed 's/\([a-zÇ-Ý]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
  cognom=`echo "$line" | cut -f 3 -d',' | cut -f 1 -d' ' | tr "[:upper:]" "[:lower:]" | sed 's/\([a-zÇ-Ý]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
  if [ "$cognom" = "De" -o "$cognom" = "San" ]
  then
	cognom="`echo "$line" | cut -f 3 -d',' | cut -f 1 -d' '` `echo "$line" | cut -f 3 -d',' | cut -f 2 -d' '`"
  fi
  echo "$cnt $nom $cognom"
  
  
  convert -pointsize 70 -fill black -draw "text 435,275 \"$cnt\"" $ori tmp.png
  convert -pointsize 70 -fill black -draw "text 435,390 \"$nom\"" tmp.png tmp.png
  convert -pointsize 70 -fill black -draw "text 435,505 \"$cognom\"" tmp.png "$sortida/$cnt.png"
  let cnt=cnt+1
  #break;
done

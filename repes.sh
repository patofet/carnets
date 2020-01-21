#!/bin/bash
entrada="ent.csv"
cnt=1
total=`wc -l $entrada | cut -f 1 -d' '`
echo "Total de socis: $total"

while [ $cnt -le $total ]
do
  line=`cat $entrada | head --lines=$cnt | tail --lines=1`
  cognom=`echo "$line" | cut -f 4 -d',' | tr "[:upper:]" "[:lower:]" | sed 's/\([a-zÇ-Ý]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
  nom=`echo "$line" | cut -f 3 -d',' | tr "[:upper:]" "[:lower:]" | sed 's/\([a-zÇ-Ý]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
  buscar="$cnt"
	let buscar=buscar+1
  while [ $buscar -le $total ]
  do
	lineB=`cat $entrada | head --lines=$buscar | tail --lines=1`
    cognomB=`echo "$lineB" | cut -f 4 -d',' | tr "[:upper:]" "[:lower:]" | sed 's/\([a-zÇ-Ý]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
    nomB=`echo "$lineB" | cut -f 3 -d',' | tr "[:upper:]" "[:lower:]" | sed 's/\([a-zÇ-Ý]\)\([a-zA-Z0-9]*\)/\u\1\2/g'`
    if [ "$cognomB" = "$cognom" ]
    then
		echo "Cognom repe: $cognom"
		if [ "$nomB" = "$nom" ]
    		then
			echo "Nom i cognom repes: $nom $cognom"
		fi
    fi
	let buscar=buscar+1
  done

  let cnt=cnt+1
  #break;
done

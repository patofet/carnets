#!/bin/bash
ori="original.png"
entrada="ent.csv"
sortidaIMG="imatges"
sortidaPDF="pdf"
shift=1 #Numero pel que comensa
cnt=1
total=`wc -l $entrada | cut -f 1 -d' '`
let shift=shift-1
let numero=total+shift
echo "De $shift fins a $numero($total)"
mkdir "$sortidaIMG"
mkdir "$sortidaPDF"
while [ $cnt -le $total ]
do
  line=`cat $entrada | head --lines=$cnt | tail --lines=1`
  nom=`echo "$line" | cut -f 3 -d',' | tr "[:upper:]" "[:lower:]" | sed 's/\([a-zÇ-Ý]\)\([a-zA-Z0-9à-ÿ]*\)/\u\1\2/g'`
  cognom=`echo "$line" | cut -f 4 -d',' | cut -f 1 -d' ' | tr "[:upper:]" "[:lower:]" | sed 's/\([a-zÇ-Ý]\)\([a-zA-Z0-9à-ÿ]*\)/\u\1\2/g'`

  if [ "$nom" = "ÁFrica Sharay" ]
  then
	nom="África Sharay"
  fi
  if [ "$cognom" = "De" -o "$cognom" = "San" -o "$cognom" = "El" ]
  then
	cognom="`echo "$line" | cut -f 4 -d',' | cut -f 1 -d' '` `echo "$line" | cut -f 4 -d',' | cut -f 2 -d' '`"
  fi
  
  let numero=cnt+shift
  echo "$numero($cnt) $nom $cognom"
  convert -pointsize 70 -fill black -draw "text 435,275 \"$numero\"" $ori tmp.png
  convert -pointsize 70 -fill black -draw "text 435,390 \"$nom\"" tmp.png tmp.png
  convert -pointsize 70 -fill black -draw "text 435,505 \"$cognom\"" tmp.png "$sortidaIMG/$numero.png"
  convert "$sortidaIMG/$numero.png" tmp.pdf
  convert tmp.pdf -density 230x240 ./"$sortidaPDF/$numero.pdf"
  let cnt=cnt+1
done
rm tmp.png
rm tmp.pdf

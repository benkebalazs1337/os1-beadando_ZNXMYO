#!/usr/bin/bash

file=response.json

a="'"

file_check() {
 if [ ! -f $file ]
 then
 echo "Nem létezik $file fájl."
 echo "Használati útmutató kiírásához használja a következö parancsot: "
 echo "$0 -h"
 exit 1
fi
}

concat() {
 read dif < difficulty.txt
 read type < type.txt 
 read num < number.txt
 
 link="https://opentdb.com/api.php?amount="
 link+=$num
 link+="&difficulty="
 link+=$dif
 link+="&type="
 link+=$type
}
help() {
cat << HELP
Program manual.

This program can be used to access random questions from the internet using a pre-made free API. 
After choosing the difficulty, number of questions and whether you would like to answer true/false or multiple choice questions, the program will display you the given number of questions according to your settings.
You can attempt to answer them using pen and paper. There are no points given, it's just for fun.
We store the answers to the last batch of questions asked as well, meaning we can display them too in case you are curious.

Program usage:
$0 [options]


Options:
-d	This option let's you choose the difficulty of the questions.
-n	This option let's you choose the number of questions.
-t	This option let's you choose what type questions would be asked.
-q	This option displays the quesions according to your preferences.
-a	This option displays the answers to the last bunch of questions that were asked.
-r	This option restores the program settings to the default. (difficulty: medium, number of questions: 5, types of questions: Yes/No)
-h	This option shows you this page.

Before displaying the questions for the first time, you might need to choose settings (Restoring default settings with 'option -r'would be sufficient as well.
HELP

}
filter() {
 file_check
 cat $file | sed 's/}/\n/g' > response2.json
#$file | cut -d'}' -f- --output-delimeter=$'\n' 
 cat response2.json | sed 's/\":/\n/g' > response3.json 
 sed -i -e '1,2d' response3.json
}
question() {
hossz=$(cat response.json | jq ".results | length")
for i in $(seq 0 1 $(($hossz - 1)))
do
 cat response.json | jq .results[$i].question | tr -d "\"" | sed 's/&quot;/\"/g' | sed "s/&#039;/'/g"
 echo -n -e "\t"
 cat response.json | jq .results[$i].correct_answer | tr -d "\"" | sed 's/&quot;/\"/g' | sed "s/&#039;/'/g"
 echo -n -e "\n" 
done
}

while getopts :dntqarh PARAM
do
 case $PARAM in
 d)
 echo "Please choose the desired difficulty of your upcoming questions (easy, medium or hard) by typing it in then pressing down 'Ctrl + d.'"
# echo -n "dif1=" >difficulty.txt
 cat > difficulty.txt
 ;;
 n)
 echo "Please choose how many questions you would like to be asked, then press 'Ctrl + d to confirm your choice."
# echo -n "num1=" > number.txt
 cat > number.txt
 ;;
 t)
 echo "Please choose what type of questions you would like to be asked (boolean/multiple). After choosing your desired difficulty please type it in, then press 'Ctrl + d to confirm what you typed in."
# echo -n "type1=" > type.txt
 cat > type.txt
 ;;
 q)
 concat
 curl $link -o $file -s
 filter
 awk 'NR % 7 == 5' response3.json | sed 's/,"medium","question//g; s/,"hard","question//g; s/,"easy","question//g' | sed 's/\"//g; s/,correct_answer/\n/g' | sed 's/&quot;/\"/g' | sed "s/&#039;/${a}/g"
 
 ;;
 a)
 #awk 'NR % 7 == 5' response3.json | sed 's/,"incorrect_answers//g' | sed 's/\"//g' | sed 's/&quot;/\"/g' | sed "s/&#039;/${a}/g" 
 question $OPTARG
 ;;
 r)
 echo "Settings restored to original. (difficulty: medium, number of questions: 5, types of questions: Yes/No)"
 echo "5" > number.txt
 echo "boolean" > type.txt
 echo "medium" > difficulty.txt
 ;;
 h)
 help
 ;;
 *)
 echo "Invalid parameter!"
 echo "For help, use the '-h' switch"
 ;;
 esac
done
# karakterek átírása (esetleg tabulátorra átírni)

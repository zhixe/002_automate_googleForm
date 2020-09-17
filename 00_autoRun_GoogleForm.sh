#!/bin/sh

startTime=$(date +%s)

checkName=$(
cat ~/name.txt 2> /dev/null
)

checkPhone=$(
cat ~/phone.txt 2> /dev/null
)

googleForm=$(cat googleForm_param.txt)

if [[ -z ${checkName} || -z ${checkPhone} ]]
        then

          name=$(
          whoami |
          sed 's/.$//' |
          sed 's/.*/\u&/'
          )
 
          phone=$(
          cat ~/Staff_List.txt |
          awk -v name=$name '$1==name {print $2}'
          )
 
          echo -e "$name" > ~/name.txt
          echo -e "$phone" > ~/phone.txt

          date=$(
                echo $(date +%x_%r) | 
                tr "_" " " |
                awk '{print $1}' | 
                tr "/" " " |
                awk '{print $3"-"$1"-"$2}'
          ) 

          tmpRand=$(
                awk -v min=35.5 -v max=36.6 'BEGIN{srand(); printf "%2.1f\n",(min+rand()*(max-min))}'
          )

	  minRand=$(
	  	awk -v min=15 -v max=30 'BEGIN{srand(); print int((min+rand()*(max-min)))}'
	  )

          form=$(echo -e "${googleForm}")

          firefox --new-window "${c}"

          endTime=$(date +%s)
          end=$(printf  ""%dh:%dm:%ds"\n" $(((endTime-startTime)/3600)) $(((endTime-startTime)%3600/60)) $(((endTime-startTime)%60)))

          clear
          echo "Time taken: $end"
          echo "If you want to change your 'Name' and 'Phone'"
          echo "then please edit the following files below:"

          readlink -f ~/name.txt
          readlink -f ~/phone.txt

          else

          name=$(cat ~/name.txt)
          phone=$(cat ~/phone.txt)

          date=$(
                echo $(date +%x_%r) | 
                tr "_" " " |
                awk '{print $1}' | 
                tr "/" " " |
                awk '{print $3"-"$1"-"$2}'
          ) 

          tmpRand=$(
                awk -v min=35.5 -v max=36.6 'BEGIN{srand(); printf "%2.1f\n",(min+rand()*(max-min))}'
          )

          minRand=$(
                awk -v min=15 -v max=30 'BEGIN{srand(); print int((min+rand()*(max-min)))}'
	  )

          form=$(echo -e "${googleForm}")

          firefox --new-window "${c}"
          
          endTime=$(date +%s)
          end=$(printf  ""%dh:%dm:%ds"\n" $(((endTime-startTime)/3600)) $(((endTime-startTime)%3600/60)) $(((endTime-startTime)%60)))

          clear
          echo "Time taken: $end"
          echo "If you want to change your 'Name' and 'Phone'"
          echo "then please edit the following files below:"

          readlink -f ~/name.txt
          readlink -f ~/phone.txt

fi

#!/bin/sh
startTime=$(date +%s)

holiday2020=$(
ls ~/holidays_2020.txt > /dev/null 2>&1 && echo yes || echo no
)

if [[ -z ${holiday2020} ]]
	then
	  echo -e "2020-01-01,2020-25-01,2020-26-01,2020-27-01,2020-01-02,2020-08-02,2020-01-05,2020-07-05,2020-10-05,2020-11-05,2020-24-05,2020-25-05,2020-26-05,2020-08-06,2020-31-07,2020-20-08,2020-31-08,2020-16-09,2020-29-10,2020-14-11,2020-25-12" |
	  tr "," "\n" |
	  tr "-" " " |
	  awk '{print $1"-"$3"-"$2}' |
	  tr "," "\n"  > ~/holidays_2020.txt
fi

today=$(echo $(date +%Y-%m-%d))

## Stop the script when it is on holiday
checkCuti=$(
grep "${today}" ~/holidays_2020.txt
)

if [[ -z ${checkCuti} ]]
	then
	
	checkName=$(
	ls ~/name.txt > /dev/null 2>&1 && echo yes || echo no
	)

	checkPhone=$(
	ls ~/phone.txt  > /dev/null 2>&1 && echo yes || echo no
	)

	if [[ -z ${checkName} || -z ${checkPhone} ]]
		then

		  name=$(
		  whoami |
		  sed 's/.$//' |
		  sed 's/.*/\u&/'
		  )
	 
		  phone=$(
		  cat ~/name_telephone.txt |
		  awk -v name=$name '$1==name {print $2}'
		  )
	 
		  echo -e "$name" > ~/name.txt
		  echo -e "$phone" > ~/phone.txt

		  date=$(echo $(date +%Y-%m-%d)) 

		  tmpRand=$(
		        awk -v min=35.5 -v max=36.6 'BEGIN{srand(); printf "%2.1f\n",(min+rand()*(max-min))}'
		  )


		  c=$(echo -e "${googleFormWeb}/formResponse?&pageHistory=0,1&entry.236624214=${date}&entry.1656956466=${name}&entry.1379467676=${phone}&entry.83594357=${tmpRand}&entry.547712568=No symptoms")

		  firefox --new-window "${c}"

		  endTime=$(date +%s)
		  end=$(printf  ""%dh:%dm:%ds"\n" $(((endTime-startTime)/3600)) $(((endTime-startTime)%3600/60)) $(((endTime-startTime)%60)))

		  clear
		  echo "Time taken: $end"
		  echo "If you want to change your 'Name', 'Phone' and 'Holiday'"
		  echo "then please edit the following files below:"

		  readlink -f ~/name.txt
		  readlink -f ~/phone.txt
		  readlink -f ~/holidays_2020.txt

		  echo -e "30 08 * * 1-5 export DISPLAY=:0 && ~/00_autoRun_GoogleForm.sh" > ~/crontab_add.txt
		  crontab -l |
		  cat - ~/crontab_add.txt >~/crontab.txt && crontab ~/crontab.txt

		  else

		  name=$(cat ~/name.txt)
		  phone=$(cat ~/phone.txt)

		  date=$(echo $(date +%Y-%m-%d))

		  tmpRand=$(
		        awk -v min=35.5 -v max=36.6 'BEGIN{srand(); printf "%2.1f\n",(min+rand()*(max-min))}'
		  )

		  c=$(echo -e "${googleFormWeb}/formResponse?&pageHistory=0,1&entry.236624214=${date}&entry.1656956466=${name}&entry.1379467676=${phone}&entry.83594357=${tmpRand}&entry.547712568=No symptoms")

		  firefox --new-window "${c}"
		  
		  endTime=$(date +%s)
		  end=$(printf  ""%dh:%dm:%ds"\n" $(((endTime-startTime)/3600)) $(((endTime-startTime)%3600/60)) $(((endTime-startTime)%60)))

		  clear
		  echo "Time taken: $end"
		  echo "If you want to change your 'Name', 'Phone' and 'Holidays'"
		  echo "then please edit the following files below:"

		  readlink -f ~/name.txt
		  readlink -f ~/phone.txt
		  readlink -f ~/holidays_2020.txt


		  echo -e "30 08 * * 1-5 export DISPLAY=:0 && ~/00_autoRun_GoogleForm.sh" > ~/crontab_add.txt
		  crontab -l | 
		  cat - ~/crontab_add.txt >~/crontab.txt && crontab ~/crontab.txt

	fi

	else

	  exit
fi

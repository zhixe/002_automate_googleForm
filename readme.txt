echo -e "30 08 * * 1-5 export DISPLAY=:0 && ~/00_autoRun_GoogleForm.sh" > ~/crontab_add.txt 

crontab -l |
cat - ~/crontab_add.txt >~/crontab.txt && crontab ~/crontab.txt

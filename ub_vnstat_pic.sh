#!/bin/bash

echo -e "================[ Start ]================\n";
echo -e "=============[ A：Sugarguo ]=============\n";
echo -e "=============[ T：2017-7-9 ]=============\n";
echo -e "==========[ W：www.sugarguo.com ]=========\n";
echo -e "================[ Start ]================\n";

echo -e "==========nload vnstat vnstati==========\n";
apt-get -y install nload vnstat vnstati;

echo -e "==========cp vnstat html==========\n";
cp vnstat.tar.gz /data/wwwroot/default/.

cd /data/wwwroot/default

tar zxvf vnstat.tar.gz

chown -R www:www vnstat

rm vnstat.tar.gz

echo -e "==========chown .eth0==========\n";
cd /var/lib/vnstat 

service vnstat restart

chown vnstat:vnstat .eth0 -R

chmod 0640 .eth0

echo -e "==========echo /etc/crontab==========\n";

if cat /etc/crontab | grep vnstati>/dev/null
then
	echo -e "crontab has vnstati\n"
else
(
cat << EOF

*/5 * * * * root vnstati -m --style 0 -o /data/wwwroot/default/vnstat/vnstat_m.png
*/5 * * * * root vnstati -d --style 0 -o /data/wwwroot/default/vnstat/vnstat_d.png
*/5 * * * * root vnstati -h --style 0 -o /data/wwwroot/default/vnstat/vnstat_h.png
EOF
) >> /etc/crontab
	echo -e "crontab add vnstati\n"
fi


service cron restart
service vnstat restart
vnstat -u

vnstati -m --style 0 -o /data/wwwroot/default/vnstat/vnstat_m.png
vnstati -d --style 0 -o /data/wwwroot/default/vnstat/vnstat_d.png
vnstati -h --style 0 -o /data/wwwroot/default/vnstat/vnstat_h.png

echo -e "==========Enjoy it!==========\n";

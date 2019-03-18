#!/bin/bash - 
#===============================================================================
#
#          FILE: start.sh # 
#         USAGE: ./start.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2019/03/14 09:44
#      REVISION:  ---
#===============================================================================

mysqld  --initialize-insecure  --explicit_defaults_for_timestamp=1 
chown -R mysql.mysql /var/lib/mysql
nohup mysqld --user=mysql &
sleep 10
mysql -uroot -e "use mysql; update user set authentication_string = password('123123'), password_expired = 'N', password_last_changed = now();" -S /var/lib/mysql/mysql.sock
killall mysqld
sleep 5
nohup mysqld --user=mysql &
sleep 3
mysql -uroot -p123123 -e 'create database ops;' -S /var/lib/mysql/mysql.sock
cd /root/ops/  && echo "yes" |python manage.py collectstatic 
cd /root/ops/ && python manage.py makemigrations && python manage.py migrate 
nohup uwsgi --ini /root/uwsgi.ini & 
cp -a /root/ops/static/* /var/www/static/
cat /root/ops/create_user.py
python manage.py shell </root/ops/create_user.py
sed -i 's/#hash_type: md5/hash_type: sha256/g' /etc/salt/master
nohup salt-master &
sleep 5
nginx



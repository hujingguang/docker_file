#!/bin/bash - 
#===============================================================================
#
#          FILE: start.sh
# 
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
#       CREATED: 2019/03/18 14:39
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
mysqld  --initialize-insecure  --explicit_defaults_for_timestamp=1 
chown -R mysql.mysql /var/lib/mysql
ls -l /var/lib/mysql/
mysqld  --user=mysql


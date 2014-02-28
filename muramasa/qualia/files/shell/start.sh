
# For mysql
cd /usr/local/xtradb/xtradb-5.5.29;
sudo -u mysql ./scripts/mysql_install_db --datadir=/var/xtradb/qualia;
sudo -u mysql /etc/xtradb/qualia/mysql.server start;

# For apache
/usr/local/apache2/bin/apachectl start;

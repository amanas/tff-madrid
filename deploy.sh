
# sudo htpasswd -c .htpasswd uned
# sudo mkdir -p /etc/httpd/htpasswd
# sudo mv .htpasswd /etc/httpd/htpasswd/

# # Set /etc/httpd/conf/httpd.conf
# <Directory /var/www/html>
#      AuthType Basic
#      AuthName "Authorized Personnel Only"
#      AuthUserFile /etc/httpd/htpasswd/.htpasswd
#      Order allow,deny
#      Require valid-user
#      Satisfy Any
# </Directory>

# # Restart
# sudo service httpd restart

sudo rm -R /var/www/html
sudo cp -R ./_book /var/www/html
sudo chown -R root:root /var/www/html

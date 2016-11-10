package "php5" do
  action :install
end

#package "php5-pear" do
#  action :install
#end

package "php5-mysql" do
  action :install
end

package "php5-gd" do
  action :install
end

package "php5-mcrypt" do
  action :install
end

cookbook_file "/etc/php5/apache2/php.ini" do
  source "php.ini"
  mode "0644"
  notifies :restart, "service[apache2]"
end

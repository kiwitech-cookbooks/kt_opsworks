# Install and Enable Apache

package "apache2" do
  action :install
end

service "apache2" do
  action [:enable, :start]
end

# Virtual Host Configuration

node["lampstack"]["sites"].each do |sitename, data|
  document_root = "/var/www/html/#{sitename}"
  
  directory document_root do
    mode "0755"
    recursive true
  end

  execute "enable-sites" do
    command "a2ensite #{sitename}"
    action :nothing
  end

  execute "rewrite" do
    command "a2enmod rewrite"
  end

  template "/etc/apache2/sites-available/#{sitename}.conf" do
    source "virtualhosts.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => data["port"],
      :serveradmin => data["serveradmin"],
      :servername => data["servername"]
    )
      notifies :run, "execute[enable-sites]"
      notifies :restart, "service[apache2]"
  end

#  directory "/var/www/html/#{sitename}"do
#    action :create
#  end
  
end




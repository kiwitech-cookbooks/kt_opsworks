node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping php_custom::configure application #{application} as it is not an PHP app")
    next
  end
 
  #write out app.php in to the app
  template "#{deploy[:absolute_document_root]}config/app.php" do
    source 'app.php.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(
      :database => deploy[:database],
      :memcached => deploy[:memcached],
      :layers => node[:opsworks][:layers],
      :stack_name => node[:opsworks][:stack][:name]
    )
  end

bash 'Fix permissions' do
  code <<-EOH
    su - #{deploy[:user]}
    cd #{deploy[:absolute_document_root]} 
    find . -type d -exec chmod 755 {} \\;
    find . -type f -exec chmod 644 {} \\;
    chmod -R 0777 ./tmp ./logs
    EOH
  only_if do
    File.exists?("#{deploy[:absolute_document_root]}")
  end
end

#Install composer and run composer.phar install 
  cookbook_file "#{deploy[:absolute_document_root]}composer-setup.php" do
    source 'composer-setup.php'
    mode '0755'
    owner deploy[:user]
    group deploy[:group]
    not_if do
      File.exists?("#{deploy[:absolute_document_root]}composer-setup.php")
    end  
  end
  bash 'php composer-setup.php' do
    code "php ./composer-setup.php --install-dir=."
  end
  bash 'composer.phar install' do
    code "./composer.phar install"
    only_if do
      File.exists?("#{deploy[:absolute_document_root]}composer.lock") 
    end
  end
end

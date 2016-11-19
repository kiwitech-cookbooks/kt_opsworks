node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping php_custom::configure application #{application} as it is not an PHP app")
    next
  end

  # write out app.php in to the app
  template "#{deploy[:absolute_document_root]}/config/app.php" do
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
end

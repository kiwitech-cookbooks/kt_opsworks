require 'minitest/spec'

describe_recipe 'php_custom::configure' do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions

  it 'creates the php file for data exchange' do
    node[:deploy].each do |application, deploy|
      if deploy[:application_type] == 'php'
        file("#{deploy[:deploy_to]}/shared/config/app.php").must_exist.with(:mode, '0660').and(:owner, deploy[:user]).and(:group, deploy[:group])
      end
    end
  end
end

# Create directory
directory '/home/ubuntu/phpsysinfo' do
  owner 'ubuntu'
  group 'ubuntu'
  recursive true
end

# Clone repository
git '/home/ubuntu/phpsysinfo' do
  repository 'git://github.com/guddukhan1987/phpsysinfo.git'
  revision 'master'
  action :checkout
  user 'ubuntu'
  group 'ubuntu'
#  ssh_wrapper '/home/ubuntu/sshkey_setup.sh'
end

cookbook_file "/home/ubuntu/deploy.sh"do
  source "deploy.sh"
  mode "0777"
end

execute "deploy code to webroot" do
  command "sh /home/ubuntu/deploy.sh"
end

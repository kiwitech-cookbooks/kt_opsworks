package "git" do
  action :install
end

# Create .ssh directory
#directory '/home/ubuntu/.ssh' do
#  owner 'ubuntu'
#  recursive true
#end

# Copy private key to .ssh directory
cookbook_file "/home/ubuntu/.ssh/sshkey" do
  source "sshkey"
  mode "0600"
end

# Create ssh configuration script
cookbook_file "/home/ubuntu/sshkey_setup.sh"do
  source "sshkey_setup.sh"
  mode "0777"
end

# Run ssh configuration script
#execute "setup sshkey config" do
#  command "sh /home/ubuntu/sshkey_setup.sh"
#end

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
  ssh_wrapper '/home/ubuntu/sshkey_setup.sh'
end

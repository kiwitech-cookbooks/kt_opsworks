package "git" do
  action :install
end

# Create .ssh directory
#directory '/home/ubuntu/.ssh' do
#  owner 'ubuntu'
#  recursive true
#end

# Copy private key to .ssh directory
#cookbook_file "/home/ubuntu/.ssh/sshkey" do
#  source "sshkey"
#  mode "0600"
#end
execute "Generate SSH keypair" do
  command "ssh-keygen -qt rsa -N '' -f /home/ubuntu/.ssh/id_rsa"
end

execute "STDOUT id_rsa.pub" do
  command "echo 'Don't forget to add below key as Github repo's Deploy-key (RO)'"
  command "cat /home/ubuntu/.ssh/id_rsa.pub"
end
execute "Authorized Jenkins server pubkey" do
  command "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"
end
#cookbook_file "/home/ubuntu/sshkey_setup.sh"do
#  source "sshkey_setup.sh"
#  mode "0777"
#end

# Run ssh configuration script
#execute "setup sshkey config" do
#  command "sh /home/ubuntu/sshkey_setup.sh"
#end


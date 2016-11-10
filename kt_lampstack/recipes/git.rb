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
  command "echo -e "y\n" | ssh-keygen -qt rsa -N '' -f /home/ubuntu/.ssh/id_rsa"
end

execute "STDOUT id_rsa.pub" do
  command "echo 'Don't forget to add below key as Github repo's Deploy-key (RO)'"
  command "cat /home/ubuntu/.ssh/id_rsa.pub"
  live_stream true
end
execute "Authorized Jenkins server pubkey" do
  command "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrROAMQMBdUnm4pRPwQtUNe4rfdPeWl7rPg8980+gh8FBmXQ9/83GZQ+D4ZLS+rW7S9rZGqxZHApnrWtcsIBLmPDUIFZBCdpkCP3pdU2TbsgS2dW+9YDYsVj94ojBoSgF+/23414q5T2NT5iwHkmBpOVmXrzDpkoOrFfsil6LKsWPGFIQ+XQpcHYzL1iJEsflGw9LNr9WzOavhkcyMmR2VUIh4TKkkki+EbTZWqgE5nYWilh+/nZubMUR8EewhvjKSCLYyGiMYytGRdTuCY2Z83V9IfYk9lmMI9sTeUDJfugvLmw3Q8zo5RhdplIngXPDGtn4fAaqUxk88I2/JUUTL jenkins@jenkins-kiwi-test' >> /home/ubuntu/.ssh/authorized_keys"
end
#cookbook_file "/home/ubuntu/sshkey_setup.sh"do
#  source "sshkey_setup.sh"
#  mode "0777"
#end

# Run ssh configuration script
#execute "setup sshkey config" do
#  command "sh /home/ubuntu/sshkey_setup.sh"
#end


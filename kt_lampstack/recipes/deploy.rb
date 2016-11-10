cookbook_file "/home/ubuntu/deploy.sh"do
  source "deploy.sh"
  mode "0777"
end

execute "deploy code to webroot" do
  command "sh /home/ubuntu/deploy.sh"
end

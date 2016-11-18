cookbook_file "/home/deploy/deploy.sh" do
  source "deploy.sh"
  mode 0755
end

execute "Run deploy script" do
  command "bash /home/deploy/deploy.sh"
end

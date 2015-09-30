package 'nginx'

service 'nginx' do
  action ['enable','start']
end

template "/etc/nginx/nginx.conf" do
end
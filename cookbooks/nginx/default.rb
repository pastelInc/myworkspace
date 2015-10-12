package 'nginx'

service 'nginx' do
  action ['enable','start']
end

template '/etc/nginx/nginx.conf' do
  notifies :reload, 'service[nginx]'
end

template '/etc/nginx/conf.d/default.conf' do
  notifies :reload, 'service[nginx]'
end

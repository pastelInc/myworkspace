package 'http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm' do
  not_if 'rpm -q pgdg-centos94-9.4-1.noarch'
end

package 'postgresql94-devel'
package 'postgresql94-server'
package 'postgresql94-contrib'

execute 'initdb' do
  command 'service postgresql-9.4 initdb -D /var/lib/psql/9.4/data --no-locale'
  not_if 'ls /var/lib/pgsql/9.4/data/postgresql.conf'
end

service 'postgresql-9.4' do
  action ['enable','start']
end

execute 'createuser' do
  command 'sudo -u postgres createuser vagrant -d'
  not_if 'sudo -u vagrant psql -c "SELECT version();" postgres'
end

template '/var/lib/pgsql/9.4/data/pg_hba.conf' do
  owner 'postgres'
  group 'postgres'
  notifies :reload, 'service[postgresql-9.4]'
end

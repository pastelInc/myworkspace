#!/bin/sh

# args
vm='"develop"'

current_ruby_version=`ruby -v | awk '{print $2}'`

if [ $current_ruby_version != '2.2.3p173' ]; then
  echo "itamae depends ruby install..."
  # mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
  # (cd ~/rpmbuild/SOURCES && curl -LO http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz)
  # (cd rpmbuild/SPECS; curl -O https://raw.githubusercontent.com/feedforce/ruby-rpm/master/ruby22x.spec)
  # sudo yum install -y rpm-build
  # sudo yum install -y gdbm-devel libyaml-devel libffi-devel
  # rpmbuild -ba rpmbuild/SPECS/ruby22x.spec
  curl -s https://packagecloud.io/install/repositories/pastelInc/ruby223/script.rpm.sh | sudo bash
  sudo yum remove -y ruby ruby-augeas
  sudo yum install -y ruby223
fi

# itamae install
if ! ( gem contents itamae ) < /dev/null > /dev/null 2>&1; then
  echo "itamae install..."
  sudo gem install itamae
fi

# exec itamae
cd /vagrant
echo {'"role"': ${vm}} > node.json
sudo itamae local --node-json=node.json bootstrap.rb
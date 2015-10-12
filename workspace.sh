#!/bin/sh

CURRENT_RUBY_VERSION=`ruby -v | awk '{print $2}'`

if [ $CURRENT_RUBY_VERSION != '2.2.3p173' ]; then
  echo "itamae depends ruby install..."
  # mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
  # (cd ~/rpmbuild/SOURCES && curl -LO http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz)
  # (cd rpmbuild/SPECS; curl -O https://raw.githubusercontent.com/feedforce/ruby-rpm/master/ruby22x.spec)
  # sudo yum install -y rpm-build
  # sudo yum install -y gdbm-devel libyaml-devel libffi-devel
  # rpmbuild -ba rpmbuild/SPECS/ruby22x.spec
  curl -s https://packagecloud.io/install/repositories/pastelInc/ruby223/script.rpm.sh | sudo bash
  yum remove -y ruby-libs ruby-augeas ruby-shadow
  yum install -y ruby223
fi

# itamae install
if ! ( gem contents itamae ) < /dev/null > /dev/null 2>&1; then
  echo "itamae install..."
  gem install itamae
fi

# args
vm='develop'

# exec itamae
cd /vagrant
cat <<EOS > node.json
{
  "role": "${vm}"
}
EOS
itamae local --node-json=node.json bootstrap.rb

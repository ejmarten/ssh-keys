#!/bin/bash

this_script="/usr/local/bin/authorized_keys.sh"
latest_script="/opt/ssh-keys/authorized_keys.sh"
admin_user="devops"
admin_user_exists=$(grep ^$admin_user /etc/passwd 2>&1 >/dev/null;echo $?)
admin_user_sudo=$(grep -r ^$admin_user /etc/sudoers*  2>&1 >/dev/null;echo $?)
git_url="git@github.com"
git_repo="ejmarten/ssh-keys.git"

cd /opt/

if [ -d ssh-keys ]
then rm -Rf ssh-keys
fi

git clone git@github.com:ejmarten/ssh-keys.git

if [ $admin_user_exists != 0 ]
then 
useradd -s /bin/bash -m -U devops
fi

if [ ! -d ~admin_user/.ssh ]
then
mkdir --mode=700 -p /home/$admin_user/.ssh
fi

cat /opt/ssh-keys/*.pub > /home/$admin_user/.ssh/authorized_keys

chown -R $admin_user:$admin_user /home/$admin_user
chmod -R 700 /home/$admin_user/.ssh

if [ 1 == $admin_user_sudo ]
then
cat ssh-keys/sudoers.devops >> /etc/sudoers
fi

if [ -f $this_script ]
then
  diff $this_script $latest_script 2>&1 >/dev/null
  if [ 0 != $? ]
  then
  cp -f $latest_script $this_script
  fi
fi



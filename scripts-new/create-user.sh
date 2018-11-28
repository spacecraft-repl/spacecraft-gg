#!/usr/bin/env bash

# Usage: 
# Create user bob:  ./create-user.sh bob
# Login as bob:     su bob


if [ "$#" -ne 1 ]; then
  echo 'Illegal number of parameters (must be exactly 1).'
  exit 1
fi

username="$1"

if [ "$username" == '' ]; then
  echo 'Username cannot be empty.'
  exit 1
fi

if grep "$username" /etc/passwd; then
  echo 'Username already exists.'
  exit 1
fi

# Create user
adduser --shell /bin/rbash --disabled-password --gecos 'create-user' "$username"

# Restrict usage of executables to the following:
mkdir /home/"$username"/bin
ln -s /bin/ls /home/"$username"/bin/ls
ln -s /bin/cat /home/"$username"/bin/cat
ln -s /bin/echo /home/"$username"/bin/echo

# ln -s /bin/ping /home/"$username"/bin/ping
ln -s /bin/vim /home/"$username"/bin/vim

ln -s /usr/bin/python /home/"$username"/bin/python
ln -s /usr/bin/node /home/"$username"/bin/node
ln -s /usr/bin/irb /home/"$username"/bin/irb
ln -s /bin/rbash /home/"$username"/bin/bash

# Restrict access to user's .bashrc
chown root /home/"$username"/.bashrc
chmod 755 /home/"$username"/.bashrc
echo 'PATH=$HOME/bin' >> /home/"$username"/.bashrc

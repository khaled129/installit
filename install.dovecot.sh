#!/bin/bash

# ensure that this script is run by root
if [ $(id -u) -ne 0 ]; then
  sudo $0
  exit
fi

# install dovecot
apt-get install -y dovecot-imapd

# enable secure imap only (Port 993)
sed -i 's|^protocols = imap imaps|protocols = imaps|g' /etc/dovecot/dovecot.conf

# configure ssl
sed -i 's|^#ssl_cert_file|ssl_cert_file|g' /etc/dovecot/dovecot.conf
sed -i 's|^#ssl_key_file|ssl_key_file|g' /etc/dovecot/dovecot.conf
sed -i 's|^#disable_plaintext_auth = yes|disable_plaintext_auth = yes|g' /etc/dovecot/dovecot.conf

# configure mailbox path
sed -i 's|mbox:~/mail:INBOX=/var/mail/%u|maildir:~/Maildir|g' /etc/dovecot/conf.d/10-mail.conf

# restart
/etc/init.d/dovecot restart

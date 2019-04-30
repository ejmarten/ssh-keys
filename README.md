# SSH-keys

Stop sharing keys!  

The authorized-keys.sh script will phone home to a git repo to retrieve all of the public ssh keys for your users and allow them to login to a shared account (or non-shared with a few minor changes TODO).

Install and use this script by allowing the root user on your base image access to your repo, and install this script in /usr/local/bin/ on your base image.  Then create a link to the script in /etc/cron.hourly/

Add the public keys of your users to this repo, and voila, you have solved a major security issue. 

If you would like, you can also set up google authenticator along with this for MFA. Better security, no AD or LDAP admins blocking progress.

Enjoy.

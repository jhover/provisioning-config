PROVISIONING CONFIGURATION

This project is for the creation of an RPM to be installed on a VM.
It installs/configures all our Puppet modules, and includes the cron script to run puppet apply. 

Puppet will run pointed to 
 /etc/hiera/
            defaults.yaml
            local.yaml
 
The userdata init script will periodically pull the userdata file, (which *is local.yaml) and put it in place.            

runpuppet.sh will run periodically and re-apply config.  
 


NOTES

-- No logrotate is needed for the runpuppet output, because Puppet already has settings for all logs within /var/log/puppet



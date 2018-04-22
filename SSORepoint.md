Re-register vCenter Inventory Service with vCenter Single Sign-On

Open a command prompt as administrator on the Inventory Service host machine.

Change directory to:
C:\Program Files\VMware\Infrastructure\Inventory Service\scripts

Run the is-change-sso.bat command to update the stored configuration information of the Inventory Service:

is-change-sso.bat https://%SSOServer%:7444/lookupservice/sdk "administrator@vSphere.local" "SSO_PWD"

Restart the Inventory Service:
net stop vimQueryService
net start vimQueryService


Register vCenter Server with a different vCenter Single Sign-On instance

Open Windows Explorer on the vCenter server and Browse to:
C:\Program Files\VMware\Infrastructure\VirtualCenter Server\ssoregtool

Create new directory and name it SSO_repoint

Unzip the sso_svccfg.zip file into SSO_repoint.

Change directory to the new folder before executing the next step.

Open a new Windows Explorer and browse to: 
"C:\Program Files\VMware\Infrastructure\Inventory Service\bin"

Copy all contents from the folder above and paste in: 
C:\ Program Files\VMware\Infrastructure\VirtualCenter Server\ssoregtool\sso_repoint

Open a command prompt as administrator and type the following:
Mkdir "C:\ProgramData\VMware\SSL\C=US,CN=CA\, CN\=SSO01\, dc\=vsphere\,dc"
Replace SSO01 above with your SSO NETBIOS name, no FQDN.

Change to the directory of extracted folder above in the command prompt and type the following:
repoint.cmd configure-vc --lookup-server https://%SSO_FQDN%:7444/lookupservice/sdk --user "administrator@vSphere.local" --password "SSO_PWD"

Restart the VMware VirtualCenter Server and the VMware VirtualCenter Management Webservices services.


Register the vSphere Web Client with a different vCenter Single Sign-On instance

Open a command prompt as administrator.
Change directory to:
C:\Program Files\VMware\Infrastructure\vSphereWebClient\scripts

Run the client-repoint.bat command to register the vSphere Web Client with a different vCenter Single Sign-On and Lookup Service

client-repoint.bat https://%SSO_FQDN%:7444/lookupservice/sdk "administrator@vSphere.local" "SSO_PWD"

After all services have restarted, test logging into vcenter.  Log in as administrator@vsphere.local through the web client, go to configuration on the left, and make sure it is pointing to the new PSC.
Uninstall original SSO through add/remove programs.

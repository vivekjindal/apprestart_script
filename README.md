This script when started will run continuously in loop mode. Script checks for a process as defined in script configuration and takes actions based on the process status.

I wrote this script when I was given a task to monitor a process continuously to ensure it was running. This script will start the process if it's not running; kill it and restarts it if it's hung.

If you also have such kind of tasks in your job profile just download my script and configure it as per your needs

# Script configuration:
![Script configuration](https://raw.githubusercontent.com/vivekjindal/apprestart_script/master/images/screenshot1.png)  
__appname:__ put a fancy name of your app here  
__exename:__ put name of the executable here  
__exepath:__ put path of the executable here  
__timeout:__ after how many seconds should the script check for process status  

# Script in action
![Script in action](https://raw.githubusercontent.com/vivekjindal/apprestart_script/master/images/screenshot2.png)


# Notes:

This script is not suitable if your application runs in multi-process mode.

This script when started will run continuously in loop mode. Script checks for a process as defined in script configuration and takes actions based on process status.

I wrote this script when I was given a task to monitor a process continuously to ensure it was running. It was really a PITA to see in task manager if process was running or not. This script will start the process if it's not running; kill it and restarts it if it's hung.

If you also have such kind of tasks in your job profile just download my script, configure it as per your needs and voila! Have fun...

# Script configuration:

__appname:__ put a fancy name of your app here  
__exename:__ put name executable here  
__exepath:__ put path of executable here  
__timeout:__ after how many seconds should the script check for process status  

# Script in action
![Script in action](https://github.com/vivekjindal/apprestart_script/raw/master/images/screenshot.PNG)


# Notes:

This script is not suitable if your application runs in multi-process mode.

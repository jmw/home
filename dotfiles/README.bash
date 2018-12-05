Why?

https://serverfault.com/questions/261802/what-are-the-functional-differences-between-profile-bash-profile-and-bashrc

.profile:

    .profile is for things that are not specifically related to Bash, like environment variables PATH and friends, and should be available anytime.

   For example, .profile should also be loaded when starting a graphical desktop session.


.bashrc

   .bashrc is for the configuring the interactive Bash usage, like Bash aliases, setting your favorite  editor, setting the Bash prompt, etc.


.bash_profile

   .bash_profile is for making sure that both the things in .profile and .bashrc are loaded for login shells.

   For example, .bash_profile could be something simple like

   . ~/.profile
   . ~/.bashrc



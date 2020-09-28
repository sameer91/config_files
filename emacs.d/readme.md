# Setting up Emacs server
setting up server saves up a ton of init.el load time by loading init.el once at the beginning.
* Enable emacs init service
  ```systemctl --user enable emacs.service```
* You can now create a new window/client/frame for emacs server
  ```emacsclient -c foo.cpp```
* Create alias
  ```alias eclient='emacsclient -c'```

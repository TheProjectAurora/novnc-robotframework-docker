# Purpose:
POC of Robot Framework [katas](https://en.wikipedia.org/wiki/Kata) that could be used as baseline how training/demo/R&D envs could be created. Use Robot Framework official WebDemo material from they github repo as example: https://github.com/robotframework/WebDemo

# USAGE:

## Start environment:
Execute: `docker-compose up -d` <BR>
BEHAVIOR:
* Kick up two container: novnc-with-robotframework AND webdemo
* novnc-with-robotframework made portmap to: https://localhost <= user:**coder** pw: **coderpw**
* NoVNC session oppened to browser and offer full linux desctop
* Left bottom corner of noVNC desctop is arrow where open main menu of linux desctop
* GoTo: 'System Tools' =>  'LXTerminal' => Open shell to you
* Execute robot tests with different browsers by writing to LXTerminal:
  * Firefox: `robot -v BROWSER:firefox EXERCISES/webdemo/login_tests`
  * Chrome: `robot -v BROWSER:chrome EXERCISES/webdemo/login_tests`
* Now robot framework execution should start with testcases from: https://github.com/robotframework/WebDemo/tree/master/login_tests

>**FYI**: Google Chrome eat a lot of cpu&mem so firefox browser is recomended to be used.

## Stop environment:
Execute: ` docker-compose down` <BR>
BEHAVIOR:
* Stop and remove two container: novnc-with-robotframework AND webdemo

## Clean up:
* Execute [stop environment](https://github.com/TheProjectAurora/novnc-robotframework-katas#stop-environment)
* Delete WebDemo folder from ./EXERCISES
* Delete images: `docker image rm robotframework-infra-katas_novnc-with-robotframework robotframework-infra-katas_webdemo`

# Known problems (Existing features)
* Copy-Paste between noVNC<->HOST happened by using noVNC desctop left side menu (click arrow in center of noVNC window) and open clipboard by using it icon in menu. This is a textbox where you should paste your copy from HOST and then it could be pasted to noVNC side. Copying from noVNC to HOST happened by using same method but vise-versa way.
* CapsLock could seem to be out of sync between noVNC desktop and HOST. That why change CapsLock status allways in HOST side window (e.g. by using host browser url row)

# Development / Productize Ideas:
* Create own docker base image that include common tools to all katas that require GUI/X-desctop
* Optimization to image size and layer amounts
* Containerized noVNC solution should not be used in situations where direct connect to HOST side is required in GUI/shell level. Container layer between noVNC-HOST could misslead user becouse hacks are needed. To that kind of solutions noVNC should be installed directly to HOST without containers. Remote Visual Studio Code could be also answer to this kind of solutions.
# auto-type-pass

Finds all gpg files under ```~/.password-store/```
match filename against current window name, if match is found auto paste password (1st line) form gpg file and sends enter key. Works with first match, so naming is important.

---
check if you are using X11 
```loginctl show-session 2 -p Type``` 
>```xdotool``` does not work with Wayland ( need to find some alternative )
---
#### requirements
```xdotool``` - https://www.semicomplete.com/projects/xdotool/
```pass``` - https://www.passwordstore.org/

### install
checkout somewhere and create keyboard shortcut to it 
```
cd /usr/local/
sudo git@github.com:yboikov/auto-type-pass.git
```
shortcut
![alt text](https://raw.githubusercontent.com/yboikov/auto-type-pass/master/auto-type-pass.png)
### examples
```
how to setup pass: https://www.passwordstore.org/
```
~/.password-store/login.example.com.gpg for web login ( check website title in for right gpg file name )
```
username
Tab
passW0rd
Return
```
console title must be something like ```PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'```
and password must be set in < hostname >.gpg (works better with fqdn hostname ${HOSTNAME} )

~/.password-store/myhostname.gpg (single line) for sudo su -
```
onlyPassWord
Return
```
will type onlyPassWord and hit enter 

##### version: 0.0.1



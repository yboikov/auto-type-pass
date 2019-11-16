# auto-type-pass

Finds all gpg files under ```~/.password-store/```
match filename against current window name, if match is found auto paste password (1st line) form gpg file and sends enter key

#### requirements
```xdotool``` - install xdotool

```pass utility``` - https://www.passwordstore.org/

---
check if you are using X11 ```loginctl show-session 2 -p Type```
xdotool does not work with Wayland ( need to find some alternative )

### install
save script somewhere and assign keyboard shortcurt with it.

### examples
somesite.com.gpg for web login
```
username
Tab
passW0rd
Return
```

myhostname.gpg (single line) for sudo su -
```
onlyPassWord
```
will type onlyPassWord and hit enter 

##### version: 0.0.1



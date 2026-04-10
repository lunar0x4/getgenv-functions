# UNC Functions
Working functions for executors to pass UNC tests!
You can run the script to see how much functions we support.

We are also on [ScriptBlox](https://scriptblox.com/script/Universal-Script-Working-Functions-For-Executors-200587)!

# How To Load
Easy! Just run this code in your executor:
```lua
loadstring(game:HttpGet("https://github.com/lunar0x4/getgenv-functions/raw/refs/heads/main/aio.lua"))()
```

## Supported Functions
### Cache Library
- cache.invalidate
- cache.iscached
- cache.replace

### Crypt Library
- crypt.base64encode
- crypt.base64decode
- crypt.decrypt
- crypt.encrypt
- crypt.generatebytes
- crypt.generatekey
- crypt.hash

### Debug Library
- debug.getconstant
- debug.getconstants
- debug.getinfo
- debug.getstack
- debug.getproto
- debug.getprotos

### Filesystem
- writefile
- readfile
- appendfile
- makefolder
- isfile
- isfolder
- delfile
- delfolder
- listfiles
- loadfile
- dofile

## Other Functions
- cloneref
- compareinstances
- filtergc
- getgc
- gethiddenproperty
- sethiddenproperty
- getrunningscripts
- hookfunction
- hookmetamethod
- isrbxactive

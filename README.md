# HookingService
**A simple module to spoof and hook instances and values in roblox.**
# Documentation
### Hook
**Hooks one function to the other.**
```html
<void> HookingService:Hook(<function> a, <function> b)
```
### Disable Connection
**Disables the connection from firing.**
```html
<void> HookingService:DisableConnection(<RBXScriptSignal> Signal)
```
### Index Spoof
**Changes what the client sees the value as.**
```html
<void> HookingService:IndexSpoof(<Instance> Object, <string> Property, <?> Value)
```
### Name Call Spoof
**Disables the object from firing with a method.**
```html
<void> HookingService:NameCallSpoof(<Instance> Object, <string> Method)
```
### Hook Remote
**Changes what the remote send to the server when it is fired.**
```html
<void> HookingService:HookRemote(<Instance> Remote, <function> Function)
```
### Protect Gui
**Protects the gui from getting detected by the game.**
```html
<void> HookingService:ProtectGui(<Instance> Object)
```

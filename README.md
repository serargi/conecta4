# conecta4
Conecta4 - Multiplayer server

Depending on SO version, DLLs should be in:
- C:\Windows\system32
- C:\Windows\syswow64

If you have problems registering DLL use:
- Regsvr32 c:\windows\system32\MSFLXGRD.ocx
- Regsvr32 c:\windows\system32\mswinsck.ocx

Using client, you have also to edit server.txt
- Change 192.168.1.100 for your server IP address (could be local or public IP)

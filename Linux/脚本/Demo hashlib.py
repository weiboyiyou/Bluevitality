[root@localhost tmp]# python
Python 2.7.5 (default, Nov  6 2016, 00:28:07) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-11)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import hashlib
>>> encrypt=hashlib.sha512()
>>> encrypt.update(bytes('被加密的数据'))
>>> encrypt.hexdigest() 
'235f6fbc988cab61bf61b46d4de5e6465fe26605c332bcf805cedd3069dc520e57ee114f2a9b4b5dbbc44c5a92d039506c3e2a2ab22318164264ee71cac7dba8'

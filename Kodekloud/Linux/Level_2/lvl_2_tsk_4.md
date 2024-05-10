# Linux String Substitute (sed)
There is some data on Nautilus App Server 3 in Stratos DC. Data needs to be altered in several of the files. On Nautilus App Server 3, alter the /home/BSD.txt file as per details given below:


a. Delete all lines containing word __software__ and save results in /home/BSD_DELETE.txt file. (Please be aware of case sensitivity)


b. Replace all occurrence of word __from__ to __is__ and save results in /home/BSD_REPLACE.txt file.


Note: Let's say you are asked to replace word to with from. In that case, make sure not to alter any words containing the string itself; for example upto, contributor etc.

### Решение

```bash

[banner@stapp03 home]$ sed '/software/Id' BSD.txt > /home/BSD_DELETE.txt

[banner@stapp03 home]$ sed 's/\bfrom\b/is/g' BSD.txt > /home/BSD_REPLACE.txt
```




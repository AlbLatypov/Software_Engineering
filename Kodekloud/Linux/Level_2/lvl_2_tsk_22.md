# Linux GPG Encryption

We have confidential data that needs to be transferred to a remote location, so we need to encrypt that data.We also need to decrypt data we received from a remote location in order to understand its content.


On storage server in Stratos Datacenter we have private and public keys stored at /home/*_key.asc. Use these keys to perform the following actions.


- Encrypt /home/encrypt_me.txt to /home/encrypted_me.asc.


- Decrypt /home/decrypt_me.asc to /home/decrypted_me.txt. (Passphrase for decryption and encryption is kodekloud).


- The user ID you can use is kodekloud@kodekloud.com.


### Решение

Подключился. Ключи вижу.

```bash
[root@ststor01 home]# ls -la
total 32
drwxr-xr-x 1 root    root    4096 May 20 23:02 .
drwxr-xr-x 1 root    root    4096 May 20 23:02 ..
drwx------ 1 ansible ansible 4096 Mar  6  2023 ansible
-rw-r--r-- 1 root    root     155 May 20 22:28 decrypt_me.asc
-rw-r--r-- 1 root    root      99 May 20 23:02 encrypt_me.txt
drwx------ 1 natasha natasha 4096 Oct 17  2023 natasha
-rw-r--r-- 1 root    root    3589 May 20 23:02 private_key.asc
-rw-r--r-- 1 root    root    1722 May 20 23:02 public_key.asc

[root@ststor01 home]# gpg --decrypt decrypt_me.asc > decrypted_me.txt

```

Импортируем ключи. При импорте приватного указать фразу обязательно!

```bash
[root@ststor01 home]# gpg --import public_key.asc 
gpg: key 8F17F26ECCE3AF51: "kodekloud <kodekloud@kodekloud.com>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1

[root@ststor01 home]# gpg --import private_key.asc 
gpg: key 8F17F26ECCE3AF51: "kodekloud <kodekloud@kodekloud.com>" not changed
gpg: key 8F17F26ECCE3AF51: secret key imported
gpg: Total number processed: 1
gpg:              unchanged: 1
gpg:       secret keys read: 1
gpg:   secret keys imported: 1
```

Шифруем:
```bash
[root@ststor01 home]# gpg -se -r kodekloud@kodekloud.com --output encrypt_me.asc encrypt_me.txt 
gpg: DD6B8506865C070D: There is no assurance this key belongs to the named user

sub  rsa2048/DD6B8506865C070D 2020-01-19 kodekloud <kodekloud@kodekloud.com>
 Primary key fingerprint: FEA8 5011 C456 B5E9 AE5A  516F 8F17 F26E CCE3 AF51
      Subkey fingerprint: 7B4B 5CFC 5E4F B4B6 EEC0  83E5 DD6B 8506 865C 070D

It is NOT certain that the key belongs to the person named
in the user ID.  If you *really* know what you are doing,
you may answer the next question with yes.

Use this key anyway? (y/N) yq
```
- -s, --sign                  make a signature
- -e, --encrypt               encrypt data
- -r, --recipient USER-ID     encrypt for USER-ID


НЕВЕРНО!

 `- '/home/encrypted_me.asc' doesn't exist on Storage Server`

 Название файла неправильно указал. Но по сути действия верные.




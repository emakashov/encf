# encf

Simple script for encryption and decryption files with aes-256-cbc cipher using openssl

Usage example: 

```
$ ./encf.sh -e foo.txt
enter aes-256-cbc encryption password:
Verifying - enter aes-256-cbc encryption password:
Encrypted file foo.txt.dec
$ cat foo.txt.dec
U2FsdGVkX1+aXWeXM/LLHRKVtmRRFh1oaiBZsudr5/o=
$ ./encf.sh -d foo.txt.dec
enter aes-256-cbc decryption password:
Decrypted file foo.txt
$ cat foo.txt
bar
```

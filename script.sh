# Create 1MB test file
dd if=/dev/urandom of=input.txt bs=1M count=1

# 3DES ECB Encryption
time openssl enc -des-ede3 -in input.txt -out output_3des_ecb.txt -e -nosalt -pbkdf2 -k "mykey123"

# AES-128 ECB Encryption  
time openssl enc -aes-128-ecb -in input.txt -out output_aes128_ecb.txt -e -nosalt -pbkdf2 -k "mykey123"

# AES-256 ECB Encryption
time openssl enc -aes-256-ecb -in input.txt -out output_aes256_ecb.txt -e -nosalt -pbkdf2 -k "mykey123"

# AES-128 CBC Encryption
time openssl enc -aes-128-cbc -in input.txt -out output_aes128_cbc.txt -e -nosalt -pbkdf2 -k "mykey123"

# AES-256 CBC Encryption
time openssl enc -aes-256-cbc -in input.txt -out output_aes256_cbc.txt -e -nosalt -pbkdf2 -k "mykey123"

# Verify file sizes
ls -la input.txt output*.txt

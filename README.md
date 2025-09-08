# Encryption Performance Comparison - 3DES vs AES

## Overview
This analysis compares the performance of different encryption algorithms using OpenSSL commands in Kali Linux to benchmark:
- **3DES in ECB mode**
- **AES-128 in ECB mode** 
- **AES-256 in ECB mode**
- **AES-128 in CBC mode**
- **AES-256 in CBC mode**

## Methodology

### Test Environment
- **Operating System**: Kali Linux 2024.4 (VMware)
- **Tool Used**: OpenSSL with `time` command for performance measurement
- **Test File**: 1MB random data file generated using `dd if=/dev/urandom of=input.txt bs=1M count=1`
- **Encryption Key**: Fixed key "mykey123" for consistent testing

### Commands Executed

```bash
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
```

## Results

### Performance Comparison Table

| Algorithm | Mode | Real Time (s) | User Time (s) | Sys Time (s) | CPU Usage |
|-----------|------|---------------|---------------|--------------|-----------|
| 3DES | ECB | 0.11 | 0.05 | 0.06 | 98% |
| AES-128 | ECB | 0.02 | 0.01 | 0.00 | 98% |
| AES-256 | ECB | 0.02 | 0.01 | 0.00 | 98% |
| AES-128 | CBC | 0.02 | 0.01 | 0.01 | 98% |
| AES-256 | CBC | 0.02 | 0.02 | 0.00 | 98% |

### Screenshots

<img width="887" height="738" alt="Screenshot 2025-09-07 at 10 12 57 PM" src="https://github.com/user-attachments/assets/c73b0bc3-ce04-4899-807a-b9f69a05d34b" />

<img width="548" height="134" alt="Screenshot 2025-09-07 at 10 15 31 PM" src="https://github.com/user-attachments/assets/28495b3f-46a2-4f70-8b12-6b396d77d6b3" />


## Analysis and Observations

### Key Performance Findings

1. **3DES is significantly slower than AES algorithms**
   - 3DES: 0.11 seconds (real time)
   - All AES variants: 0.02 seconds (real time)
   - **Performance difference: 3DES is 5.5x slower than AES**

2. **AES algorithms show consistent performance regardless of key size**
   - AES-128 and AES-256 performed almost identically
   - Minimal difference between ECB and CBC modes for this file size

3. **CPU utilization was consistently high (98%) across all algorithms**
   - Indicates efficient processor utilization
   - Modern systems handle these encryption tasks well

### Technical Explanations

#### Why 3DES is Slower
- **Triple Encryption Process**: 3DES encrypts data three times using the DES algorithm
- **56-bit effective key size**: Despite using 168-bit keys, effective security is only 56 bits due to key scheduling
- **Legacy algorithm**: Not optimized for modern processor architectures
- **Block size**: Uses 64-bit blocks compared to AES's 128-bit blocks

#### Why AES is Faster
- **Hardware Acceleration**: Modern CPUs include AES-NI (Advanced Encryption Standard New Instructions)
- **Efficient Algorithm Design**: Single-pass encryption with optimized mathematical operations
- **Larger block size**: 128-bit blocks are more efficient for bulk data encryption
- **Better parallelization**: Can take advantage of modern multi-core processors

#### ECB vs CBC Mode Comparison
- **Minimal performance difference** observed for 1MB file
- ECB mode is theoretically faster (no chaining overhead)
- CBC mode adds initialization vector processing but difference is negligible for this file size
- **Security note**: ECB mode is less secure due to pattern preservation in encrypted data

### Security vs Performance Trade-offs

1. **3DES**: Slowest but still considered secure for legacy applications
2. **AES-128**: Fast and secure for most applications (recommended minimum)
3. **AES-256**: Slightly more CPU intensive but provides maximum security
4. **CBC Mode**: More secure than ECB mode with minimal performance penalty

## Conclusions

1. **AES significantly outperforms 3DES** in encryption speed while providing better security
2. **Key size impact on AES performance is minimal** - AES-256 vs AES-128 showed negligible difference
3. **Mode of operation (ECB vs CBC) has minimal impact** on performance for files of this size
4. **Hardware acceleration makes AES the clear choice** for modern applications requiring bulk encryption
5. **3DES should be avoided** in new implementations due to both performance and security limitations

## Recommendations

- **Use AES-256 in CBC mode** for optimal security with excellent performance
- **Avoid 3DES** for new applications unless required for legacy compatibility
- **Consider file size impact** - larger files may show more pronounced differences between algorithms
- **Hardware acceleration** should be utilized when available for optimal AES performance

## Environment Details
- **System**: Kali Linux 2024.4-vmware-amd64
- **OpenSSL Version**: [Include version from `openssl version`]
- **Test Date**: September 7, 2025
- **Hardware**: VMware virtual machine

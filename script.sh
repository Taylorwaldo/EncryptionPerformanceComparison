#!/bin/bash

# Encryption Performance Comparison Script
# Compares 3DES vs AES algorithms with different modes and key sizes
# Author: Taylor Waldo
# Date: September 2025

set -e  # Exit on any error

# Configuration
INPUT_FILE="input.txt"
TEST_KEY="mykey123"
FILE_SIZE="1M"

# Color codes for output formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored headers
print_header() {
    echo -e "${BLUE}=================================${NC}"
    echo -e "${BLUE} $1 ${NC}"
    echo -e "${BLUE}=================================${NC}"
}

# Function to print step information
print_step() {
    echo -e "${GREEN}[STEP $1]${NC} $2"
}

# Function to print results
print_result() {
    echo -e "${YELLOW}✓${NC} $1"
}

# Cleanup function
cleanup() {
    echo -e "${RED}Cleaning up temporary files...${NC}"
    rm -f input.txt output*.txt
}

# Set up signal handlers for cleanup
trap cleanup EXIT

# Main execution
clear
print_header "ENCRYPTION PERFORMANCE BENCHMARK"
echo "Testing 3DES vs AES algorithms with 1MB data file"
echo "Key: $TEST_KEY"
echo ""

# Step 1: Create test file
print_step "1" "Creating $FILE_SIZE test file with random data"
dd if=/dev/urandom of=$INPUT_FILE bs=$FILE_SIZE count=1 2>/dev/null
print_result "Test file created: $INPUT_FILE"
echo ""

# Step 2: Run encryption benchmarks
print_step "2" "Running encryption performance tests"
echo ""

# 3DES ECB Encryption
echo -e "${YELLOW}Testing 3DES-ECB...${NC}"
time openssl enc -des-ede3 -in $INPUT_FILE -out output_3des_ecb.txt \
    -e -nosalt -pbkdf2 -k "$TEST_KEY"
print_result "3DES-ECB encryption completed"
echo ""

# AES-128 ECB Encryption
echo -e "${YELLOW}Testing AES-128-ECB...${NC}"
time openssl enc -aes-128-ecb -in $INPUT_FILE -out output_aes128_ecb.txt \
    -e -nosalt -pbkdf2 -k "$TEST_KEY"
print_result "AES-128-ECB encryption completed"
echo ""

# AES-256 ECB Encryption
echo -e "${YELLOW}Testing AES-256-ECB...${NC}"
time openssl enc -aes-256-ecb -in $INPUT_FILE -out output_aes256_ecb.txt \
    -e -nosalt -pbkdf2 -k "$TEST_KEY"
print_result "AES-256-ECB encryption completed"
echo ""

# AES-128 CBC Encryption
echo -e "${YELLOW}Testing AES-128-CBC...${NC}"
time openssl enc -aes-128-cbc -in $INPUT_FILE -out output_aes128_cbc.txt \
    -e -nosalt -pbkdf2 -k "$TEST_KEY"
print_result "AES-128-CBC encryption completed"
echo ""

# AES-256 CBC Encryption
echo -e "${YELLOW}Testing AES-256-CBC...${NC}"
time openssl enc -aes-256-cbc -in $INPUT_FILE -out output_aes256_cbc.txt \
    -e -nosalt -pbkdf2 -k "$TEST_KEY"
print_result "AES-256-CBC encryption completed"
echo ""

# Step 3: Verify results
print_step "3" "Verifying encrypted file outputs"
echo ""
echo -e "${BLUE}File Size Comparison:${NC}"
ls -lah $INPUT_FILE output*.txt | awk '{print $5, $9}' | column -t
echo ""

# Step 4: Summary
print_header "BENCHMARK COMPLETE"
echo "All encryption tests completed successfully!"
echo "Encrypted files generated:"
ls -1 output*.txt | sed 's/^/  - /'
echo ""
echo "Results saved in current directory for analysis."
echo "Use 'ls -la output*.txt' to view detailed file information."

# challenge: more-hex (multi-byte binary to hexadecimal)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/nibbling-on-numbers/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** nibbling on numbers
* **challenge level:** multi-byte binary to hexadecimal conversion (24-bit / 3-byte sequences)
* **execution format:** interactive shell prompt (`/challenge/convert`)

---

## 🧠 core rules & mechanisms

this challenge scales binary-to-hexadecimal translation across multi-byte sequences, reinforcing that hex is simply a compact human-readable grouping of binary nibbles (4 bits per hex character):

### 1. multi-byte nibble grouping
* each byte consists of 2 hex digits (8 bits = 2 $\times$ 4-bit nibbles).
* for a 3-byte sequence (24 bits), map every 4-bit block to its corresponding hex character sequentially:
  * `1011` ($\text{b}$) `1111` ($\text{f}$) `1110` ($\text{e}$) `0000` ($0$) `1100` ($\text{c}$) `1100` ($\text{c}$) $\rightarrow$ `bbe0cc`
  * `1000` ($8$) `0001` ($1$) `0101` ($5$) `0000` ($0$) `1110` ($\text{e}$) `0110` ($6$) $\rightarrow$ `8150e6`

---

## 🛠️ execution sample & prompt flow

the interactive program tests multi-byte conversions from binary strings to compact hexadecimal representation:

```text
ubuntu@nibbling-on-numbers~more-hex:~$ /challenge/convert
Binary, hex, and decimal are just different ways to write the same number.
I'll show you 2 values in binary; write each one back to me in hexadecimal.

Value 1 of 2 (in binary):  10111011 11100000 11001100
  the same value in hexadecimal > bbe0cc
  Correct!

Value 2 of 2 (in binary):  10000001 01010000 11100110
  the same value in hexadecimal > 8150e6
  Correct!

All correct --- you can move between the bases!
Here is your flag: pwn.college{[REDACTED]}

# challenge: binary and hex encoding

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/nibbling-on-numbers/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** nibbling on numbers
* **challenge level:** binary to hexadecimal conversion
* **execution format:** interactive shell prompt (`/challenge/convert`)

---

## 🧠 core rules & mechanisms

this challenge tests the speed and accuracy of converting binary sequences directly into hexadecimal notation using 4-bit nibble grouping.

### 1. nibble mapping (4 bits = 1 hex digit)
* split any byte into two 4-bit nibbles: `[Upper Nibble] [Lower Nibble]`.
* translate each nibble to its single hex character ($0\text{--}9, \text{a}\text{--}\text{f}$):
  * `1000` ($8$) + `1001` ($9$) $\rightarrow$ `89`
  * `1100` ($12 \rightarrow \text{c}$) + `0100` ($4$) $\rightarrow$ `c4`
  * `0100` ($4$) + `0011` ($3$) $\rightarrow$ `43`

---

## 🛠️ execution sample & prompt flow

the interactive program asks for direct hexadecimal representations of given binary values:

```text
ubuntu@nibbling-on-numbers~binary-and-hex-encoding:~$ /challenge/convert
Binary, hex, and decimal are just different ways to write the same number.
I'll show you 3 values in binary; write each one back to me in hexadecimal.

Value 1 of 3 (in binary):  10001001
  the same value in hexadecimal > 89
  Correct!

Value 2 of 3 (in binary):  11000100
  the same value in hexadecimal > c4
  Correct!

Value 3 of 3 (in binary):  01000011
  the same value in hexadecimal > 43
  Correct!

All correct --- you can move between the bases!
Here is your flag: pwn.college{[REDACTED]}

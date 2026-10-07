# challenge: negative numbers (16-bit two's complement)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/nibbling-on-numbers/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** nibbling on numbers
* **challenge level:** 16-bit two's complement decoding
* **execution format:** interactive shell prompt (`/challenge/decode`)

---

## 🧠 core rules & mechanisms

this challenge extends two's complement decoding to 2 bytes (16 bits), demonstrating that signed representation scales to any bit-width:

### 1. sign determination (most significant bit - msb)
* the most significant bit (the 16th bit, leftmost) acts as the sign flag.
* **msb = 0:** positive value; signed and unsigned values are identical.
* **msb = 1:** negative value; signed value is negative.

### 2. conversion logic (16-bit width)
* **positive binary (`0xxxxxxxxxxxxxxx`):** 
  $$\text{value} = \text{unsigned sum}$$
* **negative binary (`1xxxxxxxxxxxxxxx`):**
  * **unsigned reading:** calculate standard 16-bit binary sum ($0 \text{ to } 65535$).
  * **signed reading (two's complement):** subtract $2^{16}$ ($65536$) from the unsigned value:
    $$\text{signed value} = \text{unsigned value} - 65536$$

---

## 🛠️ execution sample & prompt flow

the interactive program presents 16-bit binary strings for decoding using Python or calculator utilities as a helper:

```text
ubuntu@nibbling-on-numbers~negative-numbers-16-bit:~$ /challenge/decode
Two's complement works the same at any width --- these are 2 bytes (16 bits) each.
The top bit is still the sign. If it's 0 the value is positive and its signed and
unsigned readings are identical; if it's 1 it's negative, and the signed value is
the unsigned value minus 2**16 (= 65536).

I'll show you 2 of them. Read each one for me.
Value 1 (Positive Example - MSB = 0):
  What number is it? > [unsigned_value]
Correct!

Value 2 (Negative Example - MSB = 1):
  As an UNSIGNED number, what is it? > [unsigned_value]
  As a SIGNED (two's complement) number, what is it? > [signed_value]
Correct!

All correct --- you can read the sign at any width!
Here is your flag: pwn.college{[REDACTED]}

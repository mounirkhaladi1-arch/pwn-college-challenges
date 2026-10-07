# challenge: negative numbers (two's complement)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/nibbling-on-numbers/negative-numbers/)**

---

## 🔗 environment details

* **dojo track:** nibbling on numbers
* **module:** negative numbers
* **challenge level:** 1-byte two's complement decoding
* **execution format:** interactive shell prompt (`/challenge/decode`)

---

## 🧠 core rules & mechanisms

this challenge tests the ability to interpret 8-bit (1-byte) binary sequences as both unsigned integers and signed integers using two's complement representation.

### 1. sign determination (most significant bit - msb)
* the most significant bit (leftmost bit) acts as the sign flag.
* **msb = 0:** positive value; signed and unsigned values are identical.
* **msb = 1:** negative value; signed value is negative.

### 2. conversion logic
* **positive binary (`0xxxxxxx`):** 
  $$\text{value} = \text{unsigned sum}$$
* **negative binary (`1xxxxxxx`):**
  * **unsigned reading:** calculate standard 8-bit binary sum ($0 \text{ to } 255$).
  * **signed reading (two's complement):** 
    $$\text{signed value} = \text{unsigned value} - 256$$

---

## 🛠️ execution sample & prompt flow

the interactive program asks a series of questions based on randomly generated 8-bit binary numbers:

```text
ubuntu@nibbling-on-numbers~negative-numbers:~$ /challenge/decode
Two's complement works the same at any width --- these are 1 byte (8 bits) each.
The top bit is still the sign. If it's 0 the value is positive and its signed and
unsigned readings are identical; if it's 1 it's negative, and the signed value is
the unsigned value minus 2**8 (= 256).

I'll show you 4 of them. Read each one for me.
Value 1 (Positive Example - MSB = 0):
  The top bit is clear, so it's positive.
  What number is it? > [unsigned_value]
Correct!

Value 2 (Negative Example - MSB = 1):
  The top bit is set, so it's negative.
  As an UNSIGNED number, what is it? > [unsigned_value]
  As a SIGNED (two's complement) number, what is it? > [signed_value]
Correct!

...
Correct!

All correct --- you can read the sign at any width!
Here is your flag: pwn.college{[REDACTED]}

# challenge: encoding negatives (two's complement)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/nibbling-on-numbers/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** nibbling on numbers
* **challenge level:** 8-bit two's complement encoding
* **execution format:** interactive shell prompt (`/challenge/encode`)

---

## 🧠 core rules & mechanisms

this challenge reverses the process by encoding decimal integers into 8-bit (1-byte) two's complement binary strings.

### 1. zero or positive numbers ($\ge 0$)
* convert the decimal number directly into standard binary.
* pad with leading zeros to fill the full 8-bit (1-byte) width.

### 2. negative numbers ($< 0$)
* **method 1 (unsigned addition):** add $2^8$ ($256$) to the negative value to get its unsigned equivalent, then convert to 8-bit binary:
  $$\text{unsigned value} = \text{negative value} + 256$$
* **method 2 (bit inversion + 1):** take the absolute positive value in binary, flip all bits (bitwise NOT), and add $1$.

---

## 🛠️ execution sample & prompt flow

the interactive program asks for 8-bit two's complement binary representations of given decimal values:

```text
ubuntu@nibbling-on-numbers~encoding-negatives:~$ /challenge/encode
Now the other direction: I give you a number, and you encode it in 8-bit
two's complement, written in binary.
A zero-or-positive number is just its plain binary. For a negative number, its
8-bit pattern is the same bits as the unsigned value (the number + 256), so its
top bit ends up set.

I'll give you 4 numbers. Write each one's 8-bit binary.

Number 1 (Negative Example):
  as 8-bit two's-complement binary > [8bit_binary_string]
Correct!

Number 2 (Positive Example):
  as 8-bit two's-complement binary > [8bit_binary_string]
Correct!

...
Correct!

All correct --- you can write two's complement!
Here is your flag: pwn.college{[REDACTED]}

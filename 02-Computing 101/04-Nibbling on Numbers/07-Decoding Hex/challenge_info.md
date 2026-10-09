# challenge: decoding-hex (hexadecimal to binary conversion)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/nibbling-on-numbers/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** nibbling on numbers
* **challenge level:** hexadecimal to binary decoding (1-byte values)
* **execution format:** interactive shell prompt (`/challenge/convert`)

---

## 🧠 core rules & mechanisms

this challenge reverses the previous workflow: given a 2-digit hexadecimal byte, expand each hex character directly into its corresponding 4-bit binary nibble.

### 1. hex-to-nibble expansion
* split the hex byte into upper and lower characters.
* map each character to its 4-bit binary equivalent ($0\text{--}\text{f}$):
  * `42` $\rightarrow$ `4` (`0100`) + `2` (`0010`) $\rightarrow$ `01000010`
  * `d7` $\rightarrow$ `d` ($13 \rightarrow$ `1101`) + `7` (`0111`) $\rightarrow$ `11010111`
  * `27` $\rightarrow$ `2` (`0010`) + `7` (`0111`) $\rightarrow$ `00100111`

---

## 💡 execution & mental workflow

for single-byte conversions, direct mental lookup is faster than shelling out to python:
* evaluate high nibble first, pad with leading zero if necessary (e.g., `4` = `0100`).
* evaluate low nibble and concatenate into a full 8-bit byte string.

```text
ubuntu@nibbling-on-numbers~decoding-hex:~$ /challenge/convert
Binary, hex, and decimal are just different ways to write the same number.
I'll show you 3 values in hexadecimal; write each one back to me in binary.

Value 1 of 3 (in hexadecimal):  42
  the same value in hexadecimal > 01000010
  Correct!

Value 2 of 3 (in hexadecimal):  d7
  the same value in hexadecimal > 11010111
  Correct!

Value 3 of 3 (in hexadecimal):  27
  the same value in hexadecimal > 00100111
  Correct!

All correct --- you can move between the bases!
Here is your flag: pwn.college{[REDACTED]}

# challenge: mixed-conversions (comprehensive byte representations)

## 🛠️ quick access

👉 **[direct link to challenge](https://pwn.college/computing-101/nibbling-on-numbers/)**

---

## 🔗 environment details

* **dojo track:** computing 101
* **module:** nibbling on numbers
* **challenge level:** full byte translation (mixed formats)
* **execution format:** interactive shell prompt (`/challenge/mixed`)

---

## 🧠 core rules & mechanisms

this challenge tests full fluidity across all four fundamental representations of a single byte:
1. **unsigned decimal:** $0 \text{ to } 255$
2. **signed decimal (two's complement):** $-128 \text{ to } 127$
3. **hexadecimal:** `00` to `ff` (two nibbles)
4. **binary:** `00000000` to `11111111` (8 bits)

### 1. key conversion relationships
* **signed $\leftrightarrow$ unsigned link:** $\text{unsigned} = \text{signed} + 256$ (when negative).
  * e.g., $-64 + 256 = 192$ (`0xc0` / `11000000`).
* **signed MSB check:** if MSB ($2^7$) is $1$, the value is negative in signed decimal.
  * e.g., `11000100` ($196$) $\rightarrow 196 - 256 = -60$.

---

## 💡 execution & mental workflow

* **mental shortcut for negative signed values:** calculate $256 - \vert{}x\vert{}$ to get the unsigned decimal equivalent immediately, then convert to hex/binary via nibbles.
* **error correction log:** when calculating binary for $-64$, initial mental slip skipped the lower nibble boundary ($10100000 \rightarrow 11000000$). self-corrected directly in prompt.

```text
ubuntu@nibbling-on-numbers~mixed-conversions:~$ /challenge/mixed
The whole point, all at once. A single byte can be written four ways:
  - an UNSIGNED decimal number, 0 to 255
  - a SIGNED decimal number, -128 to 127 (two's complement)
  - two HEX digits
  - eight BINARY bits
I'll show you 4 bytes. For each, write it in all three of the other forms.

SOURCE Value 1 of 4:  -64    [signed decimal]
  CONVERT THE SOURCE VALUE TO BINARY > 11000000
  Correct!
  CONVERT THE SOURCE VALUE TO UNSIGNED DECIMAL > 192
  Correct!
  CONVERT THE SOURCE VALUE TO HEX > c0
  Correct!

SOURCE Value 2 of 4:  146    [unsigned decimal]
  CONVERT THE SOURCE VALUE TO BINARY > 10010010
  Correct!
  CONVERT THE SOURCE VALUE TO HEX > 92
  Correct!
  CONVERT THE SOURCE VALUE TO SIGNED DECIMAL > -110
  Correct!

SOURCE Value 3 of 4:  c3    [hex]
  CONVERT THE SOURCE VALUE TO UNSIGNED DECIMAL > 195
  Correct!
  CONVERT THE SOURCE VALUE TO SIGNED DECIMAL > -61
  Correct!
  CONVERT THE SOURCE VALUE TO BINARY > 11000111
  Correct!

SOURCE Value 4 of 4:  11000100    [binary]
  CONVERT THE SOURCE VALUE TO UNSIGNED DECIMAL > 196
  Correct!
  CONVERT THE SOURCE VALUE TO SIGNED DECIMAL > -60
  Correct!
  CONVERT THE SOURCE VALUE TO HEX > c4
  Correct!

All correct --- you can move a byte between any of its forms!
Here is your flag: pwn.college{[REDACTED]}

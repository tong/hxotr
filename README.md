
HXOTR
=====
Haxe Off-the-Record (OTR) library.

http://www.cypherpunks.ca/otr/
https://github.com/arlolra/otr

---

### Warning

This library hasn't been properly vetted by security researchers.
Do not use in life and death situations!

---

Private conversations over instant messaging by providing:
 * Encryption
   No one else can read your instant messages.
 * Authentication
   You are assured the correspondent is who you think it is.
 * Deniability
   The messages you send do not have digital signatures that are checkable by a third party. Anyone can forge messages after a conversation to make them look like they came from you. However, during a conversation, your correspondent is assured the messages he sees are authentic and unmodified.
 * Perfect forward secrecy
   If you lose control of your private keys, no previous conversation is compromised.


The published web site for this repository is at [https://borisbaldassari.github.io/data-anonymiser/](https://borisbaldassari.github.io/data-anonymiser/).

> **Announce: Reviews are needed! Help us make the world a safer place!**
> We aim to provide several software-related data sets, which include personal data from developers and contributors. We need people to review this anonymisation module to make sure the anonymisation process is safe, both privacy-wise and research-wise (i.e. anonymised data are still useful). Please try these functions, use them, abuse them, and [contact us](https://github.com/borisbaldassari/data-anonymiser/issues) if you have any concern or question. 

# Anonymise utilities

This Perl module provides utilities to anonymise data, in the context of dataset generation. The idea basically is to encrypt the data with a private/public key system and then throw away the keys. It has the following properties:

* Retrieving the original data is close to impossible, according to current cryptographic systems. One can still, for debugging purposes, get the original data back if the key is saved. For production or final releases the key should not be saved anywhere to ensure privacy.
* It still preserves one-to-one relationship between original data and encrypted data, with as little collisions as possible. This is especially useful for research analysis, where one can detect identical items without knowing the protected data.

It is ok to truncate hashes, and encoding base64 makes the collision risk a bit lower. For a good explanation see [hash function that produces short hashes](https://stackoverflow.com/questions/4567089/hash-function-that-produces-short-hashes) on StackOverflow.


## Module description

Canonical example:
```
use Anonymise::Utilities;

my $utils = Anonymise::Utilities->new();
$utils->create_keys();

# Get a 16 chars scrambled string
my $scrambled = $utils->scramble_string("blablabla");

# Get a full-size binary-encoded string
my $scrambled = $utils->scramble_string("blablabla");

# Get a full-size base64-encoded string
my $scrambled = $utils->scramble_string("blablabla");
```

The Perl module offers the following functions:

* **scramble_string($str)** Returns a 16 chars anonymised string. Several runs on the same input string will always return the same scrambled string.

* **encode_string($str)** Returns a full-size (512 chars) string encoded using the private key. The returned string will most likely contain binary characters. Several runs on the same input string will always return the same string.

* **encode_string_base64($str)** Returns a full-size (692 chars) string encoded using the private key and then encoded in base64. The returned string will not contain any binary characters. Several runs on the same input string will always return the same scrambled string.


## Roadmap

We plan on having specific functions for specific data types, e.g. email addresses.


## Technical reauirements

The  Perl module requires `Crypt::PK::RSA`.

## Functional requirements

In our use case we want to be able to anonymise the following types of data:

* UUIDs, whatever they are.
* Email addresses
* Java classes (by class? or by full path?)

We want to have a one-to-one relationship from original data to encrypted data, so as to identify identical entries without knowing them.

We want a method that prevent any reconstruction of the original data, according to the current state of research on privacy.


## Test output

Perl tests output:

```
boris@kadath:code$ perl -I. t/00_utilities.t
ok 1 - use Anonymise::Utilities;
ok 2 - An object of class 'Anonymise::Utilities' isa 'Anonymise::Utilities'
# Create keys.
ok 3 - Public key starts with MII...
ok 4 - Public key has length 746.
ok 5 - Scrambled output for input 1 char is 16 chars long.
ok 6 - Scrambled output for input 9 char is 16 chars long.
ok 7 - Scrambled output for input 86 char is 16 chars long.
ok 8 - Scrambled output for in 471 char is 16 chars long.
ok 9 - Scrambled output for in 701 char is 16 chars long.
ok 10 - Scrambled output for in 931 char is 16 chars long.
ok 11 - Scrambled output for test case is 16 chars long.
ok 12 - Scrambled output for test case 2 is 16 chars long.
ok 13 - Scrambled output for test case 3 is 16 chars long.
ok 14 - Encoded string for input 9 chars is 512 chars long.
ok 15 - Encoded string for input 9 chars is 692 chars long.
ok 16 - Decoded string is equal to original string.
1..16
```

Functions output:

```
* Test create_keys
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0sHCiS8B1x0qLaeuJfLPE49K2fw5x4cp
CoYpjYFECjuxNSEMUA5RlEBD37nesMK6ftEA3dVmtDtroA3EHG5NrbVqXCFKBAksdaLpDGPaemsA
rMKo+D1rNQem6jF/aBPbUydkqXYtsdNe9LQ2NJGPTbxZByMSW9R/YlPLOUO1xW7arh63zMed2W5u
SJFyBroquRw9vJVRhVYDmNJOzL5o7OClOEPPWgv9Riz4/sCWvgX5vEFuCBT8PsXUNmCe8QUE/wzs
Y+BjnQntyrdsMPPVcRhX6wagdHPgcq8A2lnHnLtwMewfBWT38BiACp5scPHOu+hyB76YJsIMNJtC
25yc/QIDAQAB

* Test scramble_string => 16 chars
XMOx+PZLA15tKvEB
* Test encode_string => 256 chars
[SNIP -- github-flavoured markdown doesn't like weird chars]
* Test encode_string_base64 => 348 chars
bM0ekgWEYIroYPioZ7qZO2iR5L0dfPKfd6pptwHXc+qBqkJd5uIG4BBzFm8I4xVeKXv3Haf/xpx4
3pRVw6FCS8kEWcfevsn8AQX1Pf37eMgLxVP3t0CZ4dPHmNB28AMAJaKr5v5jII+lYrsKqeRjWQ8Z
RFKLfwyxnn9R9TPpaBL0S+QRgNIybp/m6bQ5POBOlvcHer5wtmSGbCTFMXF54ZT90DkpOD/gVGtx
YmLgfEWqKmXjjm+mXMkqPlFKHarJB0A22mA6yKAgrfEi3gjaofbZ6z3SLOR44YKM0RJFHNM5DV/p
qTp2O1pgQI8iHrm+t18vcSzt7lqkhsmBHhpmKQ==
* Test decode_string => 9 chars
BLABLABLA
```

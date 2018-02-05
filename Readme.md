
# Presentation

This Perl module provides utilities to anonymise data, in the context of dataset generation. The idea basically is to encrypt the data with a private/public key system and then throw away the keys. It has the following properties:

* Retrieving the original data is close to impossible, according to current cryptographic systems. One can still, for debugging purposes, get the original data back if the key is saved. For production or final releases the key should not be saved anywhere to ensure privacy.
* It still preserves one-to-one relationship between original data and encrypted data, with as little collisions as possible. This is especially useful for research analysis, where one can detect identical items without knowing the protected data.

It is ok to truncate hashes, and encoding base64 makes the collision risk a bit lower. For a good explanation see [hash function that produces short hashes](https://stackoverflow.com/questions/4567089/hash-function-that-produces-short-hashes) on StackOverflow.

# Requirements

In our use case we want to be able to anonymise the following types of data:

* UUIDs, whatever they are.
* Email addresses
* Java classes (by class? or by full path?)

We want to have a one-to-one relationship from original data to encrypted data, so as to identify identical entries without knowing them.

We want a method that prevent any reconstruction of the original data, according to the current state of research on privacy.

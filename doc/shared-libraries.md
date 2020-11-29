Shared Libraries
================

## supermanconsensus

The purpose of this library is to make the verification functionality that is critical to Superman's consensus available to other applications, e.g. to language bindings.

### API

The interface is defined in the C header `supermanconsensus.h` located in `src/script/supermanconsensus.h`.

#### Version

`supermanconsensus_version` returns an `unsigned int` with the API version *(currently `1`)*.

#### Script Validation

`supermanconsensus_verify_script` returns an `int` with the status of the verification. It will be `1` if the input script correctly spends the previous output `scriptPubKey`.

##### Parameters
- `const unsigned char *scriptPubKey` - The previous output script that encumbers spending.
- `unsigned int scriptPubKeyLen` - The number of bytes for the `scriptPubKey`.
- `const unsigned char *txTo` - The transaction with the input that is spending the previous output.
- `unsigned int txToLen` - The number of bytes for the `txTo`.
- `unsigned int nIn` - The index of the input in `txTo` that spends the `scriptPubKey`.
- `unsigned int flags` - The script validation flags *(see below)*.
- `supermanconsensus_error* err` - Will have the error/success code for the operation *(see below)*.

##### Script Flags
- `supermanconsensus_SCRIPT_FLAGS_VERIFY_NONE`
- `supermanconsensus_SCRIPT_FLAGS_VERIFY_P2SH` - Evaluate P2SH ([BIP16](https://github.com/superman/bips/blob/master/bip-0016.mediawiki)) subscripts
- `supermanconsensus_SCRIPT_FLAGS_VERIFY_DERSIG` - Enforce strict DER ([BIP66](https://github.com/superman/bips/blob/master/bip-0066.mediawiki)) compliance
- `supermanconsensus_SCRIPT_FLAGS_VERIFY_NULLDUMMY` - Enforce NULLDUMMY ([BIP147](https://github.com/superman/bips/blob/master/bip-0147.mediawiki))
- `supermanconsensus_SCRIPT_FLAGS_VERIFY_CHECKLOCKTIMEVERIFY` - Enable CHECKLOCKTIMEVERIFY ([BIP65](https://github.com/superman/bips/blob/master/bip-0065.mediawiki))
- `supermanconsensus_SCRIPT_FLAGS_VERIFY_CHECKSEQUENCEVERIFY` - Enable CHECKSEQUENCEVERIFY ([BIP112](https://github.com/superman/bips/blob/master/bip-0112.mediawiki))
- `supermanconsensus_SCRIPT_FLAGS_VERIFY_WITNESS` - Enable WITNESS ([BIP141](https://github.com/superman/bips/blob/master/bip-0141.mediawiki))

##### Errors
- `supermanconsensus_ERR_OK` - No errors with input parameters *(see the return value of `supermanconsensus_verify_script` for the verification status)*
- `supermanconsensus_ERR_TX_INDEX` - An invalid index for `txTo`
- `supermanconsensus_ERR_TX_SIZE_MISMATCH` - `txToLen` did not match with the size of `txTo`
- `supermanconsensus_ERR_DESERIALIZE` - An error deserializing `txTo`
- `supermanconsensus_ERR_AMOUNT_REQUIRED` - Input amount is required if WITNESS is used

### Example Implementations
- [NSuperman](https://github.com/NicolasDorier/NSuperman/blob/master/NSuperman/Script.cs#L814) (.NET Bindings)
- [node-libsupermanconsensus](https://github.com/bitpay/node-libsupermanconsensus) (Node.js Bindings)
- [java-libsupermanconsensus](https://github.com/dexX7/java-libsupermanconsensus) (Java Bindings)
- [supermanconsensus-php](https://github.com/Bit-Wasp/supermanconsensus-php) (PHP Bindings)

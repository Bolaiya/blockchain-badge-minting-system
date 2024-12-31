# Clarity Badge Minting System Smart Contract

## Overview
The Badge Issuer Smart Contract is a decentralized application (DApp) built using the Clarity language, designed for issuing and managing non-fungible tokens (NFTs) representing badges. The contract provides functionality for issuing individual and batch badges, retrieving badge metadata, querying badge ownership, and ensuring data validation and security.

This contract is specifically designed for a contract owner to have exclusive control over badge issuance, ensuring that only valid metadata is used and limiting the size of batch issuance to prevent overload. Badges are minted sequentially, ensuring unique badge IDs for every new badge issued.

## Features
- **Single Badge Issuance**: The contract allows the owner to issue badges one at a time with associated metadata.
- **Batch Badge Issuance**: The contract supports issuing badges in batches with metadata, limiting the batch size to a maximum of 50 badges.
- **Metadata Validation**: Ensures that badge metadata is valid (length between 1 and 256 characters).
- **Badge Ownership**: Each badge minted is associated with an owner, and the contract allows querying the owner of a badge.
- **Badge Metadata**: Badges can be associated with metadata (up to 256 characters), which is stored and can be retrieved.

## Key Functions
- `issue-badge`: Allows the contract owner to issue a single badge with metadata.
- `batch-issue-badges`: Allows the contract owner to issue multiple badges at once, with metadata for each badge.
- `get-badge-metadata`: Retrieves metadata for a specific badge ID.
- `get-owner`: Queries the owner of a specific badge.
- `get-last-badge-id`: Retrieves the ID of the most recently minted badge.

## Contract Details

### Constants
- **contract-owner**: The address of the contract owner (set to the transaction sender).
- **max-batch-size**: The maximum number of badges that can be issued in a single batch (50).

### Error Codes
- **err-owner-only**: Error triggered if a non-owner tries to issue badges.
- **err-badge-exists**: Error triggered if a badge with the given ID already exists.
- **err-badge-not-found**: Error triggered if a badge ID is not found.
- **err-batch-size-too-large**: Error triggered if the batch size exceeds the maximum allowed size.
- **err-invalid-metadata**: Error triggered if the metadata for a badge is invalid.

### Data Variables
- **badge-id**: The non-fungible token representing a badge.
- **last-badge-id**: The ID of the most recently minted badge.

### Maps
- **badge-metadata**: A map that associates badge IDs with their respective metadata.

### Functions
#### Private Functions
- `is-valid-metadata`: Checks whether the provided metadata is valid (length between 1 and 256 characters).
- `mint-single-badge`: Mints a single badge and stores the metadata.
- `mint-single-badge-in-batch`: Mints a single badge as part of a batch issuance.

#### Public Functions
- `issue-badge`: Issues a single badge with metadata, only by the contract owner.
- `batch-issue-badges`: Issues a batch of badges (up to 50), only by the contract owner.
- `get-badge-metadata`: Retrieves the metadata for a given badge ID.
- `get-owner`: Retrieves the owner of a badge by ID.
- `get-last-badge-id`: Retrieves the last minted badge ID.

## Usage
1. **Issue a Badge**:
   ```clarity
   (issue-badge "Badge Metadata Example")
   ```

2. **Batch Issue Badges**:
   ```clarity
   (batch-issue-badges ["Badge 1 Metadata", "Badge 2 Metadata", "Badge 3 Metadata"])
   ```

3. **Get Badge Metadata**:
   ```clarity
   (get-badge-metadata 1)
   ```

4. **Get Badge Owner**:
   ```clarity
   (get-owner 1)
   ```

5. **Get Last Badge ID**:
   ```clarity
   (get-last-badge-id)
   ```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing
If you have suggestions or improvements for the Badge Issuer Smart Contract, feel free to open an issue or submit a pull request.

---

## Installation

To deploy this contract, use a Clarity-compatible blockchain such as Stacks. You can deploy it using the Clarity CLI or integrate it with a web frontend.


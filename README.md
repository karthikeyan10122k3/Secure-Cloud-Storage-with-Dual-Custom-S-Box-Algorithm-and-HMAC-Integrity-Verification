# Secure Cloud Storage with Dual Custom S-Box Algorithm and HMAC Integrity Verification

## Abstract
Technological advancements have necessitated the need for more robust encryption techniques as cyber threats evolve. Security in cloud storage remains a critical issue, especially concerning data privacy and authentication. 

The proposed system introduces an enhanced encryption scheme that combines **Dual Custom S-Box techniques** with **HMAC detection** to improve cloud storage protection. This architecture addresses three primary entities:
- **Data Owners**
- **Data Users**
- **Trusted Authority**

The **Dual Custom S-Box Algorithm** adds encryption strength by creating user-specific S-Boxes, making the encryption process highly unpredictable and complex. The **Trusted Authority** manages user activities, including activation, deactivation, and secure key distribution. Furthermore, **HMAC with the SHA-256 algorithm** ensures data integrity during storage.

This solution enhances **confidentiality**, **integrity**, and **access control** of data in the cloud environment, addressing limitations of existing systems.

---

## Features
- **Custom AES Encryption**: Dual S-Box technique with increased rounds for added security.
- **User-Specific S-Box Generation**: Ensures encryption uniqueness and unpredictability.
- **HMAC-SHA256 Verification**: Ensures data integrity and authenticity.
- **Role-Based Access Control**:
  - **Data Owners**: Manage and encrypt their data.
  - **Data Users**: Access data with proper authorization.
  - **Trusted Authority**: Handles user management and secure key distribution.

---

## Keywords
- AES  
- Encryption  
- Dual S-Box  
- Increased Rounds  
- Data Security  
- Key Generation  
- Cryptography  

---

## Architecture Overview
The system consists of three main components:
1. **Data Owners**: Upload and secure their data using the Dual Custom S-Box Algorithm.  
2. **Data Users**: Access the data with verified permissions.  
3. **Trusted Authority**: Manages secure key generation, distribution, and user lifecycle management.

---

## Benefits
- Enhanced data confidentiality with Dual Custom S-Box Algorithm.  
- Improved data integrity using HMAC-SHA256 verification.  
- Secure user management through a Trusted Authority.  
- Robust defense against modern cyber threats in cloud storage environments.

---

Feel free to contribute or raise issues to improve this project further!

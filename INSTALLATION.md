
# Installation Instructions for BizTalk Server Stored Procedure Scripts

## Overview

This document explains how to install and update the BizTalk Server stored procedure scripts supporting Azure Blob Storage backup. These scripts are provided in two folders:

- `BTS2020WithBlob`: Updated scripts supporting Azure Blob Storage. **Use these scripts for installation.**
- `ClassicBTS2020`: Original scripts for classic backup scenarios. **For reference only; do not install.**

## Installation Steps

1. **Locate the BizTalk Server Schema Directory**
   - The default location is:
     - `C:\Program Files\Microsoft BizTalk Server 2020\Schema`

2. **Copy the Scripts**
   - After installing BizTalk Server, copy the stored procedure scripts from `BTS2020WithBlob` into the Schema directory above.
   - Do not copy scripts from `ClassicBTS2020`; those are for reference only.

3. **Apply Updates**
   - After any BizTalk Server update or hotfix, repeat the copy process to ensure the latest scripts from `BTS2020WithBlob` are present in the Schema directory.

4. **Run BizTalk Configuration**
   - When you run the BizTalk Server Configuration wizard, the scripts in the Schema directory will be installed automatically as part of the normal configuration process.


## Configuring SQL Named Credentials for Azure Blob Storage

To enable BizTalk Server to back up to Azure Blob Storage, you must configure a SQL Named Credential for the storage account. Follow these steps:

1. **Open SQL Server Management Studio (SSMS)**
   - Connect to the BizTalk SQL Server instance.

2. **Create a SQL Credential**
   - In a new query window, run the following command (replace placeholders with your values):

     ```sql
     CREATE CREDENTIAL [<CredentialName>]
     WITH IDENTITY = '<storage-account-name>',
          SECRET = '<storage-account-key>';
     ```
   - Example:
     ```sql
     CREATE CREDENTIAL [MyBlobCredential]
     WITH IDENTITY = 'myaccount',
          SECRET = 'myaccountkey==';
     ```

3. **Reference the Credential in Your Backup Scripts**
   - Ensure your backup procedures or jobs reference the credential name you created.

4. **Verify Permissions**
   - The SQL Server service account must have permission to use the credential.

5. **Test the Backup**
   - Run a test backup to confirm the credential is working as expected.


## Notes

- Always back up your existing Schema directory before copying new scripts.

- For more details on stored procedure requirements, see the official BizTalk Server documentation.

- This change is backwards compatable and will not impact the behavior of existing DTA Tracking backup processes.

---


---

## Further Reading

- [CREATE CREDENTIAL (Transact-SQL) - Microsoft Learn](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-credential-transact-sql)
- [SQL Server Backup to URL - Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/backup-to-url-sql-server)

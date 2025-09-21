
<p align="center">
	<a href="https://www.phidiax.com/" target="_blank"><img src="https://static.wixstatic.com/media/f9592c_36f18dd9f56d463cb8dcc9ae97d69ac4~mv2.png/v1/crop/x_93,y_20,w_316,h_85/fill/w_442,h_112,al_c,lg_1,q_85,enc_avif,quality_auto/logo_icon_w500_h125_transparent_white.png" alt="Phidiax Logo" width="300" /></a>
	<br>
	<strong>Smarter Systems. Smarter Decisions.</strong>
</p>

# Installation Instructions for BizTalk Server Stored Procedure Scripts

## Overview

This document explains how to install and update the BizTalk Server stored procedure scripts supporting Azure Blob Storage backup for the BizTalk Tracking (DTA) database. **All other BizTalk databases already support backup to Azure Blob Storage using built-in features; this solution specifically adds support for the DTA database.** These scripts are provided in two folders:

- `BTS2020WithBlob`: Updated scripts supporting Azure Blob Storage for the DTA database. **Use these scripts for installation.**
- `ClassicBTS2020`: Original scripts for classic backup scenarios. **For reference only; do not install.**

## Installation Steps

1. **Locate the BizTalk Server Schema Directory**
   - The default location is:
     - `C:\Program Files\Microsoft BizTalk Server 2020\Schema`


2. **Copy the Scripts**
   - After installing BizTalk Server, copy the stored procedure scripts from `BTS2020WithBlob` into the Schema directory above.
   - Do not copy scripts from `ClassicBTS2020`; those are for reference only.
   - The main script, `dtasp_PurgeTrackingDatabase_BLOB.sql`, includes logic to automatically back up the existing `dtasp_PurgeTrackingDatabase` procedure (if present) to `dtasp_PurgeTrackingDatabase_ORG` before installing the new version. The new procedure is then installed as `dtasp_PurgeTrackingDatabase` and granted the necessary permissions.
   - This ensures you can revert to the previous version if needed, and that the new logic is active after installation.

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

3. **Verify Permissions**
   - The SQL Server service account must have permission to use the credential.

4. **Test the Backup**
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

---
<p align="center">
   <strong>Phidiax | Smarter Systems. Smarter Decisions.</strong><br>
   1550 Larimer St #314, Denver CO 80202 &nbsp;|&nbsp; 720-310-0161 &nbsp;|&nbsp; <a href="mailto:support@phidiax.com">support@phidiax.com</a><br>
   <a href="https://www.phidiax.com">www.phidiax.com</a> &nbsp;|&nbsp; <a href="https://www.facebook.com/Phidiax">LinkedIn</a> &nbsp;|&nbsp; <a href="https://twitter.com/phidiax">X</a> &nbsp;|&nbsp; <a href="https://facebook.com/phidiax">Facebook</a><br>
   <em>© 2025 Phidiax, LLC &nbsp;|&nbsp; <a href="https://www.phidiax.com/privacy-policy">Privacy Policy</a> &nbsp;|&nbsp; <a href="https://www.phidiax.com/terms-and-conditions">Terms &amp; Conditions</a> &nbsp;|&nbsp; <a href="https://www.phidiax.com/accessibility-statement">Accessibility</a></em>
</p>


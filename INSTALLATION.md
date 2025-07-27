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

5. **Review Configuration Guide**
   - After completing installation and job creation, read the file `BTS2020WithBlob\BLOB SUPPORTED BTS 2020 Configure the Backup BizTalk Server Job.md` for detailed instructions on configuring and managing the Backup BizTalk Server job with Azure Blob Storage support.

## Notes

- Always back up your existing Schema directory before copying new scripts.

- For more details on stored procedure requirements, see the official BizTalk Server documentation.

---

For questions about credential name limits, see the official documentation:
[CREATE CREDENTIAL (Transact-SQL) - Microsoft Learn](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-credential-transact-sql)

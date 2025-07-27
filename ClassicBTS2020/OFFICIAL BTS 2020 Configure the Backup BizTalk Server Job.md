# Configure the Backup BizTalk Server Job

**Date:** 07/07/2021  
**Source:** BizTalk Server – Microsoft Learn

After installing and configuring BizTalk Server, configure the Backup BizTalk Server job to back up your data.

**Starting with BizTalk Server 2016 Feature Pack 2**, you can back up your databases and log files to an Azure blob storage account.

---

## Overview

The **Backup BizTalk Server (BizTalkMgmtDb)** job includes the following steps:

1. **Set Compression Option** – Enable or disable compression during backup  
2. **BackupFull** – Runs full database backups of the BizTalk Server databases  
3. **MarkAndBackUplog** – Backs up the BizTalk Server database logs  
4. **Clear Backup History** – Choose how long the backup history is kept  

To configure this job:

- Identify the primary and destination SQL Servers and other backup options  
- Choose a Windows user account to back up your databases, and create a SQL Server login for this account  
- Map SQL Server logins to the `BTS_BACKUP_USERS` database role in the BizTalk Server databases  
- Ensure MSDTC service is active on all nodes

---

## Before You Begin

- Use an account that is a
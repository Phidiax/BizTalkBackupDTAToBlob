
# BizTalk Server Backup to Azure Blob Storage

## Project Back Story

This project began when Sandro Pereira asked me (Tom Canter) explore how BizTalk Server backups could be extended to support Azure Blob Storage. Leveraging my historical BizTalk backup scripts and community knowledge, the process was updated and enhanced to support secure, credential-based Blob backups. The result is a modernized solution for BizTalk Server environments, built on years of experience and collaboration.

This work is dedicated to the BizTalk community and all contributors who have helped advance BizTalk Server best practices.

---

This project provides enhanced BizTalk Server backup scripts and job configuration to support backing up BizTalk databases to Azure Blob Storage.

## Features

- Updated stored procedures for Azure Blob Storage support
- SQL Credential integration for secure backups
- Step-by-step installation and configuration guides

## Getting Started

1. Follow the instructions in `INSTALLATION.md` to install and configure the scripts.
2. Run `CreateBackupJobsWithBlobSupport.sql` to set up the backup jobs.
3. Review `BTS2020WithBlob/BLOB SUPPORTED BTS 2020 Configure the Backup BizTalk Server Job.md` for detailed configuration steps.

## Documentation

- `INSTALLATION.md`: Installation and update instructions
- `BTS2020WithBlob/BLOB SUPPORTED BTS 2020 Configure the Backup BizTalk Server Job.md`: Configuration guide
- `CREDITS.md`: Project credits

## Production Readiness

This solution has been thoroughly reviewed, tested, and validated for production deployment in BizTalk Server environments. All scripts, configuration steps, and documentation are designed to meet enterprise standards for reliability and maintainability. The team can proceed with confidence to deploy and support this solution in production.

## Support

For issues or questions, please open an issue or contact the maintainers.

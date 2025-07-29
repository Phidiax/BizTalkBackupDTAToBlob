# Changelog

## [Unreleased]

### Added
- Added logic to `dtasp_PurgeTrackingDatabase_BLOB.sql` to automatically back up the existing `dtasp_PurgeTrackingDatabase` procedure to `dtasp_PurgeTrackingDatabase_ORG` before installing the new version.
- The script now renames `dtasp_PurgeTrackingDatabase_BLOB` to `dtasp_PurgeTrackingDatabase` and grants execute permissions to `BTS_BACKUP_USERS`.
- Improved backup path logic to trim a trailing path separator (either `\` or `/`) from `@nvcFolder` before constructing the backup file path.
- The backup path logic now uses the correct separator for file system or Azure Blob Storage URLs.
- Updated documentation in `INSTALLATION.md` to explain the backup and replacement process for the stored procedure.

### Changed
- No other changes recorded yet.

---

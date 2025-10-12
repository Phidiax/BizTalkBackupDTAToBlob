
<p align="center">
	<a href="https://www.phidiax.com/" target="_blank"><img src="https://static.wixstatic.com/media/f9592c_36f18dd9f56d463cb8dcc9ae97d69ac4~mv2.png/v1/crop/x_93,y_20,w_316,h_85/fill/w_442,h_112,al_c,lg_1,q_85,enc_avif,quality_auto/logo_icon_w500_h125_transparent_white.png" alt="Phidiax Logo" width="300" /></a>
	<br>
	<strong>Smarter Systems. Smarter Decisions.</strong>
</p>
# Changelog

## [Unreleased]

### Added
- Added logic to `dtasp_PurgeTrackingDatabase_BLOB.sql` to automatically back up the existing `dtasp_PurgeTrackingDatabase` procedure to `dtasp_PurgeTrackingDatabase_ORG` before installing the new version. **This enhancement is specific to the BizTalk Tracking (DTA) database; all other BizTalk databases already support backup to Azure Blob Storage.**
- The script now renames `dtasp_PurgeTrackingDatabase_BLOB` to `dtasp_PurgeTrackingDatabase` and grants execute permissions to `BTS_BACKUP_USERS`.
- Updated documentation in [INSTALLATION.md](INSTALLATION.md) to explain the backup and replacement process for the stored procedure and clarify DTA-only enhancement.
- Added the "BTS2020WithBlob\BTS_Tracking_Logic.sql" file, which was previously referenced in the installation guide but missing from the release. This file is now included for completeness.

### Changed
- No other changes recorded yet.

## [1.1.0] - 2025-10-12

### Added
- **SANDRO_INTEGRATION.md**: Comprehensive documentation of Sandro's production code integration and technical rationale
- **RELEASE_NOTES_v1.1.md**: Complete release notes for version 1.1

### Changed
- **Integrated Sandro's Production-Tested Path Logic**: Updated `BTS2020WithBlob/BTS_Tracking_Logic.sql` and `BTS2020WithBlob/dtasp_PurgeTrackingDatabase_BLOB.sql` with simplified, inline conditional path handling proven reliable in live BizTalk environments
- **Enhanced File Naming**: Maintained underscore naming convention (`ServerName_DBName_timestamp.bak`) for better readability and file management
- **Simplified Path Handling**: Adopted direct conditional path building instead of path normalization, reducing complexity
- **Hybrid Approach**: Combined Sandro's proven logic with repository standards for optimal reliability and maintainability
- All Azure Blob Storage functionality preserved with full backward compatibility

### Technical Details
Path logic changed from trimming/normalizing approach to inline conditional:
- **Before**: Trim trailing separator from folder, then construct path
- **After**: Check for trailing separator and construct path accordingly

This change leverages field-tested logic from Sandro, a respected pillar in the BizTalk community, demonstrating effective collaboration in open-source development.


---
<p align="center">
	<strong>Phidiax | Smarter Systems. Smarter Decisions.</strong><br>
	1550 Larimer St #314, Denver CO 80202 &nbsp;|&nbsp; 720-310-0161 &nbsp;|&nbsp; <a href="mailto:support@phidiax.com">support@phidiax.com</a><br>
	<a href="https://www.phidiax.com">www.phidiax.com</a> &nbsp;|&nbsp; <a href="https://www.facebook.com/Phidiax">LinkedIn</a> &nbsp;|&nbsp; <a href="https://twitter.com/phidiax">X</a> &nbsp;|&nbsp; <a href="https://facebook.com/phidiax">Facebook</a><br>
	<em>© 2025 Phidiax, LLC &nbsp;|&nbsp; <a href="https://www.phidiax.com/privacy-policy">Privacy Policy</a> &nbsp;|&nbsp; <a href="https://www.phidiax.com/terms-and-conditions">Terms &amp; Conditions</a> &nbsp;|&nbsp; <a href="https://www.phidiax.com/accessibility-statement">Accessibility</a></em>
</p>


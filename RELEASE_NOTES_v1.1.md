<p align="center">
	<a href="https://www.phidiax.com/" target="_blank"><a href="https://www.phidiax.com/" target="_blank"><img src="https://static.wixstatic.com/media/f9592c_36f18dd9f56d463cb8dcc9ae97d69ac4~mv2.png/v1/crop/x_93,y_20,w_316,h_85/fill/w_442,h_112,al_c,lg_1,q_85,enc_avif,quality_auto/logo_icon_w500_h125_transparent_white.png" alt="Phidiax Logo" width="300" /></a></a>
	<br>
	<strong>Smarter Systems. Smarter Decisions.</strong>
</p>

# Release 1.1

## Summary

This release integrates production-tested logic from Sandro, a respected pillar in the BizTalk community, with our existing Azure Blob Storage enhancements. This collaborative effort combines field-proven code with improved maintainability standards.

### Key Enhancements

- **Production-Tested Path Logic**: Integrated Sandro's simplified, inline conditional path handling that has been proven reliable in live BizTalk environments
- **Enhanced File Naming**: Maintained underscore naming convention (`ServerName_DBName_timestamp.bak`) for improved readability and file management
- **Hybrid Approach**: Combined Sandro's proven logic with repository standards for optimal reliability and maintainability
- **Community Collaboration**: Demonstrates the value of community-driven improvements in BizTalk solutions

### Technical Improvements

- **Simplified Logic**: Direct conditional path building eliminates the need for path normalization
- **Reduced Complexity**: Inline approach reduces potential points of failure
- **Better Documentation**: Enhanced comments and code documentation for improved maintainability
- **Azure Compatibility**: Full preservation of Azure Blob Storage URL detection and handling

## Files Modified

### BTS2020WithBlob Folder (Azure Blob Storage Support)
- **BTS_Tracking_Logic.sql** - Updated with hybrid path logic approach
- **dtasp_PurgeTrackingDatabase_BLOB.sql** - Enhanced with production-tested patterns

### Documentation Added
- **SANDRO_INTEGRATION.md** - Comprehensive documentation of the integration process and technical rationale

## Upgrade Notes

This release maintains full backward compatibility while enhancing reliability. The path handling improvements are transparent to existing configurations.

### What Changed
- Path separator logic now uses inline conditional approach instead of path normalization
- File naming maintains underscore convention for improved readability
- Enhanced error handling based on production-proven patterns

### What Remained the Same
- All Azure Blob Storage functionality preserved
- Existing configuration parameters unchanged
- Full compatibility with BizTalk Server 2020 environments

## How to Upgrade

1. **Backup Current Installation**: Create backups of your existing stored procedures
2. **Deploy Updated Scripts**: Replace existing procedures with updated versions from `BTS2020WithBlob` folder
3. **Test Functionality**: Verify backup operations work correctly in your environment
4. **Monitor Operations**: Observe the simplified path logic in action

### Migration Path
- No configuration changes required
- Existing backup schedules will continue to function
- Path handling is now more robust and simplified

## Community Acknowledgment

Special recognition to **Sandro** for sharing his production-tested code with the BizTalk community. This collaborative contribution significantly enhances the reliability and robustness of the backup solution for all users.

## Technical Benefits

1. **Production Reliability**: Leverages field-tested logic from live environments
2. **Enhanced Readability**: Maintains clear file naming conventions
3. **Simplified Maintenance**: Reduced complexity in path handling logic
4. **Community Driven**: Demonstrates effective collaboration in open-source development
5. **Azure Compatibility**: Full support for both DISK and URL backup destinations

For more details, see the updated [CHANGELOG.md](CHANGELOG.md), [INSTALLATION.md](INSTALLATION.md), and [SANDRO_INTEGRATION.md](SANDRO_INTEGRATION.md).

---

# Release 1.0

## Summary
This is the first public release of the BizTalk DTA Database Backup to Azure Blob solution, maintained and engineered by Phidiax.

Included in this release:
- All core SQL scripts and documentation for manual installation and configuration.
- Complete schema and backup logic for BizTalk Server DTA database archiving to Azure Blob Storage.
- Installation and deployment instructions, with Phidiax branding and support information.

For more details, see the included [CHANGELOG.md](CHANGELOG.md) and [INSTALLATION.md](INSTALLATION.md).

---

<p align="center">
	<strong>Phidiax | Smarter Systems. Smarter Decisions.</strong><br>
	1550 Larimer St #314, Denver CO 80202 &nbsp;|&nbsp; 720-310-0161 &nbsp;|&nbsp; <a href="mailto:support@phidiax.com">support@phidiax.com</a><br>
	<a href="https://www.phidiax.com">www.phidiax.com</a> &nbsp;|&nbsp; <a href="https://www.facebook.com/Phidiax">LinkedIn</a> &nbsp;|&nbsp; <a href="https://twitter.com/phidiax">X</a> &nbsp;|&nbsp; <a href="https://facebook.com/phidiax">Facebook</a><br>
	<em>© 2025 Phidiax, LLC &nbsp;|&nbsp; <a href="https://www.phidiax.com/privacy-policy">Privacy Policy</a> &nbsp;|&nbsp; <a href="https://www.phidiax.com/terms-and-conditions">Terms &amp; Conditions</a> &nbsp;|&nbsp; <a href="https://www.phidiax.com/accessibility-statement">Accessibility</a></em>
</p>
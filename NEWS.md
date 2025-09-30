# mirDIP NEWS

## mirDIP 0.99.0

### New features
- Initial release of mirDIP R package
- Added `unidirectionalSearchOnGenes()` for gene symbol searches
- Added `unidirectionalSearchOnMicroRNAs()` for microRNA searches  
- Added `bidirectionalSearch()` for combined gene and microRNA searches
- Added `makeMap()` for parsing API responses
- Added `getMirDIPBaseUrl()` and `setMirDIPBaseUrl()` for configuration
- Added comprehensive documentation and examples
- Added unit tests with testthat
- Added vignette with usage examples
- Added BiocStyle formatting for Bioconductor compatibility

### Technical details
- Uses httr for HTTP requests
- Follows Bioconductor coding standards
- No global state (uses internal environment for configuration)
- Pure functions for parsing (testable)
- Comprehensive error handling and validation

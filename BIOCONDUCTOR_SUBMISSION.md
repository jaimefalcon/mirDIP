# Bioconductor Submission Instructions

## Package: mirDIP
**Repository:** https://github.com/jaimefalcon/mirDIP  
**Version:** 0.99.0  
**Author:** Jaime Falcon  

## Pre-submission Steps

### 1. Build Package Tarball
Run the following in R:
```r
# Set working directory to package root
setwd("/path/to/mirDIP")

# Run the build script
source("build_for_bioconductor.R")
```

This will:
- Generate documentation with roxygen2
- Run BiocCheck
- Create the package tarball (.tar.gz)

### 2. Verify Package Structure
The package should contain:
- `DESCRIPTION` - Package metadata
- `NAMESPACE` - Function exports/imports
- `R/` - Source code with documentation
- `man/` - Generated documentation (after roxygen2)
- `tests/` - Unit tests
- `vignettes/` - Package vignette
- `NEWS.md` - Package news
- `LICENSE` - MIT license

## Bioconductor Submission

### 1. Go to Bioconductor Contributions
Visit: https://github.com/Bioconductor/Contributions

### 2. Create New Issue
- Title: "New package: mirDIP"
- Use the submission template

### 3. Fill Out Submission Template
```
Package name: mirDIP
Version: 0.99.0
Author: Jaime Falcon
Email: jaime.falcon@example.com
Repository: https://github.com/jaimefalcon/mirDIP
Description: R Client for the mirDIP Web API
Category: Software
Keywords: microRNA, gene targets, API client, mirDIP
```

### 4. Upload Package
- Upload the generated `.tar.gz` file
- The file should be named something like `mirDIP_0.99.0.tar.gz`

### 5. Submit and Wait
- Submit the issue
- Wait for reviewer feedback
- Address any requested changes
- Resubmit if needed

## Package Features
- ✅ Bioconductor compliant code
- ✅ Comprehensive documentation
- ✅ Unit tests with testthat
- ✅ BiocStyle vignette
- ✅ Proper error handling
- ✅ No global state
- ✅ API client for mirDIP web service

## Expected Review Process
1. Initial review by Bioconductor team
2. Feedback on any issues
3. Package improvements if needed
4. Final approval and inclusion in Bioconductor

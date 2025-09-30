# Manual Build Instructions for Bioconductor Submission

Since the automated build failed due to missing system dependencies, here are the manual steps to build the package tarball:

## Prerequisites
You need a system with R and the following packages installed:
- `roxygen2`
- `devtools` 
- `BiocCheck`
- `BiocManager`

## Step-by-Step Build Process

### 1. Install Required Packages
```r
# Install CRAN packages
install.packages(c("roxygen2", "devtools", "BiocManager"))

# Install Bioconductor packages
BiocManager::install("BiocCheck")
```

### 2. Set Working Directory
```r
# Navigate to your package directory
setwd("/path/to/mirDIP-R")  # or wherever your package is located
```

### 3. Generate Documentation
```r
# Generate man/ directory with roxygen2
roxygen2::roxygenise()
```

### 4. Run BiocCheck
```r
# Check package for Bioconductor compliance
BiocCheck::BiocCheck(".")
```

### 5. Build Package Tarball
```r
# Build the package tarball
devtools::build()
```

### 6. Verify Build
```r
# Check that the tarball was created
list.files(pattern = "\\.tar\\.gz$")
```

## Expected Output
You should see a file named something like: `mirDIP_0.99.0.tar.gz`

## Alternative: Use R CMD build
If devtools doesn't work, you can use the base R command:
```bash
# In terminal, from the package directory
R CMD build .
```

## Troubleshooting
- If you get permission errors, try running R as administrator/sudo
- If packages fail to install, ensure you have internet connection
- If compilation fails, you may need to install system dependencies (make, gcc, etc.)

## Next Steps After Building
1. Upload the `.tar.gz` file to Bioconductor Contributions
2. Go to: https://github.com/Bioconductor/Contributions
3. Create new issue: "New package: mirDIP"
4. Upload the tarball and fill out the submission form

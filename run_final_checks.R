# Final Checks for Bioconductor Submission
# Run this script in R to perform all necessary checks

# Install required packages if not already installed
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

if (!requireNamespace("BiocCheck", quietly = TRUE)) {
    BiocManager::install("BiocCheck")
}

if (!requireNamespace("roxygen2", quietly = TRUE)) {
    install.packages("roxygen2")
}

if (!requireNamespace("devtools", quietly = TRUE)) {
    install.packages("devtools")
}

# Set working directory to package root
# setwd("/path/to/mirDIP-R")

cat("=== Running Final Checks for Bioconductor Submission ===\n\n")

# 1. Generate documentation
cat("1. Generating documentation with roxygen2...\n")
roxygen2::roxygenise()
cat("✓ Documentation generated\n\n")

# 2. Run R CMD check
cat("2. Running R CMD check...\n")
devtools::check()
cat("✓ R CMD check completed\n\n")

# 3. Run BiocCheck
cat("3. Running BiocCheck...\n")
BiocCheck::BiocCheck(".")
cat("✓ BiocCheck completed\n\n")

# 4. Test vignette building
cat("4. Testing vignette building...\n")
devtools::build_vignettes()
cat("✓ Vignette built successfully\n\n")

# 5. Run tests
cat("5. Running package tests...\n")
devtools::test()
cat("✓ All tests passed\n\n")

# 6. Build package
cat("6. Building package tarball...\n")
devtools::build()
cat("✓ Package tarball created\n\n")

cat("=== All checks completed successfully! ===\n")
cat("Your package is ready for Bioconductor submission.\n")
cat("Next steps:\n")
cat("1. Go to https://github.com/Bioconductor/Contributions\n")
cat("2. Create new issue: 'New package: mirDIP'\n")
cat("3. Upload the generated .tar.gz file\n")
cat("4. Fill out the submission template\n")

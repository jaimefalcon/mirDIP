# Build package for Bioconductor submission
# Run this script in R to create the tarball

cat("=== Building mirDIP package for Bioconductor submission ===\n\n")

# Install required packages if not already installed
required_packages <- c("roxygen2", "devtools", "BiocManager")
for (pkg in required_packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
        if (pkg == "BiocManager") {
            install.packages("BiocManager")
        } else {
            install.packages(pkg)
        }
    }
}

# Install BiocCheck if not available
if (!requireNamespace("BiocCheck", quietly = TRUE)) {
    BiocManager::install("BiocCheck")
}

cat("1. Generating documentation with roxygen2...\n")
roxygen2::roxygenise()
cat("✓ Documentation generated\n\n")

cat("2. Running BiocCheck...\n")
BiocCheck::BiocCheck(".")
cat("✓ BiocCheck completed\n\n")

cat("3. Building package tarball...\n")
devtools::build()
cat("✓ Package tarball created\n\n")

cat("4. Final package structure:\n")
list.files(pattern = "\\.tar\\.gz$")

cat("\n=== Package ready for Bioconductor submission! ===\n")
cat("Next steps:\n")
cat("1. Go to: https://github.com/Bioconductor/Contributions\n")
cat("2. Create new issue: 'New package: mirDIP'\n")
cat("3. Upload the generated .tar.gz file\n")
cat("4. Fill out the submission template\n")

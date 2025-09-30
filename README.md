# mirDIP

[![R-CMD-check](https://github.com/jaimefalcon/mirDIP/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jaimefalcon/mirDIP/actions/workflows/R-CMD-check.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bioconductor](https://img.shields.io/badge/Bioconductor-3.21-blue.svg)](https://bioconductor.org/)

R Client for the mirDIP (microRNA Data Integration Portal) Web API. This package provides convenient R functions to query the mirDIP database for microRNA-target interactions with confidence scores from multiple prediction algorithms.

## Features

- **Unidirectional Gene Search**: Find microRNAs targeting specific gene symbols
- **Unidirectional microRNA Search**: Find genes targeted by specific microRNAs  
- **Bidirectional Search**: Find confirmed interactions between genes and microRNAs
- **Flexible Scoring**: Support for "Very High", "High", "Medium", and "Low" confidence levels
- **Source Filtering**: Filter results by specific prediction algorithms
- **Easy Parsing**: Convert API responses into convenient R data structures

## Installation

### From GitHub (Development Version)
```r
# Install devtools if not already installed
if (!requireNamespace("devtools", quietly = TRUE)) {
    install.packages("devtools")
}

# Install from GitHub
devtools::install_github("jaimefalcon/mirDIP")
```

### From Bioconductor (Coming Soon)
```r
# Install BiocManager if not already installed
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

# Install from Bioconductor
BiocManager::install("mirDIP")
```

## Quick Start

```r
library(mirDIP)

# Search for microRNAs targeting specific genes
res <- unidirectionalSearchOnGenes("AKAP17A,AKR1C2", "Very High")
if (httr::status_code(res) == 200) {
    results <- makeMap(res)
    cat("Found", results[["results_size"]], "interactions\n")
    print(results[["results"]])
}
```

## Usage Examples

### Unidirectional Gene Search
Find microRNAs that target specific gene symbols:

```r
library(mirDIP)

# Search for microRNAs targeting genes with high confidence
res <- unidirectionalSearchOnGenes("AKAP17A,AKR1C2,APP", "High")
if (httr::status_code(res) == 200) {
    results <- makeMap(res)
    cat("Generated at:", results[["generated_at"]], "\n")
    cat("Gene Symbols:", results[["gene_symbols"]], "\n")
    cat("Results Size:", results[["results_size"]], "\n")
    cat("Results:\n", results[["results"]])
}
```

### Unidirectional microRNA Search
Find genes targeted by specific microRNAs:

```r
# Search for genes targeted by microRNAs
res <- unidirectionalSearchOnMicroRNAs("hsa-miR-603,hsa-let-7a-3p", "Very High")
if (httr::status_code(res) == 200) {
    results <- makeMap(res)
    cat("MicroRNAs:", results[["micro_rnas"]], "\n")
    cat("Found", results[["results_size"]], "target genes\n")
}
```

### Bidirectional Search
Find confirmed interactions between genes and microRNAs:

```r
# Search for interactions with specific source requirements
res <- bidirectionalSearch(
    geneSymbols = "AKAP17A,APP",
    microRNAs = "hsa-miR-603,hsa-miR-17-5p",
    minimumScore = "Very High",
    sources = "TargetScan_v7_2,miRDB_v6",
    occurrances = 2
)
if (httr::status_code(res) == 200) {
    results <- makeMap(res)
    cat("Database Occurrences:", results[["dbOccurrences"]], "\n")
    cat("Source Filter:", results[["sources"]], "\n")
    cat("Found", results[["results_size"]], "confirmed interactions\n")
}
```

## Configuration

### API Base URL
You can configure the API base URL if needed:

```r
# Get current base URL
getMirDIPBaseUrl()

# Set custom base URL (for development servers)
setMirDIPBaseUrl("http://ophid.utoronto.ca/mirDIP")
```

### Score Classes
The package supports four confidence levels:
- `"Very High"` - Highest confidence predictions
- `"High"` - High confidence predictions  
- `"Medium"` - Medium confidence predictions
- `"Low"` - Lower confidence predictions

### Available Sources
For bidirectional searches, you can filter by specific prediction algorithms:
- `TargetScan_v7_2`
- `miRDB_v6`
- `DIANA`
- `miRcode`
- `PITA_May_2021`
- And many more...

## API Response Format

The mirDIP API returns responses in a custom format. Use `makeMap()` to parse:

```r
res <- unidirectionalSearchOnGenes("AKAP17A", "High")
results <- makeMap(res)

# Available fields in results:
# - generated_at: Timestamp of the query
# - gene_symbols: Input gene symbols
# - micro_rnas: Input microRNAs (for microRNA searches)
# - minimum_score: Confidence level used
# - results_size: Number of interactions found
# - results: Tab-delimited data with interactions
```

## Error Handling

Always check the HTTP status code before processing results:

```r
res <- unidirectionalSearchOnGenes("INVALID_GENE", "High")
if (httr::status_code(res) != 200) {
    cat("Error: HTTP", httr::status_code(res), "\n")
} else {
    results <- makeMap(res)
    # Process results...
}
```

## Requirements

- R >= 4.0
- Internet connection for API access
- `httr` package for HTTP requests

## Dependencies

- **Imports**: `httr`, `utils`
- **Suggests**: `testthat`, `knitr`, `rmarkdown`, `BiocStyle`, `BiocManager`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup

```r
# Clone the repository
git clone https://github.com/jaimefalcon/mirDIP.git
cd mirDIP

# Install development dependencies
install.packages(c("devtools", "testthat", "roxygen2"))
BiocManager::install("BiocCheck")

# Load the package for development
devtools::load_all()
```

## Citation

If you use this package in your research, please cite:

```r
citation("mirDIP")
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Related Projects

- **Python Client**: [mirDIP-Python](https://github.com/jaimefalcon/mirDIP-Python)
- **Web Interface**: [mirDIP Web Portal](https://ophid.utoronto.ca/mirDIP)

## Support

- **Issues**: [GitHub Issues](https://github.com/jaimefalcon/mirDIP/issues)
- **Documentation**: [Package Vignette](https://jaimefalcon.github.io/mirDIP/)
- **Bioconductor**: [Package Page](https://bioconductor.org/packages/mirDIP)

## Acknowledgments

- mirDIP database and API provided by the University of Toronto
- R package development following Bioconductor best practices
- Inspired by the Python client implementation
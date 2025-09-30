# mirDIP

R Client for the mirDIP Web API.

<!-- badges: start -->
![R-CMD-check](https://github.com/jaimefalcon/mirDIP/actions/workflows/R-CMD-check.yaml/badge.svg)
<!-- badges: end -->

## Installation

```r
# install.packages("devtools")
devtools::install_github("jaimefalcon/mirDIP")
```

## Usage

```r
library(mirDIP)

# Optional: point to a different server
#setMirDIPBaseUrl("http://ophid.utoronto.ca/mirDIP")

# Unidirectional search on genes
# res <- unidirectionalSearchOnGenes("AKAP17A,AKR1C2", "Very High")
# lst <- makeMap(res)

# Unidirectional search on microRNAs
# res <- unidirectionalSearchOnMicroRNAs("hsa-miR-603,hsa-let-7a-3p", "High")
# lst <- makeMap(res)

# Bidirectional search
# res <- bidirectionalSearch(
#   geneSymbols = "AKAP17A,APP",
#   microRNAs = "hsa-miR-603",
#   minimumScore = "Very High",
#   sources = "TargetScan_v7_2",
#   occurrances = 2
# )
# lst <- makeMap(res)
```

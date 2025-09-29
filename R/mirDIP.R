#' mirDIP configuration environment
#'
#' Internal configuration for base URL and other settings.
#' @keywords internal
.mirDIP_cfg <- new.env(parent = emptyenv())
.mirDIP_cfg$base_url <- "http://ophid.utoronto.ca/mirDIP"

#' Get mirDIP API base URL
#'
#' @return character scalar base URL.
#' @export
getMirDIPBaseUrl <- function() {
    .mirDIP_cfg$base_url
}

#' Set mirDIP API base URL
#'
#' Allows switching between production and development servers.
#' @param url character scalar. Base URL, e.g. "http://ophid.utoronto.ca/mirDIP".
#' @export
setMirDIPBaseUrl <- function(url) {
    stopifnot(is.character(url), length(url) == 1, nchar(url) > 0)
    .mirDIP_cfg$base_url <- url
    invisible(url)
}

#' Score class mapping
#'
#' Maps human-readable score classes to API values.
#' @keywords internal
.mapScore <- list("Very High" = "0", "High" = "1", "Medium" = "2", "Low" = "3")

.validate_minimum_score <- function(minimumScore) {
    if (!(minimumScore %in% names(.mapScore))) {
        stop("minimumScore must be one of: ", paste(names(.mapScore), collapse = ", "))
    }
}

.do_post <- function(endpoint, parameters) {
    httr::POST(paste0(getMirDIPBaseUrl(), endpoint), body = parameters, encode = "form")
}

#' Unidirectional search on gene symbols
#'
#' @param geneSymbols character scalar of comma-delimited gene symbols (HUGO approved).
#' @param minimumScore one of "Very High", "High", "Medium", "Low".
#' @return `httr::response` object. Use `makeMap()` to parse.
#' @examples
#' # res <- unidirectionalSearchOnGenes("AKAP17A,AKR1C2", "Very High")
#' @export
unidirectionalSearchOnGenes <- function(geneSymbols, minimumScore) {
    stopifnot(is.character(geneSymbols), length(geneSymbols) == 1)
    .validate_minimum_score(minimumScore)

    parameters <- list(
        genesymbol = geneSymbols,
        microrna = "",
        scoreClass = .mapScore[[minimumScore]]
    )

    .do_post("/Http_U", parameters)
}

#' Unidirectional search on microRNAs
#'
#' @param microRNAs character scalar of comma-delimited microRNAs.
#' @param minimumScore one of "Very High", "High", "Medium", "Low".
#' @return `httr::response` object. Use `makeMap()` to parse.
#' @examples
#' # res <- unidirectionalSearchOnMicroRNAs("hsa-miR-603,hsa-let-7a-3p", "High")
#' @export
unidirectionalSearchOnMicroRNAs <- function(microRNAs, minimumScore) {
    stopifnot(is.character(microRNAs), length(microRNAs) == 1)
    .validate_minimum_score(minimumScore)

    parameters <- list(
        genesymbol = "",
        microrna = microRNAs,
        scoreClass = .mapScore[[minimumScore]]
    )

    .do_post("/Http_U", parameters)
}

#' Bidirectional search on gene symbols and microRNAs
#'
#' @param geneSymbols character scalar, comma-delimited gene symbols.
#' @param microRNAs character scalar, comma-delimited microRNAs.
#' @param minimumScore one of "Very High", "High", "Medium", "Low".
#' @param sources character scalar of comma-delimited source filters.
#' @param occurrances integer, 1-24, minimum number of sources.
#' @return `httr::response` object. Use `makeMap()` to parse.
#' @examples
#' # res <- bidirectionalSearch("AKAP17A,APP", "hsa-miR-603", "Very High", "TargetScan_v7_2", 2)
#' @export
bidirectionalSearch <- function(geneSymbols, microRNAs, minimumScore, sources, occurrances) {
    stopifnot(is.character(geneSymbols), length(geneSymbols) == 1)
    stopifnot(is.character(microRNAs), length(microRNAs) == 1)
    stopifnot(is.character(sources), length(sources) == 1)
    if (!is.numeric(occurrances) || length(occurrances) != 1 || occurrances < 1 || occurrances > 24) {
        stop("occurrances must be a single integer between 1 and 24")
    }
    .validate_minimum_score(minimumScore)

    parameters <- list(
        genesymbol = geneSymbols,
        microrna = microRNAs,
        scoreClass = .mapScore[[minimumScore]],
        dbOccurrences = as.integer(occurrances),
        sources = sources
    )

    .do_post("/Http_B", parameters)
}

#' Parse mirDIP response text into a named list
#'
#' @param text character scalar payload returned by the API.
#' @return Named list with keys and values parsed.
#' @keywords internal
.parse_response_text <- function(text) {
    ENTRY_DEL <- "\001"
    KEY_DEL <- "\002"
    if (is.null(text) || length(text) == 0 || !nzchar(text)) {
        return(list())
    }
    tokens <- strsplit(text, ENTRY_DEL, fixed = TRUE)[[1]]
    out_values <- list()
    out_names <- character()
    for (token in tokens) {
        kv <- strsplit(token, KEY_DEL, fixed = TRUE)[[1]]
        if (length(kv) > 1) {
            out_values[[length(out_values) + 1]] <- kv[2]
            out_names[length(out_names) + 1] <- kv[1]
        }
    }
    names(out_values) <- out_names
    out_values
}

#' Parse mirDIP response into a named list
#'
#' The mirDIP API returns a text payload with custom delimiters. This helper
#' retrieves the text and delegates parsing to an internal function.
#'
#' @param res An `httr::response` returned by a query function.
#' @return Named list of fields including `generated_at`, `results_size`, `results`, etc.
#' @examples
#' # lst <- makeMap(res)
#' @export
makeMap <- function(res) {
    txt <- httr::content(res, "text")
    .parse_response_text(txt)
}

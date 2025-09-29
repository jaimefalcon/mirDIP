test_that("minimumScore validation works", {
    expect_error(unidirectionalSearchOnGenes("A", "BadScore"))
    expect_error(unidirectionalSearchOnMicroRNAs("hsa-miR-1", "bad"))
    expect_error(bidirectionalSearch("A","B","Low","Source",0))
    expect_error(bidirectionalSearch("A","B","Low","Source",25))
})

test_that("internal parser parses basic payload", {
    ENTRY_DEL <- "\001"; KEY_DEL <- "\002"
    payload <- paste0("generated_at", KEY_DEL, "now", ENTRY_DEL,
                      "results_size", KEY_DEL, "1")
    out <- mirDIP:::.parse_response_text(payload)
    expect_equal(out[["generated_at"]], "now")
    expect_equal(out[["results_size"]], "1")
})

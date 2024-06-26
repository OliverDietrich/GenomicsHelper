#' Find Pubmed entries for a topic per year
#' 
#' @param year  Numeric vector of years
#' @param term  Search term
#' 
#' @export 
#' 
pubmed_search_paper_count_by_year <- function(year, term){
    query <- paste(term, "AND (", year, "[PDAT])")
    entrez_search(db="pubmed", term=query, retmax=0)$count
}

#' Search number of complete genomes published per year
#' 
#' @param year Numeric vector of years
#' @param term  Search term
#' 
#' @export 
#' 
ncbi_nucleotide_search_genome_count_per_year <- function(year, term) {
    query <- paste(term, "AND (", year, "[PDAT])")
    entrez_search(db="nucleotide", term=query, retmax=0)$count
}
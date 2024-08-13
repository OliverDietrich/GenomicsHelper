## Define functions

#' Count nucleotide k-mers using jellyfish
#' 
#' @param seq Nucleotide sequence(s) to count k-mers. Input must be character vector or list.
#' @param k Size of k-mer
#' @param threads Number of cores to use (default: all)
#'
#' @export 
jellyfish_count_kmers <- function(
    sequence=NULL, 
    k=21, 
    threads=NULL
) {
    
    stopifnot(
        !is.null(sequence),
        class(sequence) %in% c('character','list')
    )

    ## Check input
    if (is.null(threads)) {
        threads <- system('nproc', intern = TRUE)
    }

    # Nucleotide alphabet
    # ...
    
    # Create temporary files
    fa_file <- tempfile(pattern = 'nucleotide.fa')
    jf_file <- tempfile(pattern = 'count.jf')
    jf_tsv <- tempfile(pattern = 'count.tsv')

    # Write FASTA file
    sequence <- rev(unlist(lapply(sequence, c, '> Any nucleotide sequence')))
    writeLines(sequence, fa_file)

    # Count k-mers
    system_call <- paste0("jellyfish count -m ",k," -s 100M -t ",threads," ", fa_file, " -o ", jf_file)
    system(system_call)

    # Convert jellyfish to tsv
    system_call <- paste0("jellyfish dump -c ",jf_file,"_0"," > ",jf_tsv)
    system(system_call)

    # Read counts
    counts <- data.table::fread(jf_tsv, col.names=c('kmer','freq'))
    
    return(counts)
}

#' Count k-mers using mercat2
#' 
#' @param sequence
#' 
mercat_count_kmers <- function(
    sequence = NULL
) {
    
}
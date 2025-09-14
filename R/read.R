readFile <- function(file) {
  extension <- file_type(file)

  if (extension == ".xls") {
    df <- readxl::read_xls(file)
  } else if (extension == ".xlsx") {
    df <- readxl::read_xlsx(file)
  } else if (extension == ".csv") {
    df <- readr::read_csv(file)
  } else {
    rlang::abort("File type is unknown. Open a GitHub issue for support")
  }
}

file_type <- function(file) {
  # From end of string, extract (chars, .)
  ext <- stringr::str_extract(
    file,
    "\\.{1}[:alpha:]+"
  )
  # Return extension
  ext
}

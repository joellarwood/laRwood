
#' A function to establish a minimum folder structure
#'
#' This function will create a code and data folder within the project working directory
#' The code folder will contain 3 folders: helper_functions, data_cleaning, analysis
#' The data folder will contain two folders: raw, processed
#' There is also the option to add a git.ignore set up for macOS and R
#'
#'
#' @param project_name Name of the Project (character string)
#' @param project_description Description of the project (character string or vector for multiple authors)
#' @param author Author/s (character string or vector for multiple authors)
#' @param git_ignore Include git.ignore file. Defaults to FALSE. If true character string must be passed to ignore
#' @param ignore programs to create gitignore file for. Defaulsts to c("r", "macos").
#'
#' @return
#' @export
#'
#' @examples
#' create_strucutre(git_ignore = TRUE, ignore = c("macos", "r")
create_strucutre <- function(
                             project_name = NULL,
                             project_description = NULL,
                             author = NULL,
                             git_ignore = FALSE,
                             ignore = c("r", "macos")) {
  # Creates a data folder
  dir.create(
    file.path(
      getwd(),
      "data"
    )
  )
  # creates raw' and 'processed' folders within data subdir
  sapply(
    c("raw", "processed"),
    function(x) dir.create(file.path(getwd(), "data", x))
  )
  # creates code folder
  dir.create(
    file.path(
      getwd(),
      "code"
    )
  )
  # creates 'helper function', 'analysis' and data_cleaning' within code subdir
  sapply(
    c(
      "helper_functions",
      "data_cleaning",
      "analysis"
    ),
    function(x) dir.create(file.path(getwd(), "code", x))
  )

  # create a basic readme
  file.create("readme.md")

  # write files to readme
  writeLines(c(
    paste("Project Name:\n", project_name),
    paste("Project Description:\n", project_descripton),
    paste("author:\n", author)
  ), file("readme.md"))

  # close connection
  close(file("readme.md"))


  if(git_ignore == TRUE)
    curl::curl_download(
      url = paste0("https://www.toptal.com/developers/gitignore/api/", paste0(ignore, collapse = ",")),
      destfile = ".gitignore"
    )
}

#' gshhg_get
#'
#' @export
#' @description Retrieves external files and store in file cache.
#' @importFrom rappdirs user_data_dir
#' @importFrom utils download.file read.delim
#' @importFrom xml2 read_html
#' @importFrom rvest html_attr html_text html_nodes
#' @param version_id version id
#' @param skip numeric vector of lines to skip on file read. optional.
#' @param dest_folder file.path optional will default to the location returned by \code{\link[rappdirs]{user_data_dir}}.
#' @param compile logical perform on-the-fly compilation to rds?
#' @examples \dontrun{
#' gshhg_get(version = "2.3.7")
#' }
gshhg_get <- function(version_id, skip = NA, dest_folder = NA, compile = TRUE){

  baseurl <- "ftp://ftp.soest.hawaii.edu/gshhg/"

  files <- read.delim(textConnection(
    RCurl::getURL(baseurl, dirlistonly = TRUE)), sep = "\n",
    stringsAsFactors = FALSE)[,1]
  files <- files[grep("zip", files)]
  files <- files[grep("shp", files)]
  files <- files[grep(version_id, files)]

  # dir.exists(cache_path())
  dir.create(cache_path(), showWarnings = FALSE)
  versioned_path <- paste0(cache_path(), version_id)
  dir.create(versioned_path, showWarnings = FALSE)

  invisible(
    lapply(files,
           function(x) get_if_not_exists(
             paste0(baseurl, x), file.path(versioned_path, x))
    ))

  # if(compile){
  #   nsws_compile(version_id = version_id, skip = skip)
  # }
}

cache_path <- function() paste0(rappdirs::user_data_dir(
  appname   = "gshhg",
  appauthor = "gshhg"), .Platform$file.sep)

get_if_not_exists <- function(url, destfile){
  if(!file.exists(destfile)){
    download.file(url, destfile)
  }else{
    message(paste0("A local copy of ", url, " already exists on disk"))
  }
}

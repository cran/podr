## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(podr)

## -----------------------------------------------------------------------------
  library(RPostgres)
  usr <- 'phuse_su67e99huj';
  pwd <- 'bGopEaaIQ7uB';
  con  <- conn_podr(usr,pwd) 
  str(con)

## -----------------------------------------------------------------------------
  library(tibble)
  library(stringr)
  library("DT")
  # Case 1: use query string to call read_podr 
  qry <- "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'";
  # cc <- read_podr(con = con, query_string = qry, limit = 1000 ) %>%
  #      add_column(libname = gsub('_[[:alpha:]]+$', '\\1', .[,"table_name"], ignore.case = TRUE )) %>%
  #      add_column(dataset = str_extract(.[,"table_name"], '([[:alpha:]]+)$' ))
  c1 <- read_podr(con = con, query_string = qry, limit = 1000 )
  c2 <- add_column(c1, libname = gsub('_[[:alpha:]]+$', '\\1', c1[,"table_name"], ignore.case = TRUE ))
  cc <- add_column(c2, dataset = str_extract(c2[,"table_name"], '([[:alpha:]]+)$' ))
  DT::datatable(cc)
  # Case 2: read record for a table
  tb <- 'virtual_css_2020_sdtm_ae'
  c2 <- read_podr(tabname = tb)
  DT::datatable(c2)
  # Case 3: read record for a data set in a library/category
  lb <- 'virtual_css_2020_sdtm';
  ds <- 'cm'
  c3 <- read_podr(libname = lb, dataset = ds)
  DT::datatable(c3)
  

## -----------------------------------------------------------------------------
  cc <- get_table_names()
  datatable(cc)

## -----------------------------------------------------------------------------
tb <- 'virtual_css_2020_sdtm_ae'
rr <- get_table_defs(tb) 
DT::datatable(rr)


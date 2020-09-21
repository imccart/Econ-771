
# Read yearly IPPS files --------------------------------------------------

## 1986 - 1993 (same format)
for (y in 1986:1993) {
  ipps.data <- read_csv(paste0(ipps.path,"/impact",y,".csv"))
  
  ipps.data <- ipps.data %>%
    rename(year=fyear,
           cmi=tacmiv) %>%
    select(provider, year, cmi, wageindex)
  
  assign(paste0("ipps.",y),ipps.data)  
}

## 1994 - 2000 (same format)
for (y in 1994:2000) {
  ipps.data <- read_csv(paste0(ipps.path,"/impact",y,".csv"))
  
  ipps.data <- ipps.data %>%
    rename(year=fyear,
           cmi=tacmiv,
           adj_cases=bills,
           daily_census=adc) %>%
    select(provider, year, daily_census, adj_cases, 
           beds, cmi, wageindex, dshpct, provtype)
  
  assign(paste0("ipps.",y),ipps.data)    
}

## 2001 - 2018 (same format)
for (y in 2001:2018) {
  ipps.data <- read_csv(paste0(ipps.path,"/impact",y,".csv"))
  
  ipps.data <- ipps.data %>%
    rename(year=fyear,
           cmi=tacmiv,
           adj_cases=caseta,
           daily_census=adc,
           provtype=ptype) %>%
    mutate(provtype=as.numeric(provtype)) %>%
    select(provider, year, daily_census, adj_cases, 
           beds, cmi, wageindex, dshpct, provtype)
  
  assign(paste0("ipps.",y),ipps.data)    
}


# Final IPPS data ---------------------------------------------------------

final.ipps.data <- ipps.1986
for (y in 1987:2018) {
  final.ipps.data <- bind_rows(final.ipps.data, get(paste0("ipps.",y)))
}

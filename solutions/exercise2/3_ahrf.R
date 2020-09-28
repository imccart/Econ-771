ahrf.data <- read.SAScii(fn=paste0(ahrf.path,"DATA/AHRF2019.asc"),
                         sas_ri=paste0(ahrf.path,"DOC/AHRF2018-19.sas"),
                         beginline=3) 

ahrf.data <- ahrf.data %>%
  select(state="F00008",
         state_short="F12424",
         county="F00010",
         fips_state="F00011",
         fips_county="F00012",
         ssa="F13156",
         starts_with("F15299"))


ahrf.data <- pivot_longer(ahrf.data, 
                          cols=starts_with("F15299"),
                          names_to="year",
                          names_prefix="F15299",
                          values_to="medicare_ffs_exp") %>%
  mutate(year=as.numeric(year)+2000,
         ssa=as.numeric(ssa))
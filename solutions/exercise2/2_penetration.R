## Read in market pentration data 

for (y in 2008:2015) {
  
  ## Pull market penetration data by county/year (just end of year)
  pene.path <- paste0(ma.path,"/Monthly MA State and County Penetration/Extracted Data/State_County_Penetration_MA_",y,"_12.csv")
  pene.data <- read_csv(pene.path,skip=1,
                        col_names=c("state","county","fips_state","fips_cnty","fips",
                                    "ssa_state","ssa_cnty","ssa","eligibles","enrolled",
                                    "penetration"),
                        col_types = cols(
                          state = col_character(),
                          county = col_character(),
                          fips_state = col_integer(),
                          fips_cnty = col_integer(),
                          fips = col_double(),
                          ssa_state = col_integer(),
                          ssa_cnty = col_integer(),
                          ssa = col_double(),
                          eligibles = col_number(),
                          enrolled = col_number(),
                          penetration = col_number()
                          ), na="*")
    
  ## Add year variable
  pene.data = pene.data %>%
    mutate(year=y) %>%
    group_by(state, county) %>%
    fill(fips)

  assign(paste0("ma.pene.",y),pene.data)  
}

ma.penetration.data=rbind(ma.pene.2008,ma.pene.2009,ma.pene.2010,
                          ma.pene.2011,ma.pene.2012,ma.pene.2013,ma.pene.2014,ma.pene.2015)
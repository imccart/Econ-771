
# Read yearly files -------------------------------------------------------

for (y in 1984:1990) {
  pos.data <- read_csv(paste0(pos.path,"/pos",y,".csv/pos",y,".csv"))
  
  pos.data <- pos.data %>%
    rename(provider=prov1680,
           own_change=prov0100,
           beds_cert=prov0755,
           beds_tot=prov0740,
           name=prov0475,
           street=prov2720,
           city_state=prov0115,
           zip=prov2905,
           fac_type=prov2890,
           own_type=prov2885,
           term_date=prov2810) %>%
    mutate(term_date=as.Date(as.character(term_date), format='%y%m%d'),
           own_change=as.Date(as.character(term_date), format='%y%m%d'),
           state=str_sub(city_state, start=-2),
           city=str_sub(city_state, start=1, end=-2),
           year=y) %>%
    select(provider, category, own_change, beds_cert, beds_tot, name,
           street, city, state, zip, term_date, fac_type, own_type, year) %>%
    filter(provider!='000000')

  assign(paste0("pos.",y),pos.data)  
}



y=1991
pos.data <- read_csv(paste0(pos.path,"/pos",y,".csv/pos",y,".csv"))
pos.data <- pos.data %>%
  rename(category=prvdr_ctgry_cd,
         category_sub=prvdr_ctgry_sbtyp_cd,
         provider=prvdr_num,
         own_change=chow_dt,
         beds_cert=crtfd_bed_cnt,
         beds_tot=bed_cnt,
         name=fac_name,
         street=st_adr,
         city_state=prov0115,
         zip=zip_cd,
         fac_type=gnrl_fac_type_cd,
         own_type=gnrl_cntl_type_cd,
         term_date=prov2810) %>%
  mutate(term_date=as.Date(as.character(term_date), format='%y%m%d'),
         own_change=as.Date(as.character(term_date), format='%y%m%d'),
         state=str_sub(city_state, start=-2),
         city=str_sub(city_state, start=1, end=-2),
         year=y) %>%
  select(provider, category, category_sub, own_change, beds_cert, beds_tot, name,
         street, city, state, zip, term_date, fac_type, own_type, year) %>%
  filter(provider!='000000')

assign(paste0("pos.",y),pos.data)  


for (y in 1992:1993) {
  pos.data <- read_csv(paste0(pos.path,"/pos",y,".csv/pos",y,".csv"))
  
  pos.data <- pos.data %>%
    rename(category=prvdr_ctgry_cd,
           category_sub=prvdr_ctgry_sbtyp_cd,           
           provider=prvdr_num,
           own_change=chow_dt,
           beds_cert=crtfd_bed_cnt,
           beds_tot=bed_cnt,
           name=fac_name,
           street=st_adr,
           zip=zip_cd,
           own_type=gnrl_cntl_type_cd,
           term_date=prov2810,
           state=state_cd) %>%
    mutate(term_date=as.Date(as.character(term_date), format='%y%m%d'),
           own_change=as.Date(as.character(term_date), format='%y%m%d'),
           year=y) %>%
    select(provider, category, category_sub, own_change, beds_cert, beds_tot, name,
           street, city, state, zip, term_date, own_type, year)
  
  assign(paste0("pos.",y),pos.data)  
}

y=1994
pos.data <- read_csv(paste0(pos.path,"/pos",y,".csv/pos",y,".csv"))
pos.data <- pos.data %>%
  rename(category=prvdr_ctgry_cd,
         category_sub=prvdr_ctgry_sbtyp_cd,         
         provider=prvdr_num,
         own_change=chow_dt,
         beds_cert=crtfd_bed_cnt,
         beds_tot=bed_cnt,
         name=fac_name,
         street=st_adr,
         zip=zip_cd,
         own_type=gnrl_cntl_type_cd,
         term_date=trmntn_exprtn_dt,
         state=state_cd) %>%
  mutate(term_date=as.Date(as.character(term_date), format='%y%m%d'),
         own_change=as.Date(as.character(term_date), format='%y%m%d'),
         year=y) %>%
  select(provider, category, category_sub, own_change, beds_cert, beds_tot, name,
         street, city, state, zip, term_date, own_type, year)
assign(paste0("pos.",y),pos.data)  


for (y in 1995:2010) {
  pos.data <- read_csv(paste0(pos.path,"/pos",y,".csv/pos",y,".csv"))
  pos.data <- pos.data %>%
    rename(category=prvdr_ctgry_cd,
           category_sub=prvdr_ctgry_sbtyp_cd,           
           provider=prvdr_num,
           own_change=chow_dt,
           beds_cert=crtfd_bed_cnt,
           beds_tot=bed_cnt,
           name=fac_name,
           street=st_adr,
           zip=zip_cd,
           own_type=gnrl_cntl_type_cd,
           term_date=trmntn_exprtn_dt,
           state=state_cd) %>%
    mutate(term_date=as.Date(as.character(term_date), format='%Y%m%d'),
           own_change=as.Date(as.character(term_date), format='%Y%m%d'),
           year=y) %>%
    select(provider, category, category_sub, own_change, beds_cert, beds_tot, name,
           street, city, state, zip, term_date, own_type, year)
  
  assign(paste0("pos.",y),pos.data)  
}


for (y in 2011:2018) {
  pos.data <- read_csv(paste0(pos.path,"/pos",y,".csv/pos",y,".csv"))
  colnames(pos.data) <- tolower(colnames(pos.data))
  
  pos.data <- pos.data %>%
    rename(category=prvdr_ctgry_cd,
           category_sub=prvdr_ctgry_sbtyp_cd,           
           provider=prvdr_num,
           own_change=chow_dt,
           beds_cert=crtfd_bed_cnt,
           beds_tot=bed_cnt,
           name=fac_name,
           street=st_adr,
           zip=zip_cd,
           city=city_name,
           own_type=gnrl_cntl_type_cd,
           term_date=trmntn_exprtn_dt,
           state=state_cd) %>%
    mutate(term_date=as.Date(as.character(term_date), format='%Y%m%d'),
           own_change=as.Date(as.character(term_date), format='%Y%m%d'),
           year=y) %>%
    select(provider, category, category_sub, own_change, beds_cert, beds_tot, name,
           street, city, state, zip, term_date, own_type, year)
  
  assign(paste0("pos.",y),pos.data)  
}



# Final data --------------------------------------------------------------
final.pos.data <- pos.1984
for (y in 1984:2018) {
  final.pos.data <- bind_rows(final.pos.data, get(paste0("pos.",y)))
}


## Recode relevant variables
final.pos.data <- final.pos.data %>%
  mutate(category_sub=str_pad(category_sub, width=2, side="left", pad="0")) %>%
  mutate(category = 
           case_when(
             category=="01" ~ "Hospital",
             category %in% c("02","03","04") ~ "SNF",
             category=="05" ~ "Home Health",
             category=="06" ~ "Psychiatric",
             category=="07" ~ "Portable X-Ray",
             category=="08" ~ "Physical Therapy",
             category=="09" ~ "ESRD",
             category=="10" ~ "Nursing",
             category=="11" ~ "Intermediate Care",
             category=="12" ~ "Rural Health Clinic",
             category=="13" ~ "Outpatient Rehab",
             category=="14" ~ "ASC",
             category=="15" ~ "Hospice",
             category=="16" ~ "Organ Procurement",
             category %in% c("17","21") ~ "CLIA Lab",
             category=="18" ~ "Community Health Center",
             category=="19" ~ "Screening Mammography",
             category=="20" ~ "Federally Qualified Health Center"),
         category_sub =
           case_when(
             category_sub=="01" ~ "Short Term",
             category_sub=="02" ~ "Long Term",
             category_sub=="03" ~ "Religious Nonmedical",
             category_sub=="04" ~ "Psychiatric",
             category_sub=="05" ~ "Rehabilitation",
             category_sub=="06" ~ "Children",
             category_sub=="07" ~ "Partial Psychiatric",
             category_sub=="11" ~ "Critical Access",
             category_sub=="20" ~ "Transplant",
             category_sub=="22" ~ "Medicaid-only Non-psychiatric",
             category_sub=="23" ~ "Medicaid-only Psyciatric"),
         own_type =
           case_when(
             own_type=="01" ~ "Non-profit Church",
             own_type=="02" ~ "Non-profit Private",
             own_type=="03" ~ "Non-profit Other",
             own_type=="04" ~ "Profit",
             own_type=="05" ~ "Govt Federal",
             own_type=="06" ~ "Govt State",
             own_type=="07" ~ "Govt Local",
             own_type=="08" ~ "Govt Hospital District",
             own_type=="09" ~ "Physician Owned",
             own_type=="10" ~ "Tribal")
           )


## Keep only short term acute care hospitals
final.pos.data <- final.pos.data %>%
  filter(category=="Hospital") %>%
  group_by(provider) %>%
  arrange(provider, year) %>%
  fill(c("category_sub", "own_change", "term_date"), .direction="downup")

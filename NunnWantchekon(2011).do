
**************************
****** Juan Bonilla ******
******      TP      ****** 


*abrimos la bbdd de Nunn
use "Nunn_Wantchekon_AER_2011.dta", clear

*IV clusteareado por distrito para cada variable dependiente 
local baseline_controls "age age2 male urban_dum i.education i.occupation i.religion i.living_conditions district_ethnic_frac frac_ethnicity_in_district i.isocode"
local colonial_controls "malaria_ecology total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33"

ivreg2 trust_relatives ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(district)
est store ivdrelatives

ivreg2 trust_neighbors ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(district)
est store ivdneighbors

ivreg2 intra_group_trust ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(district)
est store ivdgroupintra

ivreg2 inter_group_trust ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(district)
est store ivdgroupinter

ivreg2 trust_local_council ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(district)
est store ivdlocal 

esttab ivdrelatives ivdneighbors ivdlocal ivdgroupintra ivdgroupinter 


*IV clusteareando los ee por etnia 
local baseline_controls "age age2 male urban_dum i.education i.occupation i.religion i.living_conditions district_ethnic_frac frac_ethnicity_in_district i.isocode"
local colonial_controls "malaria_ecology total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33"
 
ivreg2 trust_relatives ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
est store ivetrelatives

ivreg2 trust_neighbors ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
est store ivetneighbors

ivreg2 intra_group_trust ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
est store ivetgroupintra

ivreg2 inter_group_trust ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
est store ivetgroupinter

ivreg2 trust_local_council ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
est store ivetlocal 

esttab ivetrelatives ivetneighbors ivetgroupintra ivetgroupinter ivetlocal


***checklist***
*ploteo de la var independiente endógena y el instrumento
corr distsea ln_export_area
twoway (scatter distsea ln_export_area) (lfit distsea ln_export_area)

**para exportar la tabla a un doc en Word
*con ee clustereados a nivel de grupo étnico
ivreg2 trust_relatives ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
outreg2 using tp2murdock.doc, replace ctitle (Trust of relatives)

ivreg2 trust_neighbors ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
outreg2 using tp2murdock.doc, append ctitle (Trust of neighbors)

ivreg2 trust_local_council ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
outreg2 using tp2murdock.doc, append ctitle (Trust of local council)

ivreg2 intra_group_trust ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
outreg2 using tp2murdock.doc, append ctitle (Intragroup trust)

ivreg2 inter_group_trust ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
outreg2 using tp2murdock.doc, append ctitle (Intergroup trust)


*con ee clustereados a nivel distrital
ivreg2 trust_relatives ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(district)
outreg2 using tp2district.doc, replace ctitle (Trust of relatives)

ivreg2 trust_neighbors ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(district)
outreg2 using tp2district.doc, append ctitle (Trust of neighbors)

ivreg2 trust_local_council ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
outreg2 using tp2district.doc, append ctitle (Trust of local council)

ivreg2 intra_group_trust ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
outreg2 using tp2district.doc, append ctitle (Intragroup trust)

ivreg2 inter_group_trust ln_init_pop_density `baseline_controls' `colonial_controls' (ln_export_area=distsea), cluster(murdock_name)
outreg2 using tp2district.doc, append ctitle (Intergroup trust)







<!-- README.md is generated from README.Rmd. Please edit that file -->

# inkr

{inkr} provides efficient and automated access to data from
[inkar.de](https://www.inkar.de) via a local relational database.

Data from [INKAR](https://www.inkar.de)[^1] are normalised[^2] and
imported into a local [DuckDB](https://duckdb.org) database. On attach
(e.g. with `library(inkr)`), a [DBI](https://dbi.r-dbi.org/) connection
is made from R to this database.

## Installation

You can install {inkr} like so:

``` r
remotes::install_github("long39ng/inkr")
```

## Usage

A local database containing the INKAR data must be built before first
use:

``` r
library(inkr)

inkar_db_build()
```

Afterwards, all the tables in the local INKAR database are accessible in
R via an object named `inkar`.[^3]

Currently, `inkar` contains the following tables:

``` r
# See `?inkar` for more details
names(inkar)
#>  [1] "_indikatoren"                        
#>  [2] "_regionen"                           
#>  [3] "absolutzahlen"                       
#>  [4] "arbeitslosigkeit"                    
#>  [5] "bauen_und_wohnen"                    
#>  [6] "beschaeftigung_und_erwerbstaetigkeit"
#>  [7] "bevoelkerung"                        
#>  [8] "bildung"                             
#>  [9] "europa"                              
#> [10] "flaechennutzung_und_umwelt"          
#> [11] "medizinische_und_soziale_versorgung" 
#> [12] "oeffentliche_finanzen"               
#> [13] "privateinkommen_private_schulden"    
#> [14] "raumwirksame_mittel"                 
#> [15] "sdg"                                 
#> [16] "siedlungsstruktur"                   
#> [17] "sozialleistungen"                    
#> [18] "verkehr_und_erreichbarkeit"          
#> [19] "wirtschaft"                          
#> [20] "zom"
```

You can use {dplyr} to work with the tables in `inkar` as if they were
in-memory data frames, e.g.:

``` r
library(dplyr)

inkar$`_regionen` |>
  distinct(raumbezug) |>
  arrange(raumbezug)
#> # Source:     SQL [?? x 1]
#> # Database:   DuckDB 0.6.0 [lngyuen@Linux 5.15.0-56-generic:R 4.2.2//home/lngyuen/R/x86_64-pc-linux-gnu-library/4.2/inkr/db/inkar.duckdb]
#> # Ordered by: raumbezug
#>    raumbezug                         
#>    <chr>                             
#>  1 Arbeitsmarktregionen              
#>  2 BBSR-Mittelbereiche               
#>  3 Braunkohlerevier                  
#>  4 Bund                              
#>  5 Bundesländer                      
#>  6 EU                                
#>  7 Gemeinden                         
#>  8 Gemeindeverbände                  
#>  9 Großstadtregionaler Einzugsbereich
#> 10 Großstadtregionen                 
#> # … with more rows

inkar$`_indikatoren` |>
  count(bereich)
#> # Source:   SQL [?? x 2]
#> # Database: DuckDB 0.6.0 [lngyuen@Linux 5.15.0-56-generic:R 4.2.2//home/lngyuen/R/x86_64-pc-linux-gnu-library/4.2/inkr/db/inkar.duckdb]
#>    bereich                                 n
#>    <chr>                               <dbl>
#>  1 Absolutzahlen                          10
#>  2 Arbeitslosigkeit                       34
#>  3 Bauen und Wohnen                       19
#>  4 Beschäftigung und Erwerbstätigkeit     47
#>  5 Bevölkerung                            81
#>  6 Bildung                                30
#>  7 Privateinkommen, Private Schulden      15
#>  8 Flächennutzung und Umwelt              17
#>  9 Medizinische und soziale Versorgung    20
#> 10 Öffentliche Finanzen                   10
#> # … with more rows
```

### Example: median income

Find the indicator ID for the median income:

``` r
inkar$`_indikatoren` |>
  filter(kurzname == "Medianeinkommen")
#> # Source:   SQL [1 x 7]
#> # Database: DuckDB 0.6.0 [lngyuen@Linux 5.15.0-56-generic:R 4.2.2//home/lngyuen/R/x86_64-pc-linux-gnu-library/4.2/inkr/db/inkar.duckdb]
#>      id bereich                           kurzname name  algor…¹ anmer…² stati…³
#>   <int> <chr>                             <chr>    <chr> <chr>   <chr>   <chr>  
#> 1   224 Privateinkommen, Private Schulden Mediane… Medi… Median… Median… Statis…
#> # … with abbreviated variable names ¹​algorithmus, ²​anmerkungen,
#> #   ³​statistische_grundlagen
```

5 counties with the highest median income in 2019:

``` r
inkar$privateinkommen_private_schulden |>
  filter(zeitbezug == 2019) |>
  select(region_id, x224) |> # Got indicator ID 224 from above
  rename_with_inkar_indicators() |> # Get INKAR name for x224: medianeinkommen
  # Join with the `_regionen` table to get region names and types
  left_join(inkar$`_regionen`, by = c("region_id" = "id")) |>
  arrange(desc(medianeinkommen)) |>
  filter(raumbezug == "Kreise") |>
  head(5) |>
  select(name, medianeinkommen)
#> # Source:     SQL [5 x 2]
#> # Database:   DuckDB 0.6.0 [lngyuen@Linux 5.15.0-56-generic:R 4.2.2//home/lngyuen/R/x86_64-pc-linux-gnu-library/4.2/inkr/db/inkar.duckdb]
#> # Ordered by: desc(medianeinkommen)
#>   name                         medianeinkommen
#>   <chr>                                  <dbl>
#> 1 Wolfsburg, Stadt                       5089.
#> 2 Ingolstadt, Stadt                      5004.
#> 3 Erlangen, Stadt                        4907.
#> 4 Böblingen                              4809.
#> 5 Ludwigshafen am Rhein, Stadt           4721.
```

[^1]: downloaded via
    [“Datenbankdownload”](https://www.bbr-server.de/imagemap/inkar/download/inkar_2021.zip)

[^2]: i.e. not a single table with 21 million rows

[^3]: More precisely, `inkar` contains connections to the tables in the
    DuckDB database via [DBI](https://dbi.r-dbi.org/) and
    [dbplyr](https://dbplyr.tidyverse.org/).

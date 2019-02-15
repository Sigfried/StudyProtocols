
library(DatabaseConnector)
library(tidyverse)
readRenviron('.env')

connectionDetails <- createConnectionDetails( dbms="postgresql", 
                                              server=paste0(Sys.getenv("PGHOST"),'/',
                                                            Sys.getenv('PGDATABASE')),
                                              user = Sys.getenv('PGUSER'),
                                              password = Sys.getenv('PGPASSWORD'),
                                              schema="mimic3_100p")

conn <- connect(connectionDetails)





OhdsiRTools::insertCohortDefinitionSetInPackage(fileName = "settings.csv",
                                                baseUrl = "http://api.ohdsi.org:80/WebAPI",
                                                insertTableSql = TRUE,
                                                insertCohortCreationR = TRUE,
                                                generateStats = FALSE,
                                                packageName="ischemicStrokePhenotype")

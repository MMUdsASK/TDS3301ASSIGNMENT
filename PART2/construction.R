library(sqldf)

# create database connection
db <- dbConnect(SQLite(), dbname="bakery1000")
options(warn=-1)

# create goods table
dbSendQuery(db,"create table goods ( 
            Id int,
            Flavor varchar2(15), 
            Food varchar2(15), 
            Price float, 
            Type varchar2(5),
            constraint gpid PRIMARY KEY (Id)
);")

# build goods table
lines <- readLines('EB-build-goods.sql')
for (i in 1:length(lines)) {
  dbSendQuery(db,lines[i])
}

# create employee table
dbSendQuery(db,"create table employee ( 
   Last varchar2(15),
   First varchar2(15), 
   HireDate  Date, 
   FireDate  Date, 
   Position varchar2(15), 
   FullTime varchar2(5), 
   StoreNum int, 
   EmpId int, 
   constraint efid FOREIGN KEY (StoreNum) REFERENCES location, 
   constraint epid PRIMARY KEY (EmpId)
);")


lines <- readLines('EB-build-employee.sql')
for (i in 1:length(lines)) {
  dbSendQuery(db,lines[i])
}





# create location table
dbSendQuery(db,"create table location ( 
   City varchar2(15),
   State varchar2(15), 
   Zip int, 
   Street varchar2(20), 
   StoreNum int, 
   constraint lpid PRIMARY KEY (StoreNum)
);")


# build location table
lines <- readLines('EB-build-location.sql')
for (i in 1:length(lines)) {
  dbSendQuery(db,lines[i])
}


# create item table
dbSendQuery(db,"create table items ( 
   Receipt int,
   Quantity int, 
   Item int, 
   constraint ifid FOREIGN KEY (Receipt) REFERENCES receipts, 
   constraint iffid FOREIGN KEY (Item) REFERENCES goods,
   constraint ipid PRIMARY KEY(Receipt, Item)
 );")

# build item table
linei <- readLines('EB-build-items.sql')
for (i in 1:length(linei)) {
  dbSendQuery(db,linei[i])
}

# create receipts table
dbSendQuery(db,"create table receipts ( 
  ReceiptNumber int,
  SaleDate date,
  Weekend varchar2(5), 
  isCash varchar2(5), 
  EmpId int, 
  StoreNum int, 
  constraint rfid FOREIGN KEY (StoreNum) REFERENCES location, 
  constraint rffid FOREIGN KEY (EmpId) REFERENCES employee, 
  constraint rpid PRIMARY KEY (ReceiptNumber)
);")

# build goods table
liner <- readLines('EB-build-receipts.sql')
for (i in 1:length(liner)) {
  dbSendQuery(db,liner[i])
}

# read goods table to a dataframe
goods <- dbGetQuery(db,'select * from goods')
# read employee table to a dataframe
employee <- dbGetQuery(db,'select * from employee')
# read location table to a dataframe
location <- dbGetQuery(db,'select * from location')
# read item table to a dataframe
items <- dbGetQuery(db,'select * from items')
# read receipts table to a dataframe
receipts <- dbGetQuery(db,'select * from receipts')

id <- cbind(rowid = as.vector(t(row)))


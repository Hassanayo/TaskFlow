module csv::ast::csv

data Table  
     = table(list[Record] records)
     ;

data Record  
     = record(list[Field] fields)
     ;
     
data Field  
     = unquoted(str text)
     | quoted(str text)
     ;

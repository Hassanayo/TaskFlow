module csv::prettyprint::csv
import csv::ast::csv;
import List;

public str toString(table(list[Record] records)){

    return toString(records);
}

public str toString(list[Record] records){

    return intercalate("\n", [toString(r) | r <- records]);
}

public str toString(record(list[Field] fields)){

    return intercalate(",", [toString(r) | r <- fields]);
}

public str toString(Field field){
    return field.text;
}
module taskflow::translations::ToCSV

import taskflow::ast::TaskFlow;
import IO;
import taskflow::utils::Utils;
import csv::ast::csv;
import Node;
import List;

import csv::prettyprint::csv;


TaskList newTasks= getTaskAst();

public str toCSV(TaskList task = newTasks){
    opts = task.tasks;

    first = (getChildren(opts[0]));
    list[Record] records = [];
    // Table newTable = table(records);
    list[str] initRecord = [];

    sigh = ["description","assignee","reporter","labels","sprint","priority","status","parent","date","link","completion"];

    for(i <- opts) {

        records += record(getRecords(i, sigh));
    }
    finalRecord = [unquoted(rec) | rec <- sigh];
    finalRecord = push(unquoted("taskname"), finalRecord);

    // println(initRecord);
    Table newTable = table(record(finalRecord)+ records);
    return toString(newTable);
}

public list[Field] getRecords(Task t, list[str] checks){
    f = [unquoted(t.taskDesc)];

    for(check <- checks){
        bool found = false;

        for(opt <- t.taskOpt){
            
            if(check == getName(opt)){
                found = true;
                switch(opt){
                    case description(str description): {
                        f += unquoted(description);

                    }
                    case assignee(list[str] assignee):{
                        f += unquoted("\"<intercalate(",", assignee)>\"");


                    }
                    case reporter(str reporter):{
                        f += unquoted(reporter);
                    }
                    case labels(list[str] labels):{
                        f += unquoted("\"<intercalate(",", labels)>\"");

                    }
                    case sprint(str sprint):{
                        f += unquoted(sprint);
                    }
                    case priority(Priority p):{
                        if(low() := p){
                            f += unquoted("low");
                        } else if(high() := p){
                            f += unquoted("high");
                        } else if(normal() := p){
                            f += unquoted("normal");
                        }
                    }
                    case status(Status s):{
                        if(todo() := s){
                            f += unquoted("todo");
                        } else if(inProgress() := s){
                            f += unquoted("in-progress");
                        } else if(done() := s){
                            f += unquoted("done");
                        }
                    }
                    case parent(str parent):{
                        f += unquoted(parent);
                    }
                    case date(str date):{
                        f += unquoted(date);
                    }
                    case link(str link):{
                        f += unquoted(link);
                    }
                    case completion(str compTime):{
                        f += unquoted(compTime);
                    }

                    default: throw "unhandled <opt>";
                }
                
            } 
            
        }
            if (!found) {
                f += unquoted("");
            }
    }
    return f;
}

public void writeToCsv(){
    writeFile(|project://converter/src/examples/test.csv|, toCSV());
}
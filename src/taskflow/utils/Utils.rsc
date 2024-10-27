module taskflow::utils::Utils

import ParseTree;
import taskflow::grammar::TaskFlow;
import taskflow::ast::TaskFlow;

public TaskList getTaskAst(loc location=|project://taskflow/src/examples/test.tsf|){
    return implode(#taskflow::ast::TaskFlow::TaskList,parse(#taskflow::grammar::TaskFlow::TaskList,location));
} 
public TaskList getTaskAst(str location){
    return implode(#taskflow::ast::TaskFlow::TaskList,parse(#taskflow::grammar::TaskFlow::TaskList,location));
} 


public start[TaskList] parseEvent(loc file=|project://taskflow/src/examples/test.tsf|){
    return parse(#start[TaskList],file);
}

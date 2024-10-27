module taskflow::ast::TaskFlow

data TaskList = taskList(list[Task] tasks);

data Task = task(str taskDesc, list[TaskOption] taskOpt);

data TaskOption
    = description(str description)
    | assignee(list[str] assignee)
    | reporter(str reporter)
    | labels(list[str] labels)
    | sprint(str sprint)
    | priority(Priority priority)
    | status(Status status)
    | parent(str parent)
    | date(str date)
    | link(str link)
    | completion(str compTime)
    ;

data Priority
    = low()
    | high()
    | normal()
    ;

data Status
    = todo()
    | inProgress()
    | done()
    ;

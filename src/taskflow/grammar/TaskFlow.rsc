module taskflow::grammar::TaskFlow

extend taskflow::grammar::Literals;

start syntax TaskList = taskList: Task+;

syntax Task = task: "task" Id "{" TaskOption+ "}";

syntax TaskOption
    = description: 'description' ":" String
    | assignee: 'assignee' ":" "[" {Id ","}+ "]"
    | reporter: 'reporter' ":" Id
    | labels: 'labels' ":" "[" {Id ","}+ "]"
    | sprint: 'sprint' ":" Id
    | priority: 'priority' ":" Priority
    | status: 'status' ":" Status
    | parent: 'Parent-Task' ":" Id
    | date: 'Date-Created' ":" DatePart
    | link: 'link' ":" String
    | completion: 'Completion-Time' ":" Int
    ;

syntax Priority
    = low: 'Low'
    | high: 'High'
    | normal: 'Normal'
    ;

syntax Status
    = todo: 'todo'
    | inProgress: 'in-progress'
    | done: 'done'
    ;
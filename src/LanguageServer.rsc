module LanguageServer

import ParseTree;
import taskflow::grammar::TaskFlow;
import util::LanguageServer;

import util::Reflective;
import Prelude;



set[LanguageService] tsfLanguage() = {
    parser(parser(#start[TaskList]))
};


void setupIDE() {
  registerLanguage(
    language(
    pathConfig(srcs = [|std:///|, |project://taskflow/src|]),
    "TSF Grammar", 
    "tsf", 
    "LanguageServer",
    "tsfLanguage"
   ));
}




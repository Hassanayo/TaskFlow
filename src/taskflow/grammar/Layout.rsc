module taskflow::grammar::Layout

lexical Whitespace
  = [\t-\n\r\ ]
  ;

lexical Comment
  = @category="Comment" "/*" CommentChar* "*/"
  | @category="Comment" "//" ![\n]*  $
  ;

lexical CommentChar
  = ![*]
  | [*] !>> [/]
  ;

lexical LAYOUT
  = Whitespace
  | Comment
  ;

layout LAYOUTLIST
  = LAYOUT*
  !>> [\t\ \n]
  !>> "/*"
  !>> "//" 
  ;
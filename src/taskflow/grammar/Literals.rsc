module taskflow::grammar::Literals

extend taskflow::grammar::Layout;

syntax Literal
 = null: "null"
 | numeric: Int num
 | string: String str
 ;

lexical Id 
  = ([a-zA-Z$_0-9] !<< [$_a-zA-Z] [a-zA-Z$_0-9]* !>> [a-zA-Z$_0-9]) 
  ;

lexical Int = @category="Constant"  [0-9] !<< [0-9]+ !>> [0-9];

lexical String
  = @category="Constant" [\"] StringCharacter* [\"]
  | @category="Constant" [\'] SingleQuoteStringCharacter* [\']
  ; 

lexical StringCharacter
  = "\\" [\" \\ b f n r t] 
  | UnicodeEscape 
  | ![\" \\]
  | [\n][\ \t \u00A0 \u1680 \u2000-\u200A \u202F \u205F \u3000]* [\'] // margin 
  | "\\" Int
  ;

lexical SingleQuoteStringCharacter
  = "\\" [\' \\ b f n r t] 
  | UnicodeEscape 
  | ![\' \\]
  | [\n][\ \t \u00A0 \u1680 \u2000-\u200A \u202F \u205F \u3000]* [\'] // margin 
  | "\\" Int
  ; 

lexical UnicodeEscape
  = utf16: "\\" [u] [0-9 A-F a-f] [0-9 A-F a-f] [0-9 A-F a-f] [0-9 A-F a-f] 
  | utf32: "\\" [U] (("0" [0-9 A-F a-f]) | "10") [0-9 A-F a-f] [0-9 A-F a-f] [0-9 A-F a-f] [0-9 A-F a-f] // 24 bits 
  | ascii: "\\" [a] [0-7] [0-9A-Fa-f]
;

syntax DateTime
   = date: JustDate date
   | time: JustTime time
   | full: DateAndTime dateTime ;

lexical JustDate
	= "$" DatePart "$";
	
lexical DatePart = Year y "-" Month m "-" Day d;
	
lexical Year = [0-9] [0-9] [0-9] [0-9];
lexical Month = [0-1] [0-9];
lexical Day = [0-3] [0-9];
	
lexical DateAndTime = "$" DatePart "T" TimePart ZoneOffset? "$";

lexical ZoneOffset 
	= [+ \-] Hour h ":" Minute m
	| "Z" 
	;

lexical TimePart = Hour h ":" Minute m;
lexical Hour = [0-2] [0-9];
lexical Minute = [0-5] [0-9];
lexical Second = [0-5] [0-9];
lexical Millisecond = [.] [0-9] ([0-9] [0-9]?)?;




lexical JustTime
	= "$T" TimePartNoTZ !>> [+\-] "$"
	| "$T" TimePartNoTZ TimeZonePart "$"
	;


lexical TimePartNoTZ
	= [0-2] [0-9] [0-5] [0-9] [0-5] [0-9] ([, .] [0-9] ([0-9] [0-9]?)?)? 
	| [0-2] [0-9] ":" [0-5] [0-9] ":" [0-5] [0-9] ([, .] [0-9] ([0-9] [0-9]?)?)? 
	;

lexical TimeZonePart
	= [+ \-] [0-1] [0-9] ":" [0-5] [0-9] 
	| "Z" 
	| [+ \-] [0-1] [0-9] 
	| [+ \-] [0-1] [0-9] [0-5] [0-9] 
	;

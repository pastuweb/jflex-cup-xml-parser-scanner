///////////////////////////////////

/// Scanner: protocollo PWXML ////

///////////////////////////////////

import java_cup.runtime.*;

%%

%class scanner
%unicode
%cup
%line
%column


%{
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

num = [0-9]+
numero = {num}((","|"."){num})?
stringa = [a-zA-Z]+ ([_a-zA-Z0-9 \':;,\.\?ìèòàù!\(\)-]+)*

ora = (([0-1]?[0-9]) | ([2][0-3]))([0-5]?[0-9])([0-5]?[0-9])
mese = 0[1-9] | 1[0-2]
giorno = 0[1-9] | [1-2][0-9] | 3[0-1]
anno = [0-9]{4}
timestamp = {anno}{mese}{giorno}{ora}
  
apici = (" ")*"\""(" ")*


//tags
tag_pwxml_open = "<PWXML " | "<pwxml " 
tag_pwxml_close = "</PWXML>" | "</pwxml>" 

tag_comando_open = "<COMANDO " | "<comando " 
tag_comando_close = "</COMANDO>" | "</comando" 

tag_proprieta_open = "<PROPRIETA " | "<proprieta " 
tag_proprieta_close = "</PROPRIETA>" | "</proprieta>"  

tag_lista_open = "<LISTA " | "<lista " 
tag_lista_close = "</LISTA>" | "</lista>" 

tag_item_open = "<ITEM " | "<item " 
tag_item_close = "</ITEM>" | "</item>" 

// attributi
attr_value = "VALUE" | "value"
attr_timestamp = "TIMESTAMP" | "timestamp"
attr_name = "NAME" | "name"
attr_tipo = "TIPO" | "tipo"
attr_id= "ID" | "id"

%%

{tag_pwxml_open} {return new Symbol(sym.PWXML_OPEN);}
{tag_pwxml_close} {return new Symbol(sym.PWXML_CLOSE);}
{tag_comando_open} {return new Symbol(sym.COMANDO_OPEN);}
{tag_comando_close} {return new Symbol(sym.COMANDO_CLOSE);}
{tag_proprieta_open} {return new Symbol(sym.PROPRIETA_OPEN);}
{tag_proprieta_close} {return new Symbol(sym.PROPRIETA_CLOSE);}
{tag_lista_open} {return new Symbol(sym.LISTA_OPEN);}
{tag_lista_close} {return new Symbol(sym.LISTA_CLOSE);}
{tag_item_open} {return new Symbol(sym.ITEM_OPEN);}
{tag_item_close} {return new Symbol(sym.ITEM_CLOSE);}

{attr_value} {return new Symbol(sym.ATTR_VALUE);}
{attr_timestamp} {return new Symbol(sym.ATTR_TIMESTAMP);}
{attr_name} {return new Symbol(sym.ATTR_NAME);}
{attr_tipo} {return new Symbol(sym.ATTR_TIPO);}
{attr_id} {return new Symbol(sym.ATTR_ID);}

{apici} {return new Symbol(sym.APICI); }
">"  {return new Symbol(sym.PAR_ANG_C); }
"="  {return new Symbol(sym.UG);}
"/"  {return new Symbol(sym.DIV);}


//attenzione all'ordine, dal più specifico al più generico
{timestamp} {return new Symbol(sym.TIMESTAMP, new String(yytext())); }
{numero} {return new Symbol(sym.NUMERO, new String(yytext())); } //no Double per via della possibile virgola
{stringa} {return new Symbol(sym.STRINGA, new String(yytext()));}


[ \n\r\t]       {;}
.               {System.out.println("SCANNER ERROR: "+yytext());}

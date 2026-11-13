%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s);
%}
%token NUMBER
%%
input : expr '\n'
      {
          printf("Result = %d\n", $1);
      }
      ;
expr  : NUMBER
      {
          $$ = $1;
      }
      | expr expr '+'
      {
          $$ = $1 + $2;
      }
      | expr expr '-'
      {
          $$ = $1 - $2;
      }
      | expr expr '*'
      {
          $$ = $1 * $2;
      }
      | expr expr '/'
      {
          if ($2 == 0)
          {
              printf("Division by zero error\n");
              $$ = 0;
          }
          else
          {
              $$ = $1 / $2;
          }
      }
      ;
%%
int main()
{
    printf("Enter postfix expression: ");
    yyparse();
    return 0;
}
void yyerror(const char *s)
{
    printf("Invalid postfix expression\n");
}

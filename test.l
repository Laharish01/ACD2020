%{ 
    #include<stdio.h>
    #include<string.h>
%}
  
start \/\* 
end  \*\/ 
  

%% 
  

\/\/(.*) ; 

{start}.*{end} ; 
  
%% 
  

int main(int k,char **argcv) 
{ 
yyin=fopen(argcv[1],"r"); 
yylex(); 
return 0; 
} 

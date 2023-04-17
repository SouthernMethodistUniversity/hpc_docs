data class;
   input name $ 1-8 sex $ 10 age 12-13 height 15-16 weight 18-22;
cards;
john       m    12    59   99.5
james      m    12    57   83.0
alfred     m    14    69   112.5
alice      f    13    56   84.0

proc means;
   var age height weight;

filename outgraph 'plot.png';
goptions gsfname=outgraph;

proc gplot data=sashelp.class;
   plot weight*height;

endsas;
;


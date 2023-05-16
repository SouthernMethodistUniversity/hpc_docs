#!/usr/bin/env python
# Python shell script example
# Dan Reynolds
# May 2013

# define the "odd" function, takes one argument
def odd(val):
   print "  ", val, " is odd"

# define the "even" function, takes one argument
def even(val):
   print "  ", val, " is even"

# define the "other" function, takes one argument
def other(val):
   print "  ", val, " is neither even nor odd"

# loop over some integers, checking even/odd
for i in range(1,21):
   m = i % 2
   if m == 0:
      even(i)
   elif m == 1:
      odd(i)
   else:
      other(i)

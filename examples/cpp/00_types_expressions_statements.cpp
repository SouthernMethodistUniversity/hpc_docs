/*
 Statements, Expressions, and Variables
 
 * Open and closed slash-star can be used to make block comments.
 * Two consecutive slashes are used to denote a single line comment.
 * `#include` is used to reference other files that contain needed functionality
 * `using` can be used to indicate a specific namespace or function to be used
 * `main` is the entry point to the program, i.e. where the program starts and
   it returns an integer. Usually the return integer can denote if the program
   ended well, e.g. 0, or not well, e.g. > 0.
 
 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

// Include statements
#include <iostream>
#include <string>

// Namespace declaration statement
using namespace std;

// Program entry-point, encapsulated by the curly brackets { and }
int main() {
    
    // Print string using `cout` which is short for `std::cout` as the `std`
    // namespace was declared. Statements end with a semicolon.
    cout << "Hello, World!" << endl;
    
    // C++ is a strongly typed language, i.e. variables have specific types
    // and these types have a specific precision. Declaring a variable denotes
    // the variable type, name, and initial value. It is recommended, but not
    // required to specify an initial value. Note that white space is not part
    // of the syntax. Below is a table of variable types with the usual the sizes
    // and value ranges noted for 64-bit Unix using the LP64 data model. Expressions
    // are used to denote the relationship between variables.
    // Type       Variable Name   Initial Value     Usual Size on
    short int                si = -1;               // 16-bits, [-2^15, 2^15-1]
    unsigned short int      usi =  1;               // 16-bits, [0, 2^16-1]
    int                       i = -10;              // 32-bits, [-2^31, 2^31-1]
    unsigned int             ui =  10;              // 32-bits, [0, 2^32-1]
    long int                 li = -1234567890;      // 64-bits, [-2^63,-2^63-1]
    unsigned long int       uli =  1234567890;      // 64-bits, [0,-2^64-1]
    long long int           lli = -1234567890;      // 64-bits, [-2^63,-2^63-1]
    unsigned long long int ulli =  1234567890;      // 64-bits, [0,-2^64-1]
    bool                      b =  true;            // 1-bit, true or false, [1, 0]
    signed char              sc =  'a';             // 8-bits, [-127, 127]
    unsigned char            uc =  'b';             // 8-bits, [0, 255]
    char                      c =  'c';             // 8-bits, [-127, 127] (x86_64) or [0, 255] (ARM)
    float                     f =  3.14159;         // 32-bits, signed decimal number
    double                    d =  3.14159;         // 64-bits, signed decimal number
    long double              ld =  3.14159;         // 80-bits (x86_64) or 128-bits (ARM)
    auto                      a =  d + i;           // Automatic typing based on initialization (a is double)
    const int                ci =  42;              // Immutable variable
    string                    s =  "Hello, World!"; // Strings are collections of characters
    
    // Literals can be used to define types inline
    int                 il = i   + 2;    // 2 is signed int
    unsigned int       uil = ui  + 2u;   // 2 is unsigned int
    long int           lil = li  + 2l;   // 2 is signed long int
    unsigned long int ulil = uli + 2ul;  // 2 is unsigned long int
    float               fl = f   + 2.0f; // 2.0 is float
    double              dl = d   + 2.0;  // 2.0 is double
    long double        ldl = ld  + 2.0l; // 2.0 is long double
    
    // Return integer for `main`
    return 0;
}

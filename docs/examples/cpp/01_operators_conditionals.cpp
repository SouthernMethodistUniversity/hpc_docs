/**
 \brief Overview of C++ Operators and Conditionals
 
 
 */

// Include statement
#include <iostream>
#include <string>
#include <bitset> // bitset
#include <cmath>  // fmod, remainder

// Namespace declaration statement
using namespace std;

// Program entry-point, encapsulated by the curly brackets { and }
int main() {

    // Declare initialized integer variable
    int n = 42;
    int m = -2;
    cout << "We begin with n initialized as " << n
         << " and m initialized as " << m << "." << endl;
    
    // Arithmetic Operators

    // Postfix operators return the original value
    cout << "Post-increment: n++, " << n++ << " is printed, but n is now " << n << "." << endl;
    cout << "Post-decrement: n--, " << n-- << " is printed, but n is now " << n << "." << endl;

    // Prefix operators return the modified value
    cout << "Prefix-increment: ++n, " << ++n << " is printed and n is now " << n << "." << endl;
    cout << "Prefix-decrement: --n, " << --n << " is printed and n is now " << n << "." << endl;
    
    // Unary operators
    cout << "Unary plus, positive " << +n << " is printed." << endl;
    cout << "Unary minus, positive " << -n << " is printed." << endl;
    
    // Binary operators
    cout << n * m << endl;           // Multiplication, -84 is printed
    cout << n / m << endl;           // Division, -21 is printed
    cout << n % m << endl;           // Modulo (integer only), 0 is printed
    cout << fmod(n, m) << endl;      // Modulo (floats, truncated), 0.0 is printed
    cout << remainder(n, m) << endl; // Modulo (floats, rounded), 0.0 is printed
    cout << n + m << endl;           // Addition, 40 is printed
    cout << n - m << endl;           // Subtraction, 44 is printed
    
    // Boolean operators
    
    bool a = true;  // Has value of 1
    bool b = false; // has value of 0

    // Unary operators
    cout << !a << endl; // Not, 0 (false) is printed
    
    // Binary operators
    cout << (n >  m) << endl; // Greater than, 1 (true) is printed
    cout << (n >= m) << endl; // Greater than or equal to, 1 (true) is printed
    cout << (n <  m) << endl; // Less than, 0 (false) is printed
    cout << (n <= m) << endl; // Less than or equal to, 0 (false) is printed
    cout << (n == m) << endl; // Equal to, 0 (false) is printed
    cout << (n != m) << endl; // Not equal to, 1 (true) is printed
    cout << (a && b) << endl; // Logical AND, 0 (false) is printed
    cout << (a || b) << endl; // Logical OR, 1 (true) is printed

    // Bitwise operators
    
    bitset<3> i{"100"}; // 3-bit binary representation of 4
    bitset<3> j{"010"}; // 3-bit binary representation of 2

    cout << ~i       << endl; // One's complement (flips each bit), 011 is printed
    cout << (i &  j) << endl; // AND, 000
    cout << (i ^  j) << endl; // Exclusive OR
    cout << (i |  j) << endl; // Inclusive OR
    cout << (i << 1) << endl; // Left shift, 000 is printed
    cout << (i >> 1) << endl; // Right shift, 010 is printed

    // Assignment operators

    int x = 3;
    int y = 2;

    x   = y; cout << "Assignment, x is now "                                  << x << endl;
    x  *= y; cout << "Multiplication assignment, x = x * y, x is now "        << x << endl;
    x  /= y; cout << "Division assignment, x = x / y, x is now "              << x << endl;
    x  %= y; cout << "Modulo assignment (integer only), x = x % y, x is now " << x << endl;
    x  += y; cout << "Addition assignment, x = x + y, x is now "              << x << endl;
    x  -= y; cout << "Subtraction assignment, x = x - y, x is now "           << x << endl;
    x <<= 1; cout << "Bitwise shift left assignment, x = x << y, x in now "   << x << endl;
    x >>= 1; cout << "Bitwise shift right assignment, x = x << y, x in now "  << x << endl; 
    
    return 0;
}


/**
 Branching and Loops
 */

// Include statement
#include <iostream>
#include <string>
#include <vector>
#include <numeric>

// Namespace declaration statement
using namespace std;

// Program entry-point, encapsulated by the curly brackets { and }
int main() {
    
    // Conditional control with `if`, `else if`, and `else`
    // The first condition to be satisfied is the code that is executed
    // Braces, { & }, can be used to to encapsulate conditions that execute multiple statements
    
    unsigned short int answer = 42;
    if (answer != 42) {
        cout << answer << " is the wrong answer.\n";
    } else {
        cout << answer << " is the correct answer to life, the universe, and everything.\n";
    }

    if (answer < 42)
        cout << answer << " is the wrong answer.\n";
    else if (answer > 42)
        cout << answer << " is the wrong answer.\n";
    else
        cout << answer << " is the correct answer to life, the universe, and everything.\n";

    // Conditional expressions with the ternary operator
    // Ternary statements have the form `<condition> ? <result if true> : <result if false>

    answer != 42 ? cout << answer << "is the wrong answer.\n"
                 : cout << answer << " is the correct answer to life, the universe, and everything.\n";
   
    // Switch statements
    // Switch statements can be similar to if statements for integral conditions.
    // They also have the special property where they run one after another until they finish or a `break`.

    string falling_object = "missiles";    

    switch (2) {
        case 2: cout << "The missiles spontaneously transform at a sufficient improbability factor.\n"; falling_object = "bowl of petunias";
        case 1: cout << "Well, now one of the missiles is a " << falling_object << ".\n"; falling_object = "very surprised whale";
        case 0: cout << "The other missile is now a " << falling_object << ".\n"; break;
        default: cout << "Does this run?\n";
    }

    // While and do-while loops
    // While loops repeat a section of code until a condition is met.
    // `while` loops the condition is tested at the beginning of the loop.
    // Do-while loops the condition is tested at the end of the loop.

    int i = 0;
    while (i < 10) {
        cout << "i = " << i << endl;
        ++i;
    }

    i = 0;
    do {
        cout << "i = " << i << endl;
        ++i;
    } while (i < 10);


    // `for` loops
    // `for` loops have three components:
    //     - Initialization
    //     - A continuation condition
    //     - Step operation

    for (int i = 0; i < 10; ++i) {
        cout << "i = " << i << endl;
    }

    // Range-base loops
    // Range-based loops have two components:
    //     - Container element
    //     - Container

    vector<int> v = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    for (auto v_i : v)
        cout << "v_i = " << v_i << endl;

    // Loop control
    // `break` to stop the loops execution
    // `continue` to stop the current loop, but continue the loops

    for (int i = -10; i < 100; ++i) {
        if (i < 0)
            continue;
        else if (i < 10)
            cout << "i = " << i << endl;
        else
            break;
    }

    return 0;
}


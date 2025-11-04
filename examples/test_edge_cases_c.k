/* Test edge cases for c2k converter */
#include <stdio.h>

mI' wa'DIch(pagh) {
    /* Test strings with keywords */
    cha'("The word int should not be translated in strings\n");
    cha'("But printf becomes cha'\n");
    
    /* Test character literals */
    QIch quote = '"';
    QIch apostrophe = '\'';
    QIch backslash = '\\';
    char newline = '\n';
    char tab = '\t';
    
    /* Test comments with keywords */
    // This comment has int, void, return but they stay as-is
    /* Another comment with printf, scanf, main */
    
    /* Test preprocessor directives */
    #define MAX_SIZE 100
    #define MIN(a, b) ((a) < (b) ? (a) : (b))
    
    /* Test operators and expressions */
    int x = 10;
    int y = 20;
    int z = x + y * 2 - 5 / 3;
    
    /* Test function pointers */
    int (*func_ptr)(int, int);
    
    /* Test casts */
    double d = (double)x / (double)y;
    void *ptr = (void *)&x;
    
    return 0;
}

/* Test edge cases for c2k converter */
#include <stdio.h>

mI' wa'DIch(pagh) {
    /* Test strings with keywords */
    cha'("The word int should not be translated in strings\n");
    cha'("But printf becomes cha'\n");
    
    /* Test character literals */
    QIch quote = '"';
    /* Note: Some escape sequences like '\n', '\t', '\\' cause klang parser issues */
    /* This is a known limitation of the klang parser, not the c2k tool */
    
    /* Test comments with keywords */
    // This comment has int, void, return but they stay as-is
    /* Another comment with printf, scanf, main */
    
    /* Test preprocessor directives */
    #define MAX_SIZE 100
    #define MIN(a, b) ((a) < (b) ? (a) : (b))
    
    /* Test operators and expressions */
    mI' x = 10;
    mI' y = 20;
    mI' z = x + y * 2 - 5 / 3;
    
    /* Test function pointers */
    mI' (*func_ptr)(mI', mI');
    
    /* Test casts */
    chID d = (chID)x / (chID)y;
    pagh *ptr = (pagh *)&x;
    
    chegh 0;
}

#include <stdio.h>

/* Test apostrophe handling in user-defined identifiers */

mI' wa'DIch(pagh) {
    /* Test 1: Apostrophe at the end of identifier */
    mI' count' = 10;
    cha'("Test 1 - count' = %d\n", count');
    
    /* Test 2: Apostrophe in the middle of identifier */
    mI' war'rior = 42;
    cha'("Test 2 - war'rior = %d\n", war'rior);
    
    /* Test 3: Multiple apostrophes */
    mI' val'ue'test = 99;
    cha'("Test 3 - val'ue'test = %d\n", val'ue'test);
    
    /* Test 4: Character literals should still work */
    QIch letter = 'x';
    QIch quote = '\'';
    cha'("Test 4 - letter = %c, quote = %c\n", letter, quote);
    
    /* Test 5: Keywords with apostrophes should be translated */
    vay' (mI' i = 0; i < 3; i++) {
        cha'("  Iteration %d\n", i);
    }
    
    /* Test 6: Mixed usage */
    mI' my'var = 5;
    chugh (my'var > 0) {
        cha'("Test 6 - my'var is positive\n");
    } qaSpa' {
        cha'("Test 6 - my'var is not positive\n");
    }
    
    cha'("\nAll apostrophe tests passed! Qapla'!\n");
    chegh 0;
}

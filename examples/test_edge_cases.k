#include <stdio.h>
#include <string.h>

/* Test edge cases for the K language compiler */

mI' wa'DIch(pagh) {
    /* Test 1: Keywords in strings should not be translated */
    QIch test1[] = "This string contains mI' and chegh keywords";
    cha'("Test 1: %s\n", test1);
    
    /* Test 2: Keywords in comments should not be translated */
    // This comment has mI' and chegh
    /* Another comment with chugh and qaSpa' */
    
    /* Test 3: Partial keyword matches should not translate */
    mI' mixing = 42;  // mixing is not a keyword, only mI' is
    cha'("Test 3: mixing = %d\n", mixing);
    
    /* Test 4: Keywords with apostrophes */
    mI' value = 5;
    chugh (value > 0) {
        cha'("Test 4: Apostrophe handling works\n");
    }
    
    /* Test 5: Multiple keywords in one line */
    mI' a = 1; mI' b = 2; mI' c = 3;
    cha'("Test 5: a=%d, b=%d, c=%d\n", a, b, c);
    
    /* Test 6: Nested structures */
    chugh (1) {
        chugh (2) {
            taH (0) {
                mev;
            }
        }
    }
    cha'("Test 6: Nested structures work\n");
    
    cha'("\nAll edge case tests passed! Qapla'!\n");
    chegh 0;
}

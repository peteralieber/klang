#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <time.h>

/* Test program demonstrating Klingon stdlib function translations */

mI' wa'DIch(pagh) {
    cha'("=== K Language Standard Library Test ===\n\n");
    
    /* Test stdio.h functions */
    cha'("1. Testing stdio.h functions:\n");
    QIch buffer[100];
    cha'tlhegh(buffer, "Formatted: %d warriors\n", 42);
    cha'("   %s", buffer);
    
    /* Test string.h functions */
    cha'("\n2. Testing string.h functions:\n");
    QIch str1[50] = "Klingon";
    QIch str2[50] = " Empire";
    chel(str1, str2);  /* strcat */
    cha'("   Concatenated: %s\n", str1);
    cha'("   Length: %lu\n", nI'ghach(str1));  /* strlen */
    
    QIch str3[50];
    lagh(str3, "Qo'noS");  /* strcpy */
    cha'("   Copied: %s\n", str3);
    
    mI' cmp = pIm("warrior", "warrior");  /* strcmp */
    cha'("   Compare result: %d\n", cmp);
    
    QIch *found = tu'QIch("honor", 'n');  /* strchr */
    chugh (found) {
        cha'("   Found character at position: %ld\n", found - "honor");
    }
    
    /* Test memory functions */
    cha'("\n3. Testing memory functions:\n");
    mI' *numbers = ngaS(5 * tIq(mI'));  /* malloc */
    chugh (numbers) {
        qabHom(numbers, 0, 5 * tIq(mI'));  /* memset */
        numbers[0] = 10;
        numbers[1] = 20;
        cha'("   Allocated array: [%d, %d]\n", numbers[0], numbers[1]);
        
        mI' *more_numbers = ngaSchu'(3, tIq(mI'));  /* calloc */
        chugh (more_numbers) {
            laghHom(more_numbers, numbers, 2 * tIq(mI'));  /* memcpy */
            cha'("   Copied array: [%d, %d, %d]\n", 
                more_numbers[0], more_numbers[1], more_numbers[2]);
            chImmoH(more_numbers);  /* free */
        }
        chImmoH(numbers);  /* free */
    }
    
    /* Test stdlib.h conversion functions */
    cha'("\n4. Testing conversion functions:\n");
    QIch num_str[] = "1701";
    mI' converted = toDmI'(num_str);  /* atoi */
    cha'("   String to int: '%s' -> %d\n", num_str, converted);
    
    QIch float_str[] = "3.14";
    bu' float_val = toDbu'(float_str);  /* atof */
    cha'("   String to float: '%s' -> %.2f\n", float_str, float_val);
    
    /* Test random number generation */
    cha'("\n5. Testing random functions:\n");
    qawmoH(poH(NULL));  /* srand(time(NULL)) */
    cha'("   Random numbers: ");
    vay' (mI' i = 0; i < 5; i++) {
        cha'("%d ", nap() % 100);  /* rand */
    }
    cha'("\n");
    
    /* Test math.h functions */
    cha'("\n6. Testing math.h functions:\n");
    chID x = 16.0;
    cha'("   sqrt(%.0f) = %.2f\n", x, boqHa'mI'(x));  /* sqrt */
    
    chID base = 2.0, exponent = 3.0;
    cha'("   pow(%.0f, %.0f) = %.0f\n", base, exponent, HoS(base, exponent));  /* pow */
    
    chID neg = -42.5;
    cha'("   fabs(%.1f) = %.1f\n", neg, jombu'(neg));  /* fabs */
    
    chID val = 3.7;
    cha'("   floor(%.1f) = %.0f\n", val, bID(val));  /* floor */
    cha'("   ceil(%.1f) = %.0f\n", val, joq(val));  /* ceil */
    
    /* Test ctype.h functions */
    cha'("\n7. Testing ctype.h functions:\n");
    QIch test_char = 'A';
    cha'("   Character '%c':\n", test_char);
    cha'("     isalpha: %d\n", qaQIchQach(test_char));  /* isalpha */
    cha'("     isupper: %d\n", qaQIchtIn(test_char));  /* isupper */
    cha'("     tolower: %c\n", QIchmach(test_char));  /* tolower */
    
    QIch digit = '5';
    cha'("   Character '%c':\n", digit);
    cha'("     isdigit: %d\n", qaQIchmI'(digit));  /* isdigit */
    
    cha'("\n=== Qapla'! All tests completed successfully! ===\n");
    
    chegh 0;
}

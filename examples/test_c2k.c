/* Test file for c2k converter - demonstrates various C features */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Test struct definition */
struct warrior {
    char *name;
    int strength;
    int honor;
};

/* Function with multiple parameters */
int calculate_power(int strength, int honor) {
    return strength * 2 + honor;
}

/* Function using various control structures */
void test_controls(int n) {
    /* Test if-else */
    if (n > 10) {
        printf("Large number\n");
    } else if (n > 5) {
        printf("Medium number\n");
    } else {
        printf("Small number\n");
    }
    
    /* Test while loop */
    int i = 0;
    while (i < n) {
        printf("%d ", i);
        i++;
    }
    printf("\n");
    
    /* Test for loop */
    for (int j = 0; j < n; j++) {
        if (j == 3) continue;
        if (j == 7) break;
        printf("%d ", j);
    }
    printf("\n");
    
    /* Test switch statement */
    switch (n) {
        case 0:
            printf("Zero\n");
            break;
        case 1:
            printf("One\n");
            break;
        default:
            printf("Other\n");
            break;
    }
}

/* Test with string operations */
void test_strings(void) {
    char buffer[100];
    const char *greeting = "Qapla'!";
    
    strcpy(buffer, greeting);
    printf("Length: %zu\n", strlen(buffer));
    
    if (strcmp(buffer, greeting) == 0) {
        printf("Strings match\n");
    }
}

/* Test with pointers and arrays */
int sum_array(int *arr, int size) {
    int total = 0;
    for (int i = 0; i < size; i++) {
        total += arr[i];
    }
    return total;
}

/* Test with typedef */
typedef struct warrior Warrior;
typedef unsigned int uint;

/* Main function */
int main(void) {
    printf("Testing C-to-K converter\n");
    
    /* Test struct */
    struct warrior worf;
    worf.name = "Worf";
    worf.strength = 95;
    worf.honor = 100;
    
    printf("Warrior: %s\n", worf.name);
    printf("Power: %d\n", calculate_power(worf.strength, worf.honor));
    
    /* Test control structures */
    test_controls(5);
    
    /* Test strings */
    test_strings();
    
    /* Test arrays */
    int numbers[] = {1, 2, 3, 4, 5};
    printf("Sum: %d\n", sum_array(numbers, 5));
    
    /* Test malloc/free */
    int *dynamic = (int *)malloc(10 * sizeof(int));
    if (dynamic != NULL) {
        dynamic[0] = 42;
        printf("Dynamic: %d\n", dynamic[0]);
        free(dynamic);
    }
    
    return 0;
}

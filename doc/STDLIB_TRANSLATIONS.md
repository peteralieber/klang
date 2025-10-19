# Klingon Standard Library Translations Summary

This document provides a comprehensive list of all C standard library functions that have been translated to Klingon in the K language.

## Summary Statistics

- **Total stdlib functions**: 60+
- **Categories covered**: 5 (stdio, string, stdlib, math, ctype, time)
- **Previously translated**: 8 functions
- **Newly added**: 60+ functions

## Complete Function List by Category

### stdio.h - Input/Output Functions (13 functions)
1. `printf` → `cha'` (show)
2. `scanf` → `Qoy'` (hear/listen)
3. `fprintf` → `cha'De'` (show to file)
4. `sprintf` → `cha'tlhegh` (show string)
5. `fopen` → `poSmoH` (open file)
6. `fclose` → `SoQmoH` (close file)
7. `fread` → `laD` (read)
8. `fwrite` → `ghItlhmoH` (write)
9. `fgets` → `Suq` (acquire/get)
10. `fputs` → `pol` (put)
11. `getchar` → `SuqQIch` (get character)
12. `putchar` → `polQIch` (put character)
13. `puts` → `ngh` (output/emit)

### string.h - String Manipulation Functions (14 functions)
1. `strlen` → `nI'ghach` (length)
2. `strcpy` → `lagh` (copy)
3. `strcmp` → `pIm` (compare)
4. `strcat` → `chel` (add/concatenate)
5. `strncpy` → `laghboq` (copy limited)
6. `strncmp` → `pImboq` (compare limited)
7. `strchr` → `tu'QIch` (find character)
8. `strrchr` → `tu'Qav` (find last)
9. `strstr` → `tu'tlhegh` (find string)
10. `strtok` → `SIH` (separate/tokenize)
11. `memcpy` → `laghHom` (copy memory)
12. `memmove` → `choHHom` (move memory)
13. `memset` → `qabHom` (set memory)
14. `memcmp` → `pImHom` (compare memory)

### stdlib.h - General Utility Functions (13 functions)
1. `malloc` → `ngaS` (allocate)
2. `free` → `chImmoH` (free/release)
3. `calloc` → `ngaSchu'` (allocate clear)
4. `realloc` → `ngaSchIm` (reallocate)
5. `exit` → `mej` (leave/exit)
6. `abort` → `mevmoH` (abort/stop)
7. `atoi` → `toDmI'` (parse number)
8. `atof` → `toDbu'` (parse float)
9. `atol` → `toDtIq` (parse long)
10. `rand` → `nap` (random)
11. `srand` → `qawmoH` (seed)
12. `qsort` → `wegh` (sort)
13. `bsearch` → `nejchu'` (binary search)

### math.h - Mathematical Functions (11 functions)
1. `sqrt` → `boqHa'mI'` (square root)
2. `pow` → `HoS` (power)
3. `abs` → `jompatlh` (absolute value)
4. `fabs` → `jombu'` (floating absolute)
5. `sin` → `maghwI'` (sine)
6. `cos` → `maghwI'cha'` (cosine)
7. `tan` → `maghwI'wej` (tangent)
8. `exp` → `jen` (exponential)
9. `log` → `naH` (logarithm)
10. `floor` → `bID` (floor)
11. `ceil` → `joq` (ceiling)

### ctype.h - Character Handling Functions (8 functions)
1. `isalpha` → `qaQIchQach` (is letter)
2. `isdigit` → `qaQIchmI'` (is digit)
3. `isalnum` → `qaQIchboq` (is alphanumeric)
4. `isspace` → `qaQIchpegh` (is space)
5. `isupper` → `qaQIchtIn` (is uppercase)
6. `islower` → `qaQIchmach` (is lowercase)
7. `toupper` → `QIchtIn` (to uppercase)
8. `tolower` → `QIchmach` (to lowercase)

### time.h - Time Functions (4 functions)
1. `time` → `poH` (time)
2. `clock` → `poHmI'` (clock/time measure)
3. `difftime` → `poHpIm` (time difference)
4. `strftime` → `poHcha'` (time format)

## Translation Philosophy

The Klingon translations follow these principles:

1. **Semantic Meaning**: Each translation attempts to capture the semantic meaning of the C function
2. **Klingon Root Words**: Uses authentic Klingon words and grammatical structures where possible
3. **Consistency**: Related functions use related Klingon roots (e.g., all "find" functions use `tu'`)
4. **Apostrophe Handling**: Klingon apostrophes in function names are preserved in K source but converted appropriately in C output

## Examples

### File I/O Example
```k
FILE *file = poSmoH("data.txt", "r");  /* fopen */
chugh (file) {
    QIch buffer[256];
    taH (Suq(buffer, tIq(buffer), file) != NULL) {  /* while fgets */
        cha'("%s", buffer);  /* printf */
    }
    SoQmoH(file);  /* fclose */
}
```

### String Operations Example
```k
QIch str1[50] = "Klingon";
QIch str2[50] = " Warrior";
chel(str1, str2);  /* strcat */
cha'("Length: %lu\n", nI'ghach(str1));  /* printf, strlen */
```

### Math Operations Example
```k
chID result = boqHa'mI'(16.0);  /* sqrt */
result = HoS(2.0, 3.0);  /* pow */
result = jombu'(-42.5);  /* fabs */
```

## Testing

Two comprehensive test programs are included:

1. **stdlib_test.k** - Demonstrates most of the 60+ stdlib functions
2. **file_io.k** - Focuses on file I/O operations

Run them with:
```bash
./klang examples/stdlib_test.k -o examples/stdlib_test.c
gcc examples/stdlib_test.c -o examples/stdlib_test -lm
./examples/stdlib_test
```

## Qapla'! (Success!)

May your code be victorious and your programs run without errors!

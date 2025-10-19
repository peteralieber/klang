# K Language Examples

This directory contains example programs written in the K programming language.

## Examples

### hello.k
A simple "Hello World" program demonstrating basic program structure.

```bash
../klang hello.k -o hello.c
gcc hello.c -o hello
./hello
```

### fib.k
Fibonacci sequence calculator demonstrating:
- Functions
- Recursion
- For loops
- Function parameters and return values

```bash
../klang fib.k -o fib.c
gcc fib.c -o fib
./fib
```

### loops.k
Loop and conditional demonstration showing:
- While loops (`taH`)
- If/else statements (`chugh`/`qaSpa'`)
- Variable declarations and assignments

```bash
../klang loops.k -o loops.c
gcc loops.c -o loops
./loops
```

### warrior.k
Comprehensive example demonstrating:
- Struct definitions (`qach`)
- Pointers
- For loops
- If/else chains
- Function definitions
- String operations

```bash
../klang warrior.k -o warrior.c
gcc warrior.c -o warrior
./warrior
```

### warrior.k
Comprehensive example demonstrating:
- Struct definitions (`qach`)
- Pointers
- For loops
- If/else chains
- Function definitions
- String operations

```bash
../klang warrior.k -o warrior.c
gcc warrior.c -o warrior
../warrior
```

### stdlib_test.k
**NEW** Comprehensive test demonstrating 60+ standard library function translations:
- stdio.h functions: `printf`, `sprintf`, `fgets`, etc.
- string.h functions: `strlen`, `strcpy`, `strcmp`, `strcat`, `strchr`, `memcpy`, `memset`, etc.
- stdlib.h functions: `malloc`, `free`, `calloc`, `atoi`, `rand`, etc.
- math.h functions: `sqrt`, `pow`, `fabs`, `floor`, `ceil`, etc.
- ctype.h functions: `isalpha`, `isdigit`, `toupper`, `tolower`, etc.

```bash
../klang stdlib_test.k -o stdlib_test.c
gcc stdlib_test.c -o stdlib_test -lm
../stdlib_test
```

### file_io.k
**NEW** File I/O demonstration showing:
- Opening and closing files (`poSmoH`/`SoQmoH`)
- Reading and writing text files (`Suq`/`pol`/`cha'De'`)
- Binary file operations (`laD`/`ghItlhmoH`)
- File handle management

```bash
../klang file_io.k -o file_io.c
gcc file_io.c -o file_io
../file_io
```

### test_apostrophes.k
Demonstrates apostrophe handling in user-defined identifiers:
- Apostrophes at the end of identifiers
- Apostrophes in the middle of identifiers
- Multiple apostrophes in one identifier
- Character literals with apostrophes
- Keywords with apostrophes

```bash
../klang test_apostrophes.k -o test_apostrophes.c
gcc test_apostrophes.c -o test_apostrophes
./test_apostrophes
```

### test_edge_cases.k
Comprehensive edge case testing including:
- Keywords in strings and comments
- Partial keyword matches
- Nested structures
- Multiple keywords per line

```bash
../klang test_edge_cases.k -o test_edge_cases.c
gcc test_edge_cases.c -o test_edge_cases
./test_edge_cases
```

## Running All Examples

From the main directory, run:
```bash
make test
```

## Notes

All K programs are semantically identical to C programs - they use Klingon keywords but have the same behavior as their C equivalents.

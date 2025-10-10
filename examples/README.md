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

## Running All Examples

From the main directory, run:
```bash
make test
```

## Notes

All K programs are semantically identical to C programs - they use Klingon keywords but have the same behavior as their C equivalents.

# C-to-K Converter Design

## Overview

The C-to-K converter (`c2k`) is a tool that translates standard C source code into K language source code. It performs the reverse operation of the klang compiler, enabling developers to convert existing C codebases to K language.

## Design Goals

1. **Written in K Language**: Demonstrate K's capability to handle complex text processing tasks
2. **Accurate Translation**: Preserve semantic meaning while converting syntax
3. **Idiomatic K Output**: Generate K code that follows Klingon naming conventions
4. **Robust Parsing**: Handle strings, comments, and character literals correctly
5. **Configurable**: Allow options for identifier conversion styles

## Architecture

### Core Components

1. **Keyword Mapper**: Reverse mapping from C keywords to K keywords
2. **Function Mapper**: Reverse mapping from C stdlib functions to K equivalents
3. **Parser**: Context-aware parser that:
   - Tracks whether we're inside strings, character literals, or comments
   - Identifies word boundaries to avoid partial replacements
   - Handles escape sequences properly

4. **Identifier Converter** (optional): Converts C-style identifiers with underscores to K-style with apostrophes
   - `my_variable` → `my'variable`
   - `count_total` → `count'total`

### Algorithm Flow

```
1. Read C source file
2. Initialize parsing state (tracking strings, chars, comments)
3. For each character position:
   a. Update state based on delimiters (quotes, comment markers)
   b. If inside string/char/comment: copy as-is
   c. Otherwise: attempt keyword/function matching
   d. If match found at word boundary: replace with K equivalent
   e. If no match: handle identifier apostrophe conversion if enabled
   f. Write to output buffer
4. Write K source file
```

### Keyword Mapping Table

The tool uses the inverse of klang's keyword mapping:

| C Keyword | K Keyword |
|-----------|-----------|
| `int` | `mI'` |
| `char` | `QIch` |
| `void` | `pagh` |
| `if` | `chugh` |
| `else` | `qaSpa'` |
| `while` | `taH` |
| `for` | `vay'` |
| `return` | `chegh` |
| `printf` | `cha'` |
| `main` | `wa'DIch` |
| ... | ... |

See SPEC.md for the complete mapping.

### Special Considerations

1. **Apostrophes in Output**: K keywords naturally contain apostrophes (e.g., `mI'`, `cha'`), which are valid in K source code
2. **String Preservation**: String contents remain unchanged (e.g., "Hello" stays "Hello")
3. **Comment Preservation**: Comments are copied verbatim
4. **Preprocessor Directives**: `#include`, `#define`, etc. are preserved as-is
5. **Word Boundaries**: Ensure `print` in `fprintf` doesn't match `printf` → `cha'`

### Edge Cases

1. **Nested strings/comments**: Handle escaped quotes properly
2. **Keyword substrings**: Only match at word boundaries
3. **Character literals with apostrophes**: `'\''` should not be treated as identifier apostrophe
4. **Multi-character keywords**: Match longest keywords first (e.g., `unsigned` before `int`)

## Usage

```bash
./klang c2k.k -o c2k.c
gcc c2k.c -o c2k
./c2k input.c -o output.k
```

Options:
- `-o <file>`: Specify output file (default: output.k)
- `--preserve-underscores`: Don't convert underscores to apostrophes in identifiers

## Example Conversions

### Input (C):
```c
#include <stdio.h>

int main(void) {
    printf("Hello, World!\n");
    return 0;
}
```

### Output (K):
```k
#include <stdio.h>

mI' wa'DIch(pagh) {
    cha'("Hello, World!\n");
    chegh 0;
}
```

### Input (C with user identifiers):
```c
int my_count = 0;
int warrior_strength = 100;
```

### Output (K with apostrophe conversion):
```k
mI' my'count = 0;
mI' warrior'strength = 100;
```

## Testing Strategy

1. **Basic keyword conversion**: Simple programs with common keywords
2. **Standard library functions**: Programs using stdio, stdlib, string.h
3. **Edge cases**: Strings with keywords, comments, character literals
4. **Roundtrip testing**: C → K → C should produce semantically equivalent code
5. **Complex programs**: Convert actual C programs from examples/

## Limitations

1. **Macro expansion**: Macros are preserved as-is, not expanded
2. **Comments in Klingon**: Comments remain in their original language
3. **Semantic equivalence only**: The output is a direct lexical translation
4. **No type checking**: The tool doesn't validate C code correctness
5. **Escape sequence handling**: The c2k tool (when compiled with klang) inherits klang's known limitation with complex escape sequences. Character literals with escape sequences like `'\n'`, `'\t'`, or `'\\'` may cause the parser to incorrectly track string/character literal state, leading to some keywords not being translated. This is a klang parser bug that affects both klang and c2k. Simple escape sequences like `\"` in strings work correctly.

## Future Enhancements

1. Add option to translate comments to Klingon
2. Support for custom keyword mappings
3. Batch conversion mode for multiple files
4. Integration with klang as a subcommand (klang --reverse)
5. Pretty-printing and formatting options
6. Improved escape sequence handling (requires fixing the underlying klang parser)

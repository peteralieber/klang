# Keyword Dictionary System

This directory contains the shared keyword mapping dictionary system for the K language.

## Overview

The K language uses a **single master dictionary** (`keywords.dict`) to maintain keyword mappings between C and K (Klingon). This ensures consistency across both the K-to-C compiler (`klang`) and the C-to-K converter (`c2k`).

## Files

- **`keywords.dict`** - Master dictionary containing all C ↔ K mappings (human-editable)
- **`generate_keywords.py`** - Python script that generates headers from the dictionary
- **`keywords.h`** - Auto-generated C header for `klang.c` (K → C mappings)
- **`keywords.nac`** - Auto-generated header for `c2k.k` and `c2k.c` (C → K mappings)

## The .nac Extension

The `.nac` extension comes from **"nach"** - the Klingon word for "header" or "head". This Klingon-themed extension fits the project's naming convention.

## How It Works

1. **Single Source of Truth**: All keyword mappings are defined once in `keywords.dict`
2. **Automatic Generation**: The build system runs `generate_keywords.py` to create headers
3. **Inclusion**: Both `klang.c` and `c2k.k` include their respective generated headers
4. **Consistency**: Any change to `keywords.dict` automatically propagates to both tools

## Adding or Modifying Keywords

To add or modify a keyword mapping:

1. Edit `keywords.dict`:
   ```
   # Format: K_KEYWORD C_KEYWORD [OPTIONAL_COMMENT]
   newK'word newcword
   ```

2. Run the generator:
   ```bash
   python3 generate_keywords.py
   ```
   Or simply rebuild:
   ```bash
   make clean
   make
   ```

3. Both `klang` and `c2k` will now use the updated mappings

## Build Integration

The Makefile automatically:
1. Detects changes to `keywords.dict` or `generate_keywords.py`
2. Regenerates `keywords.h` and `keywords.nac` before compilation
3. Compiles both tools with the fresh headers

## Technical Details

### keywords.h (for klang.c)
- Contains K → C mappings
- Uses C `typedef struct` syntax
- Maps from Klingon keywords to C keywords
- Example: `{"mI'", "int"}`

### keywords.nac (for c2k.k and c2k.c)
- Contains C → K mappings  
- Uses C `typedef struct` syntax (not K syntax)
- Sorted by C keyword length (longest first) for proper matching
- Example: `{"int", "mI'"}`
- Works in both c2k.k (before translation) and c2k.c (after translation)

The `.nac` file uses C syntax intentionally so that:
1. When included in `c2k.k`, klang can translate it during compilation
2. When included in `c2k.c`, gcc can compile it directly

## Benefits

✅ **Single source of truth** - One dictionary, no duplication  
✅ **Easy maintenance** - Add/change mappings in one place  
✅ **Consistency** - Both tools always stay in sync  
✅ **Automatic** - Build system handles generation  
✅ **Documented** - Dictionary file is human-readable

## Example

Adding a new keyword mapping:

```bash
# 1. Edit keywords.dict
echo "Qapla' success  # Victory!" >> keywords.dict

# 2. Rebuild
make clean && make

# 3. Both tools now recognize the new mapping
```

The build output will show:
```
Generating keyword headers from master dictionary...
Found 96 keyword mappings
```

---

*Qapla'!* (Success in Klingon!)

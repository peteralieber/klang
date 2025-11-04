#!/usr/bin/env python3
"""
Generate keyword mapping headers from the master dictionary.
This script reads keywords.dict and generates:
  - keywords.h (C header for klang.c)
  - keywords.nac (K header for c2k.k)
  
'nac' comes from "nach" - Klingon for "header" or "head"
"""

import sys
from pathlib import Path

def parse_dictionary(dict_file):
    """Parse the keyword dictionary file."""
    keywords = []
    with open(dict_file, 'r') as f:
        for line in f:
            line = line.strip()
            # Skip comments and empty lines
            if not line or line.startswith('#'):
                continue
            parts = line.split(None, 2)  # Split on whitespace, max 3 parts
            if len(parts) >= 2:
                k_keyword, c_keyword = parts[0], parts[1]
                keywords.append((k_keyword, c_keyword))
    return keywords

def generate_c_header(keywords, output_file):
    """Generate C header file with K->C mappings."""
    with open(output_file, 'w') as f:
        f.write("/* Auto-generated from keywords.dict - DO NOT EDIT MANUALLY */\n")
        f.write("/* K to C keyword mappings for klang */\n\n")
        f.write("#ifndef KEYWORDS_H\n")
        f.write("#define KEYWORDS_H\n\n")
        f.write("/* Keyword mapping structure */\n")
        f.write("typedef struct {\n")
        f.write("    const char *k_keyword;\n")
        f.write("    const char *c_keyword;\n")
        f.write("} KeywordMap;\n\n")
        f.write("/* Keyword mappings from K to C */\n")
        f.write("static const KeywordMap keywords[] = {\n")
        
        for k_kw, c_kw in keywords:
            f.write(f'    {{"{k_kw}", "{c_kw}"}},\n')
        
        f.write("    {NULL, NULL}\n")
        f.write("};\n\n")
        f.write("#endif /* KEYWORDS_H */\n")

def generate_k_header(keywords, output_file):
    """Generate K-compatible header file with C->K mappings.
    
    This header uses C syntax so it can be included in both c2k.k and c2k.c.
    When included in c2k.k, klang will translate the C keywords to K during compilation.
    """
    # Sort by C keyword length (longest first) for proper matching
    sorted_keywords = sorted(keywords, key=lambda x: len(x[1]), reverse=True)
    
    with open(output_file, 'w') as f:
        f.write("/* Auto-generated from keywords.dict - DO NOT EDIT MANUALLY */\n")
        f.write("/* C to K keyword mappings for c2k */\n")
        f.write("/* nac = nach (Klingon for \"header\") */\n")
        f.write("/* This file uses C syntax so it works in both c2k.k and c2k.c */\n\n")
        f.write("/* Keyword mapping structure */\n")
        f.write("typedef struct {\n")
        f.write("    const char *c_keyword;\n")
        f.write("    const char *k_keyword;\n")
        f.write("} KeywordMap;\n\n")
        f.write("/* Keyword mappings from C to K (reverse of klang) */\n")
        f.write("/* Ordered by length (longest first) for proper matching */\n")
        f.write("static const KeywordMap keywords[] = {\n")
        
        for k_kw, c_kw in sorted_keywords:
            f.write(f'    {{"{c_kw}", "{k_kw}"}},\n')
        
        f.write("    {NULL, NULL}\n")
        f.write("};\n")

def main():
    script_dir = Path(__file__).parent
    dict_file = script_dir / 'keywords.dict'
    c_header = script_dir / 'keywords.h'
    k_header = script_dir / 'keywords.nac'
    
    print(f"Reading dictionary from: {dict_file}")
    keywords = parse_dictionary(dict_file)
    print(f"Found {len(keywords)} keyword mappings")
    
    print(f"Generating C header for klang: {c_header}")
    generate_c_header(keywords, c_header)
    
    print(f"Generating K-compatible header (nac) for c2k: {k_header}")
    generate_k_header(keywords, k_header)
    
    print("Done!")

if __name__ == '__main__':
    main()

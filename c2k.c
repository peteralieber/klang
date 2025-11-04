#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define C2K_VERSION "0.0.1"

/* Character constants to work around klang parser limitations with char literals */
#define DQUOTE 34    /* " */
#define SQUOTE 39    /* ' */
#define BACKSLASH 92 /* \ */

/* Keyword mapping structure */
typedef struct {
    const char *c_keyword;
    const char *k_keyword;
} KeywordMap;

/* Keyword mappings from C to K (reverse of klang) */
static const KeywordMap keywords[] = {
    /* Keywords - ordered by length (longest first) for proper matching */
    {"unsigned", "HoSghaj"},
    {"continue", "jaH"},
    {"register", "ghItlh"},
    {"volatile", "choq"},
    {"default", "motlh"},
    {"typedef", "pong"},
    {"sizeof", "tIq"},
    {"switch", "choH"},
    {"struct", "qach"},
    {"static", "tlhegh"},
    {"signed", "mI'ghach"},
    {"return", "chegh"},
    {"extern", "latlh"},
    {"double", "chID"},
    {"break", "mev"},
    {"while", "taH"},
    {"short", "puS"},
    {"float", "bu'"},
    {"else", "qaSpa'"},
    {"char", "QIch"},
    {"case", "wanI'"},
    {"auto", "mong"},
    {"void", "pagh"},
    {"long", "tIq"},
    {"goto", "ghoS"},
    {"enum", "patlh"},
    {"int", "mI'"},
    {"for", "vay'"},
    {"if", "chugh"},
    {"do", "ta'"},
    {"union", "boq"},
    {"const", "HochHom"},
    
    /* Standard library function mappings */
    /* stdio.h functions */
    {"sprintf", "cha'tlhegh"},
    {"fprintf", "cha'De'"},
    {"getchar", "SuqQIch"},
    {"putchar", "polQIch"},
    {"printf", "cha'"},
    {"scanf", "Qoy'"},
    {"fopen", "poSmoH"},
    {"fclose", "SoQmoH"},
    {"fread", "laD"},
    {"fwrite", "ghItlhmoH"},
    {"fgets", "Suq"},
    {"fputs", "pol"},
    {"puts", "ngh"},
    
    /* string.h functions */
    {"strncpy", "laghboq"},
    {"strncmp", "pImboq"},
    {"strrchr", "tu'Qav"},
    {"strchr", "tu'QIch"},
    {"strstr", "tu'tlhegh"},
    {"strtok", "SIH"},
    {"strlen", "nI'ghach"},
    {"strcpy", "lagh"},
    {"strcmp", "pIm"},
    {"strcat", "chel"},
    {"memcpy", "laghHom"},
    {"memmove", "choHHom"},
    {"memset", "qabHom"},
    {"memcmp", "pImHom"},
    
    /* stdlib.h functions */
    {"calloc", "ngaSchu'"},
    {"realloc", "ngaSchIm"},
    {"malloc", "ngaS"},
    {"free", "chImmoH"},
    {"exit", "mej"},
    {"abort", "mevmoH"},
    {"atoi", "toDmI'"},
    {"atof", "toDbu'"},
    {"atol", "toDtIq"},
    {"rand", "nap"},
    {"srand", "qawmoH"},
    {"qsort", "wegh"},
    {"bsearch", "nejchu'"},
    
    /* math.h functions */
    {"sqrt", "boqHa'mI'"},
    {"pow", "HoS"},
    {"abs", "jompatlh"},
    {"fabs", "jombu'"},
    {"sin", "maghwI'"},
    {"cos", "maghwI'cha'"},
    {"tan", "maghwI'wej"},
    {"exp", "jen"},
    {"log", "naH"},
    {"floor", "bID"},
    {"ceil", "joq"},
    
    /* ctype.h functions */
    {"isalpha", "qaQIchQach"},
    {"isdigit", "qaQIchmI'"},
    {"isalnum", "qaQIchboq"},
    {"isspace", "qaQIchpegh"},
    {"isupper", "qaQIchtIn"},
    {"islower", "qaQIchmach"},
    {"toupper", "QIchtIn"},
    {"tolower", "QIchmach"},
    
    /* time.h functions */
    {"strftime", "poHcha'"},
    {"difftime", "poHpIm"},
    {"clock", "poHmI'"},
    {"time", "poH"},
    
    /* main function */
    {"main", "wa'DIch"},
    {NULL, NULL}
};

/* Check if a character can be part of an identifier */
int is_identifier_char(char c) {
    return isalnum(c) || c == '_' || c == '\'';
}

/* Check if we're at a word boundary */
int at_word_boundary(const char *text, size_t pos, size_t len) {
    size_t text_len = strlen(text);
    if (pos > 0 && is_identifier_char(text[pos - 1])) {
        return 0;
    }
    if (pos + len < text_len && is_identifier_char(text[pos + len])) {
        return 0;
    }
    return 1;
}

/* Translate C source code to K source code */
char *translate_c_to_k(const char *c_source) {
    size_t source_len = strlen(c_source);
    /* Allocate buffer (worst case: 2x size for longer K keywords) */
    size_t buffer_size = source_len * 3;
    char *k_source = malloc(buffer_size);
    if (!k_source) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    
    size_t out_pos = 0;
    size_t in_pos = 0;
    int in_string = 0;
    int in_char = 0;
    int in_comment = 0;
    int in_line_comment = 0;
    
    while (in_pos < source_len) {
        /* Handle string literals */
        if (c_source[in_pos] == DQUOTE && !in_char && !in_comment && !in_line_comment) {
            if (in_pos == 0 || c_source[in_pos - 1] != BACKSLASH) {
                in_string = !in_string;
            }
            k_source[out_pos++] = c_source[in_pos++];
            continue;
        }
        
        /* Handle character literals */
        if (c_source[in_pos] == SQUOTE && !in_string && !in_comment && !in_line_comment) {
            if (in_pos == 0 || c_source[in_pos - 1] != BACKSLASH) {
                in_char = !in_char;
            }
            k_source[out_pos++] = c_source[in_pos++];
            continue;
        }
        
        /* Handle comments */
        if (!in_string && !in_char) {
            if (in_pos + 1 < source_len && c_source[in_pos] == '/' && c_source[in_pos + 1] == '*') {
                in_comment = 1;
                k_source[out_pos++] = c_source[in_pos++];
                k_source[out_pos++] = c_source[in_pos++];
                continue;
            }
            if (in_comment && in_pos + 1 < source_len && c_source[in_pos] == '*' && c_source[in_pos + 1] == '/') {
                in_comment = 0;
                k_source[out_pos++] = c_source[in_pos++];
                k_source[out_pos++] = c_source[in_pos++];
                continue;
            }
            if (in_pos + 1 < source_len && c_source[in_pos] == '/' && c_source[in_pos + 1] == '/') {
                in_line_comment = 1;
                k_source[out_pos++] = c_source[in_pos++];
                k_source[out_pos++] = c_source[in_pos++];
                continue;
            }
            if (in_line_comment && c_source[in_pos] == '\n') {
                in_line_comment = 0;
                k_source[out_pos++] = c_source[in_pos++];
                continue;
            }
        }
        
        /* Skip translation inside strings, chars, and comments */
        if (in_string || in_char || in_comment || in_line_comment) {
            k_source[out_pos++] = c_source[in_pos++];
            continue;
        }
        
        /* Try to match keywords */
        int matched = 0;
        for (int i = 0; keywords[i].c_keyword != NULL; i++) {
            size_t kw_len = strlen(keywords[i].c_keyword);
            if (in_pos + kw_len <= source_len &&
                strncmp(&c_source[in_pos], keywords[i].c_keyword, kw_len) == 0 &&
                at_word_boundary(c_source, in_pos, kw_len)) {
                
                /* Found a match, replace with K keyword */
                const char *k_kw = keywords[i].k_keyword;
                size_t k_kw_len = strlen(k_kw);
                
                /* Ensure buffer has enough space */
                while (out_pos + k_kw_len >= buffer_size) {
                    buffer_size *= 2;
                    k_source = realloc(k_source, buffer_size);
                    if (!k_source) {
                        fprintf(stderr, "Memory reallocation failed\n");
                        exit(1);
                    }
                }
                
                memcpy(&k_source[out_pos], k_kw, k_kw_len);
                out_pos += k_kw_len;
                in_pos += kw_len;
                matched = 1;
                break;
            }
        }
        
        if (!matched) {
            /* No keyword match - copy character as-is */
            k_source[out_pos++] = c_source[in_pos++];
        }
    }
    
    k_source[out_pos] = '\0';
    return k_source;
}

/* Read entire file into a string */
char *read_file(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Error: Could not open file '%s'\n", filename);
        return NULL;
    }
    
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fseek(file, 0, SEEK_SET);
    
    char *content = malloc(size + 1);
    if (!content) {
        fprintf(stderr, "Memory allocation failed\n");
        fclose(file);
        return NULL;
    }
    
    size_t bytes_read = fread(content, 1, size, file);
    content[bytes_read] = '\0';
    fclose(file);
    
    return content;
}

/* Write string to file */
int write_file(const char *filename, const char *content) {
    FILE *file = fopen(filename, "w");
    if (!file) {
        fprintf(stderr, "Error: Could not write to file '%s'\n", filename);
        return 0;
    }
    
    fprintf(file, "%s", content);
    fclose(file);
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input.c> [-o output.k]\n", argv[0]);
        fprintf(stderr, "  Translates C source code to K language source code\n");
        fprintf(stderr, "  -v, --version    Display version information\n");
        return 1;
    }
    
    /* Check for version flag */
    if (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--version") == 0) {
        printf("c2k version %s\n", C2K_VERSION);
        return 0;
    }
    
    const char *input_file = argv[1];
    const char *output_file = "output.k";
    
    /* Parse command line arguments */
    for (int i = 2; i < argc; i++) {
        if (strcmp(argv[i], "-o") == 0 && i + 1 < argc) {
            output_file = argv[i + 1];
            i++;
        }
    }
    
    /* Read input file */
    char *c_source = read_file(input_file);
    if (!c_source) {
        return 1;
    }
    
    /* Translate C to K */
    char *k_source = translate_c_to_k(c_source);
    
    /* Write output file */
    if (!write_file(output_file, k_source)) {
        free(c_source);
        free(k_source);
        return 1;
    }
    
    printf("Successfully translated '%s' to '%s'\n", input_file, output_file);
    
    free(c_source);
    free(k_source);
    
    return 0;
}

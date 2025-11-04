CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -O2
TARGET = klang
C2K_TARGET = c2k
KEYWORD_GEN = python3 generate_keywords.py

.PHONY: all clean test test-c2k keywords

all: $(TARGET) $(C2K_TARGET)

# Generate keyword headers from master dictionary
keywords: keywords.h keywords.nac

keywords.h keywords.nac: keywords.dict generate_keywords.py
	@echo "Generating keyword headers from master dictionary..."
	@$(KEYWORD_GEN)

$(TARGET): klang.c keywords.h
	$(CC) $(CFLAGS) -o $(TARGET) klang.c

$(C2K_TARGET): c2k.k keywords.nac $(TARGET)
	./$(TARGET) c2k.k -o c2k.c
	$(CC) $(CFLAGS) -o $(C2K_TARGET) c2k.c

clean:
	rm -f $(TARGET) $(C2K_TARGET) c2k.c output.c output.k examples/*.c examples/hello examples/fib
	rm -f keywords.h keywords.nac

test: $(TARGET)
	@echo "Testing K language compiler..."
	@./$(TARGET) examples/hello.k -o examples/hello.c
	@$(CC) examples/hello.c -o examples/hello
	@echo "Running hello world program:"
	@./examples/hello
	@echo ""
	@./$(TARGET) examples/fib.k -o examples/fib.c
	@$(CC) examples/fib.c -o examples/fib
	@echo "Running fibonacci program:"
	@./examples/fib
	@echo ""
	@echo "All tests passed!"

test-c2k: $(C2K_TARGET)
	@echo "Testing C-to-K converter..."
	@./$(C2K_TARGET) examples/hello.c -o /tmp/hello_c2k.k
	@echo "Converted C to K:"
	@cat /tmp/hello_c2k.k
	@echo ""
	@./$(TARGET) /tmp/hello_c2k.k -o /tmp/hello_c2k.c
	@$(CC) /tmp/hello_c2k.c -o /tmp/hello_c2k
	@echo "Running converted program:"
	@/tmp/hello_c2k
	@echo ""
	@echo "C-to-K converter test passed!"

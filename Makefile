CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -O2
TARGET = klang

.PHONY: all clean test

all: $(TARGET)

$(TARGET): klang.c
	$(CC) $(CFLAGS) -o $(TARGET) klang.c

clean:
	rm -f $(TARGET) output.c examples/*.c examples/hello examples/fib

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

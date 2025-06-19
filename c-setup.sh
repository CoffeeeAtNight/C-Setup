#!/bin/bash

# Set project name
PROJECT_NAME=${1:-"my_c_project"}

# Create directory structure
mkdir -p "$PROJECT_NAME"/{src,include,build}
cd "$PROJECT_NAME" || exit 1

# Create main.c
cat <<EOF >src/main.c
#include <stdio.h>

int main() {
    printf("Hello, world!\\n");
    return 0;
}
EOF

# Create Makefile
cat <<EOF >Makefile
CC=gcc
CFLAGS=-Wall -Wextra -Iinclude
SRC=\$(wildcard src/*.c)
OBJ=\$(SRC:src/%.c=build/%.o)
TARGET=build/$PROJECT_NAME

all: \$(TARGET)

\$(TARGET): \$(OBJ)
	\$(CC) \$(CFLAGS) -o \$@ \$^

build/%.o: src/%.c
	\$(CC) \$(CFLAGS) -c \$< -o \$@

clean:
	rm -rf build/*.o \$(TARGET)

.PHONY: all clean
EOF

# Optional: .gitignore
cat <<EOF >.gitignore
/build/
/*.out
EOF

echo "C project '$PROJECT_NAME' created!"

# ======= BUILD CONFIG ======= #

# --- COMPILER --- #

CC = clang

# --- LINKER --- #

LD = clang

# --- DEPENDENCY GENERATOR --- #

MM = gcc

# --- COMPILER FLAGS --- #

CCFLAGS +=

# --- LINKER FLAGS --- #

LDFLAGS += -framework ApplicationServices
LDFLAGS += -framework AppKit

# --- LINKER LIBRARIES --- #

LDLIBS +=

# --- ARTIFACTS FOLDER --- #

ART = bin

# --- BINARY EXECUTABLE NAME --- #

EXE = dexterity

# --- SOURCE FILE DIRECTORIES --- #

DIR += .
DIR += common
DIR += test2
DIR += test

# ============================ #

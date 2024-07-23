BUILD_DIR=./build
SO_PATH=/home/user/NEMU-master/NEMU-master/build
SO_NAME=riscv64-nemu-interpreter-so

SIM_CSRC_DIR = $(abspath ./src/test/csrc/common)
SIM_CXXFILES = $(shell find $(SIM_CSRC_DIR) -name "*.cpp")

MAIN_DIR=$(abspath ./src/test/csrc/src)
MAIN_CXXFILES=$(shell find $(MAIN_DIR) -name "*.cpp")

DIFFTEST_CSRC_DIR = $(abspath ./src/test/csrc/difftest)
DIFFTEST_CXXFILES = $(shell find $(DIFFTEST_CSRC_DIR) -name "*.cpp")

CXX=g++ # You can customize this based on your compiler

# Combine all source files
ALL_CXXFILES = $(SIM_CXXFILES) $(MAIN_CXXFILES) $(DIFFTEST_CXXFILES)

# Generate object file names
OBJ_FILES = $(addprefix $(BUILD_DIR)/,$(notdir $(ALL_CXXFILES:.cpp=.o)))

# Compiler flags
CXXFLAGS=-Wall -std=c++11 # You can customize these flags based on your requirements

# Linker flags
LDFLAGS=-shared

run:
	rm -rf $(BUILD_DIR)
	mkdir build
	g++ -g $(SIM_CXXFILES) $(MAIN_CXXFILES) $(DIFFTEST_CXXFILES) -L$(SO_PATH)/$(SO_NAME)  -lz -ldl -O2 -o $(BUILD_DIR)/difftest

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
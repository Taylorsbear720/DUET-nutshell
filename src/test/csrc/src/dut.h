#include<stdio.h>
#include<stdlib.h>
#include<assert.h>
#include<dlfcn.h>
#include <sys/mman.h>  // 包含 mmap 函数相关的头文件
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <inttypes.h>
#include <ctime>
#include <chrono>
#include <thread>

typedef __uint32_t uint32_t;
typedef __uint8_t uint8_t;
typedef __uint16_t uint16_t;
typedef __uint64_t uint64_t;
extern volatile void *hdft_base;
#define HDFT_SIZE 1
#define HDFT_BASE 0x00000000
#define MIN_COMPARE  1
  extern int trapCode;
extern bool iscompare;
typedef struct data64_64{ 
    uint64_t regdata1;  
    uint64_t regdata2;
}data64_64;



 enum {
    STATE_GOODTRAP = 0,
    STATE_BADTRAP = 1,
    STATE_ABORT = 2,
    STATE_LIMIT_EXCEEDED = 3,
    STATE_SIG = 4,
    STATE_RUNNING = -1
  };

typedef struct data8_32{ 
    uint32_t  data32; 
    uint8_t  data81;
    uint8_t  data82;
    uint8_t  data83;
    uint8_t  data84; 
    uint64_t regdata64;
}data8_32;

typedef struct data32_8{ 
    uint32_t  data321; 
    uint32_t  data322; 
    uint32_t  data323; 
    uint8_t  data81;
    uint8_t  data82;
    uint8_t  data83;
    uint8_t  data84; 
}data32_8;


typedef struct Udut_data {
  data64_64  data1;
  data64_64  data2;
  data32_8   data3;
  data8_32  data4;
} Udut_data;
extern Udut_data Udata;

typedef struct dut_data {
  data64_64  data1;
  data64_64  data2;
  data32_8   data3;
  data8_32  data4;
  data64_64  data5;
  data64_64  data6;
  data64_64  data7;
  data64_64  data8;
  data64_64  data9;
  data64_64  data10;
  data64_64  data11;
  data64_64  data12;
  data64_64  data13;
} dut_data;
extern dut_data  dutdata;
extern data64_64 data64;
extern data8_32 data8;
//extern data64_32 data32;



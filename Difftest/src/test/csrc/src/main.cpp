#include "dut.h"
#include "../common/device.h"
#include "../common/sdcard.h"
#include "../difftest/difftest.h"
#include "../difftest/refproxy.h"
#include "../difftest/goldenmem.h"



#define DEBUG 1
#define COMPARE_COUNT  1


data64_64 data64;
data8_32 data8;
//data64_32 data32;
dut_data  dutdata;
//data mix_data;
data64_64 temptest;

volatile void *hdft_base;
uint64_t temp_regsum;
int counter=0;
int fd;
char *src={};
int trapCode;
long img_size=0;
FILE *file;

  int LAST_BEFORE=1;
  int LAST_AFTER=0;

void* create_map(size_t size, int fd, off_t offset) {
  void *base = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, offset);

  if (base == MAP_FAILED) {
    perror("init_mem mmap failed:");
    close(fd);
    exit(1);
  }

  printf("mapping paddr 0x%lx to vaddr 0x%" PRIxPTR "\n", offset, (uintptr_t)base);

  return base;
}

void init_map() {
  fd = open("/dev/mem", O_RDWR|O_SYNC);
  if (fd == -1)  {
    perror("init_map open failed:");
    exit(1);
  }

  hdft_base = create_map(HDFT_SIZE, fd, HDFT_BASE);
}

void finish_map() {
  munmap((void *)hdft_base, HDFT_SIZE);
  close(fd);
}



void displayInfo()
{
   for (int i = 0; i < NUM_CORES; i++) {
    printf("Core %d: ", i);
    auto trap = difftest[i]->get_trap_event();
    uint64_t pc = trap->pc;
    uint64_t instrCnt = trap->instrCnt;
    uint64_t cycleCnt = trap->cycleCnt;

    switch (trapCode) {
      case STATE_GOODTRAP:
        eprintf(ANSI_COLOR_GREEN "HIT GOOD TRAP at pc = 0x%" PRIx64 "\n" ANSI_COLOR_RESET, pc);
        break;
      case STATE_BADTRAP:
        eprintf(ANSI_COLOR_RED "HIT BAD TRAP at pc = 0x%" PRIx64 "\n" ANSI_COLOR_RESET, pc);
        break;
      case STATE_ABORT:
        eprintf(ANSI_COLOR_RED "ABORT at pc = 0x%" PRIx64 "\n" ANSI_COLOR_RESET, pc);
        break;
      case STATE_LIMIT_EXCEEDED:
        eprintf(ANSI_COLOR_YELLOW "EXCEEDING CYCLE/INSTR LIMIT at pc = 0x%" PRIx64 "\n" ANSI_COLOR_RESET, pc);
        break;
      case STATE_SIG:
        eprintf(ANSI_COLOR_YELLOW "SOME SIGNAL STOPS THE PROGRAM at pc = 0x%" PRIx64 "\n" ANSI_COLOR_RESET, pc);
        break;
      default:
        eprintf(ANSI_COLOR_RED "Unknown trap code: %d\n", trapCode);
    }

    double ipc = (double)instrCnt / cycleCnt;
    eprintf(ANSI_COLOR_MAGENTA "total guest instructions = %'" PRIu64 "\n" ANSI_COLOR_RESET, instrCnt);
    eprintf(ANSI_COLOR_MAGENTA "instrCnt = %'" PRIu64 ", cycleCnt = %'" PRIu64 ", IPC = %lf\n" ANSI_COLOR_RESET,
        instrCnt, cycleCnt, ipc);

  }
}

void init_difftest()
{

  difftest_init();
  init_device(); 

}


// void displayDutdata(dut_data data)
// {
//   printf("%lx,%lx\n",data.data1.regdata1,data.data1.regdata2);
//   printf("%lx,%lx\n",data.data2.regdata1,data.data2.regdata2);

//   printf("%x,%x,%lx\n",data.data3.data321,data.data3.data322,data.data3.regdata64);

//   printf("%lx,%lx\n",data.data4.regdata1,data.data4.regdata2);
//   printf("%lx,%lx\n",data.data5.regdata1,data.data5.regdata2);
//   printf("%lx,%lx\n",data.data6.regdata1,data.data6.regdata2);
//   printf("%lx,%lx\n",data.data7.regdata1,data.data7.regdata2);
//   printf("%lx,%lx\n",data.data8.regdata1,data.data8.regdata2);
//   printf("%lx,%lx\n",data.data9.regdata1,data.data9.regdata2);
//   printf("%lx,%lx\n",data.data10.regdata1,data.data10.regdata2);
//   printf("%lx,%lx\n",data.data11.regdata1,data.data11.regdata2);

//   printf("%x,%d,%d,%d,%d,%lx\n",data.data12.data32,data.data12.data81,data.data12.data82,data.data12.data83,data.data12.data84,data.data12.regdata64);
//   printf("%x,%d,%d,%d,%d,%lx\n",data.data13.data32,data.data13.data81,data.data13.data82,data.data13.data83,data.data13.data84,data.data13.regdata64);

// }

int main(int argc,char** argv){
    init_map();
    src=argv[1];
    trapCode = STATE_RUNNING;
   // int isRight;
   // inst_memory(src);
    init_ram(src);
    init_difftest();
    init_goldenmem();
    size_t ref_ramsize = EMU_RAM_SIZE ;
    init_nemuproxy(ref_ramsize);
    time_t begin,end;
    //Nullrun();
    bool isFirst=1;
    int compare=1;
    int time_count=0;
    int count=0;
    int fisrt=0Xdeadbeff;
    memcpy((void*)(hdft_base+0xf70), &fisrt, sizeof(int));
   begin=clock();
   while( trapCode == STATE_RUNNING)
   {
     time_count++;
    count++;
    if(compare%MIN_COMPARE==0 || isFirst)
    {
       difftest[0]->update_dut(count);
       isFirst=0;
       compare=1;
    }else{
       difftest[0]->update_Udut(count);
    }
      compare ++;
     
       if(count==19)
    {
      //getchar();
        //*(volatile unsigned int *)(hdft_base+0xff0)=1;
       memcpy((void*)(hdft_base+0xf70), &time_count, sizeof(int));
       count=0; 
    }
  //  if(count==19)
  //     {
  //      memcpy((void*)(hdft_base+0xff0), &LAST_AFTER, sizeof(int));
  //      // *(volatile unsigned int *)(hdft_base+0xff0)=0;
       
  //   }
      trapCode = difftest_state();
     if (trapCode != STATE_RUNNING) {
      break;
     }
    if (difftest_step()) {
        trapCode = STATE_ABORT;
        break;
      }
   }
    end=clock();
    double ret=double(end-begin)/CLOCKS_PER_SEC;
    memcpy((void*)(hdft_base+0xf70), &fisrt, sizeof(int));
    printf("the once time in difftest is %lf\n",ret); 
   displayInfo();
   
   //fclose(file);
   finish_map();

    return 0;

}
/************************************************/
/* project:                                     */
/* name:    echo.c                              */
/* summary:                                     */
/* author:                                      */
/* note:                                        */
/*                                              */
/************************************************/
#include<stdio.h>
#include <unistd.h>
#include <err.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>

#define MAX_READ 1023
// static declaration
void read_in(char *buffer, int len);
static int read_fixed(char *buffer, int len);
void write_back(char *msg);
static void write_fixed(char *msg, int len, char *reason);
static int to_read_length(void);
static int poll_input(void);
//*****************************************************
//  FUNCTION  main                                    
//  ABSTRACT
//  NOTE
//  ARGUMENTS int argc, char *argv[]
//             
//  RETURN
//  CREATE    2018/10/03 V1.00a Mikio
//-----------------------------------------------------
//  UpDate   VerNo   Name        Note
//*****************************************************
int main(int argc, char *argv[]){
  char buffer[MAX_READ + 1];

  for(;;){
    int res = poll_input();
    if(res > 0){
      int len = to_read_length();
      if(len > MAX_READ){
        err(EXIT_FAILURE, "Too large message to read.");
      }
      // len being less than zero indicates STDIN has been closed - exit
      if(len < 0){ return 1;}

      read_in(buffer, len);
      fprintf(stderr, "%s\r\n", buffer);
      write_back(buffer);
    }
  }
}
//*****************************************************
//  FUNCTION  read_in                                    
//  ABSTRACT
//  NOTE
//  ARGUMENTS char *buffer, int len 
//             
//  RETURN
//  CREATE    2018/10/03 V1.00a Mikio
//-----------------------------------------------------
//  UpDate   VerNo   Name        Note
//*****************************************************
static void read_in(char *buffer, int len){
  read_fixed(buffer, len);
  buffer[len] = '\0';
}
//*****************************************************
//  FUNCTION  read_fixed                                    
//  ABSTRACT
//  NOTE
//  ARGUMENTS char *buffer, int len 
//             
//  RETURN
//  CREATE    2018/10/03 V1.00a Mikio
//-----------------------------------------------------
//  UpDate   VerNo   Name        Note
//*****************************************************
static int read_fixed(char *buffer, int len){
  int read_count = 0;
  
  while(read_count < len){
    int this_read = read(STDIN_FILENO,
                         buffer + read_count,
                         len - read_count);
  
    // 0 is returned from read if EOF is STDIN has been closed.
    if(this_read == 0){
      return -1;
    }

    // errno is set to ENTER if interrupted by a signal before any data
    // is sent, Otherwise there has been an error.
    if(this_read < 0 && errno != EINTR){
      err(EXIT_FAILURE, "read failed");
    }
    read_count += this_read;
  }
  return len;
}
//*****************************************************
//  FUNCTION  write_back(char *msg)                                    
//  ABSTRACT
//  NOTE
//  ARGUMENTS char *buffer, int len 
//             
//  RETURN
//  CREATE    2018/10/03 V1.00a Mikio
//-----------------------------------------------------
//  UpDate   VerNo   Name        Note
//*****************************************************
static void write_back(char *msg){
  unsigned long len = strlen(msg);
  char size_header[2] = {(len >> 8 & 0xff), (len & 0xff)};

  write_fixed(size_header, 2, "header write");
  write_fixed(msg, len, "data write");
}
//*****************************************************
//  FUNCTION  write_fied(char *msg)                                    
//  ABSTRACT
//  NOTE
//  ARGUMENTS char *buffer, int len 
//             
//  RETURN
//  CREATE    2018/10/03 V1.00a Mikio
//-----------------------------------------------------
//  UpDate   VerNo   Name        Note
//*****************************************************
static void write_fixed(char *msg, int len, char *reason){
  int written = 0;

  while(written < len){
    int this_write = write(STDOUT_FILENO, msg + written, len - written);
    if(this_write <= 0 && errno != EINTR){
      err(EXIT_FAILURE, "%s: %d", reason, this_write);
    }
    written += this_write;
  }
}
//*****************************************************
//  FUNCTION  to_read_lengt()                                    
//  ABSTRACT
//  NOTE
//  ARGUMENTS
//             
//  RETURN
//  CREATE    2018/10/03 V1.00a Mikio
//-----------------------------------------------------
//  UpDate   VerNo   Name        Note
//*****************************************************
static int to_read_length(void){
  unsigned char size_header[2];
  int r = read_fixed((char*) size_header, 2);

  if(r < 0){
    return -1;
  }
  return (size_header[0] << 8) | size_header[1];
}

#include <unistd.h>
#include <poll.h>

//*****************************************************
//  FUNCTION  poll_input                                    
//  ABSTRACT
//  NOTE
//  ARGUMENTS char *buffer, int len 
//             
//  RETURN
//  CREATE    2018/10/03 V1.00a Mikio
//-----------------------------------------------------
//  UpDate   VerNo   Name        Note
//*****************************************************
int poll_input(void){
  int timeout = 5000;
  struct pollfd fd;

  fd.fd = STDIN_FILENO;
  fd.events = POLLIN;     // there is data to read
  fd.revents = 0;
  return poll(&fd, 1, timeout);
}

      // 

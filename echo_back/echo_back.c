#include <unistd.h>
#include <stdio.h>
int main() {
  char buffer[512];
  size_t bytes_read;
  int bytes_written;


  // Perfrom read syscall and store data in buffer
  bytes_read = read(0, buffer, 512);
  // echo back that buffer data using write syscall
  bytes_written = write(1, buffer, bytes_read);
  

  return 0; 
}
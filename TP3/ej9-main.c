#define STDOUT 1

int pid();
int sys_writefd(int fd, void *buff, int size);
int sys_readfd(int fd, void *buff, int size);
void sys_kill(int pid);
int sys_close(int fd);
int sys_open(const char *filename, int flags);

int strlenbreak(const char *str, int start) {
  int out = 0;
  while (str[out + start] || str[out + start] != '\n')
    out++;
  return out;
}

int strlen(const char *str) {
  int out = 0;
  while (str[out])
    out++;
  return out;
}

int puts(char *str) {
  int len = strlen(str);
  return sys_writefd(STDOUT, (void *)str, len);
}

void write_wline_number(int fd, char *buff) {

  char *line = 0;
  int size = 0;
  while (size < strlen(buff)) {
    size = strlenbreak(buff, size);
    // puts(line++);
    sys_writefd(STDOUT, buff, size);
  }
}

int main() {
  write_wline_number(STDOUT, "Hola como estan \n todo el mundo xd\n a\n");
  return 0;
}

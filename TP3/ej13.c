
struct pair {
  int a;
  int b;
};

void test_strucs(struct pair *a);
// void test_strucs(struct *pair a);

int main() {
  struct pair p;
  p.a = 0;
  test_strucs(&p);
  return 0;
}

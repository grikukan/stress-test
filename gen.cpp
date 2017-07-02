#include <bits/stdc++.h>
using namespace std;

int main(int argc, char **argv)
{
	assert(argc == 4); //Usage: max_n, min_val, max_val.
	long long seed;
	asm("rdtsc" : "=A"(seed));
	srand(seed);
	int max_n = atoi(argv[1]), min_val = atoi(argv[2]), max_val = atoi(argv[3]);
	int n = rand() % max_n + 1;
	printf("%d\n", n);
	for (int i = 0; i < n; i++) {
		printf("%d%c", rand() % (max_val - min_val + 1) + min_val, " \n"[i == n - 1]);
	}
	return 0;
}

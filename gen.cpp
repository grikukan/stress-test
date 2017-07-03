#include <bits/stdc++.h>
using namespace std;

int main(int argc, char **argv)
{
	long long seed;
	asm("rdtsc" : "=A"(seed));
	srand(seed);
	int max_n = 10, min_val = -10, max_val = 10;
	int n = rand() % max_n + 1;
	printf("%d\n", n);
	for (int i = 0; i < n; i++) {
		printf("%d%c", rand() % (max_val - min_val + 1) + min_val, " \n"[i == n - 1]);
	}
	return 0;
}

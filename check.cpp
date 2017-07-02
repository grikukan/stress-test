#include <bits/stdc++.h>
using namespace std;

bool check(int l, int r, int n) {
	return l >= 1 && r >= l && r <= n;
}
int main(int argc, char **argv)
{
	assert(argc == 4); //Usage: input_file, reference_answer, testing_answer
	ifstream test(argv[1]);
	ifstream reference(argv[2]);
	ifstream testing(argv[3]);
	int n;
	test >> n;
	vector<int> a(n);
	for (int i = 0; i < n; i++) {
		test >> a[i];
	}
	int refl, refr;
	reference >> refl >> refr;
	if (!check(refl, refr, n)) return 2;
	long long refsum = 0;
	for (int i = refl - 1; i < refr; i++) refsum += a[i];
	int testl, testr;
	testing >> testl >> testr;
	if (!check(testl, testr, n)) return 1;
	long long testsum = 0;
	for (int i = testl - 1; i < testr; i++) testsum += a[i];
	if (refsum > testsum) return 1;
	if (refsum < testsum) return 2;
	return 0;
}

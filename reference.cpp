#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef long double ld;
int a[100000];
int main()
{
#ifdef LOCAL
	freopen("input.txt", "r", stdin);
#endif
	int n;
	cin >> n;
	for (int i = 0; i < n; i++) {
		cin >> a[i];
	}
	ll res = 0[a];
	int resl = 1, resr = 1;
	for (int i = 0; i < n; i++) {
		for (int j = i; j < n; j++) {
			ll sum = 0;
			for (int k = i; k <= j; k++) {
				sum += a[k];
			}
			if (sum > res) {
				res = sum;
				resl = i + 1;
				resr = j + 1;
			}
		}
	}
	cout << resl << " " << resr << endl;
}


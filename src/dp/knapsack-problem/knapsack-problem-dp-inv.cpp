/**
 * 1 <= n <= 100
 * 1 <= w <= 10^7
 * 1 <= v <= 100
 * 1 <= W <= 10^9
 */
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;

#define FOR(i,a,b) for(int i=(a);i<(b);++i)
#define REP(i,n)  FOR(i,0,n)
#define FORR(i,a,b) for(int i=(a);i>=(b);--i)
#define REPR(i,n)  FORR(i,n,0)

#define dump(x)  cerr << #x << " = " << (x) << endl;

/*
int n=4, W=5;
int w[4] = {2,1,3,2};
int v[4] = {3,2,4,2};
// ans=7
*/
typedef unsigned long ul;

int n=100, W=1000;
long w[100] = {63,25,30,46,1,8,27,82,19,53,88,52,8,35,90,44,64,6,79,5,2,6,80,73,45,35,65,20,4,32,29,30,49,67,25,86,79,31,46,7,34,42,92,11,62,95,29,2,53,81,74,93,1,65,46,18,3,13,22,75,28,53,38,35,31,36,43,40,10,72,42,27,32,32,10,92,82,41,25,93,24,71,62,20,37,9,79,58,24,26,36,81,64,49,46,87,64,20,31,60};
int v[100] = {53,9,65,12,56,50,80,45,80,71,97,21,63,29,40,94,50,23,1,76,34,87,11,41,58,83,67,89,65,11,44,78,81,53,58,87,12,95,5,47,91,52,99,26,60,78,90,82,92,23,76,67,66,76,47,23,91,82,59,12,3,95,13,95,15,95,67,45,22,34,53,67,23,90,62,25,14,35,19,7,69,100,15,53,19,60,5,21,34,61,75,71,65,67,8,42,40,2,20,46};
// ans=3051

// [i]x[v] -> w_min
ul dp[101][10001/* (n * v_max + 1) */];
ul max_w = 1000000000;

void solve() {
  memset(dp, max_w, sizeof(dp));
  REP(i, 101) REP(j, 10001) dp[i][j] = max_w;

  int max_v = 0;
  REP(i, n) REP(j, 10001) {
    if (i==0) {
      if (j>v[i]) break;
      dp[i][j] = w[i];
    } else {
      ul with_me = v[i]>=j ? w[i] : dp[i-1][j-v[i]]+w[i];
      dp[i][j] = min(dp[i-1][j], with_me);
      if (dp[i][j] >= max_w && with_me >= max_w) break;
    }
    if (dp[i][j]<=W && j > max_v) max_v = j;
  }
  cout << max_v << endl;
}

int main(int argc, char const *argv[]) {
  memset(dp, 0, sizeof(dp));
  solve();
}

```python
n = int(input())
for i in range(n):
    a, b = map(int, input().split())
    print(a+b)
```

```cpp
#include<iostream>
using namespace std;
int main() {
    int n;
    cin >> n;
    for (int i = 0; i < n; i++) {
        int a, b;
        cin >> a >> b;
        cout << a+b << endl;
    }
}
```

```ruby
n = gets.to_i
n.times do
    a, b = gets.chomp.split.map { |x| x.to_i }
    puts a + b
end
```
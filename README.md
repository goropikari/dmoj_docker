# DMOJ Docker

Related
- [site](https://github.com/goropikari/online-judge)
- [judge server](https://github.com/goropikari/judge-server)

## Setup

```bash
# start web server and judge server
git clone https://github.com/goropikari/dmoj_docker.git
cd dmoj_docker
docker compose up -d

# stop system
docker compose down
```

Access http://127.0.0.1:8080/admin
- user name: admin
- password: admin


## For me
### Push images
Build site and judger docker images.

push image to dockerhub
```
make push-image

# push only site image
make push-site-image
```

### Development

```
make dev-build
make dev-run
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

```python
n = int(input())
for i in range(n):
    a, b = map(int, input().split())
    print(a+b)
```

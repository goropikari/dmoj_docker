# DMOJ Docker

## Setup

```bash
# start web server and judge server
git clone https://github.com/goropikari/dmoj_docker.git
cd dmoj_docker
docker compose up -d

# stop system
docker compose down
```

Access http://localhost:8000/admin .
- user name: admin
- password: admin


## For me
### Push images
Build site and judger docker images.

push image to dockerhub
```
docker compose down && yes | docker system prune && yes | docker volume prune

docker build -t goropikari/dmoj-site:debug -f site/Dockerfile --no-cache site
docker build -t goropikari/dmoj-judger:debug -f judger/Dockerfile --no-cache judger

docker login
docker push goropikari/dmoj-site:debug
docker push goropikari/dmoj-judger:debug
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

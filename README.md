# DMOJ Docker

## Setup

```bash
# start web server and judge server
git clone https://github.com/goropikari/dmoj_docker.git
docker compose up -d

# stop system
docker compose down
```

Access http://localhost:8000/admin .
- user name: admin
- password: admin


## For me

Build site and judger docker images.

```
docker compose down && yes | docker system prune && yes | docker volume prune

docker build -t goropikari/dmoj-site:debug -f site/Dockerfile site
docker build -t goropikari/dmoj-judger:debug -f judger/Dockerfile judger

docker login
docker push goropikari/dmoj-site:debug
docker push goropikari/dmoj-judger:debug
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

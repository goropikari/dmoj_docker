```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y git gcc g++ make libxml2-dev libxslt1-dev zlib1g-dev gettext curl libmysqlclient-dev mysql-client redis-tools libseccomp-dev
npm install -g sass postcss-cli postcss autoprefixer
```


docker run -d -p 6379:6379 public.ecr.aws/docker/library/redis:7.4.2
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root public.ecr.aws/docker/library/mysql:8.0.41-debian


mysql -h 127.0.0.1 -uroot -proot
CREATE DATABASE dmoj DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
CREATE USER 'dmoj'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON dmoj.* TO 'dmoj'@'%';


python -m venv venv
source venv/bin/activate

git clone --recursive https://github.com/DMOJ/oneline-judge.git site
cd site
git checkout v4.0.0
pip3 install -r requirements.txt
pip3 install mysqlclient setuptools lxml_html_clean redis websocket-client
cp ../local_settings.py dmoj/
python3 manage.py check

./make_style.sh
python3 manage.py collectstatic
python3 manage.py compilemessages
python3 manage.py compilejsi18n

python3 manage.py migrate

python3 manage.py loaddata navbar
python3 manage.py loaddata language_all
python3 manage.py loaddata demo
python3 manage.py createsuperuser # user: vscode, password: testtest


python3 manage.py runserver 0.0.0.0:8000
python3 manage.py runbridged
celery -A dmoj_celery worker



judge server
pip3 install dmoj


http://localhost:8000/admin/judge/judge/add
judge.yml の内容で追加
dmoj -c problems/judge.yml localhost

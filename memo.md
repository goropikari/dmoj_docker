# 問題の追加

問題文を書いた markdown とテストケースをどこかにおいて取り込んでほしいがそういう機構はないっぽい。
問題に関しては site のほうの [`judge/fixtures/demo.json`](https://github.com/goropikari/online-judge/blob/966b37d52fe88ec28fbd845cf31164a56d900c17/judge/fixtures/demo.json#L82-L129) のように fixture として取り込むのがいいのかな？

問題のページから `Edit test data` でテストデータを登録しても judge ができない。
judger container の `/problems` に問題のテストケース、`init.yml` を置くと初めて judge の対象となる気がする。


# 新しい言語の追加方法

- judger container にその言語の処理系を入れる。
- dmoj/executors/ にその言語用のファイルを追加
  - https://github.com/goropikari/judge-server/blob/b3b0c28b51035790c9523af4c5952d2f0b196088/dmoj/executors/CPP20.py
  - ファイル名が online-judge/judge/fixtures/languages.json で取り込む key に対応している用に見える
    - https://github.com/goropikari/online-judge/blob/5799807dc3125bb1e05fea64984fd8984492ecb1/judge/fixtures/languages.json#L339-L353
  - ファイルの中にある command という変数に入れている名前が judge.yml のキー名に対応している用に見える
    - https://github.com/goropikari/judge-server/blob/b3b0c28b51035790c9523af4c5952d2f0b196088/dmoj/executors/CPP20.py#L5
    - https://github.com/goropikari/dmoj_docker/blob/01081ee5d45838e36f9b71257d8e0dbf6cb422e1/docker/judger/problems/judge.yml#L20

結論
- [online-judge/judge/fixtures/languages.json](https://github.com/goropikari/online-judge/blob/5799807dc3125bb1e05fea64984fd8984492ecb1/judge/fixtures/languages.json) に言語設定追加
- [judge-server/dmoj/executors/](https://github.com/goropikari/judge-server/tree/master/dmoj/executors) にファイル追加
- [judge.yml](https://github.com/goropikari/dmoj_docker/blob/01081ee5d45838e36f9b71257d8e0dbf6cb422e1/docker/judger/problems/judge.yml) に runtime を追加
- site, judger 両方のイメージを rebuild


`pip install dmoj` で入れると executor が古いので git clone して最新のやつを持った来たほうがよさそう。

# supervisor

supervisor で起動するプロセスがどうにも docker compose で渡す環境変数を参照できない気がする。

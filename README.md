# 環境構築手順

### 一つずつ行きます。

クローン忘れずに！
クローンしたディレクトリに移動してから初めてください！

1. まず`docker-compose build`で dockerfile をビルドしてイメージを作成。

- `docker images`で確認！

2. `docker-compose up -d`で docker-compose.yml 通りに実行しデタッチドモードでバックグラウンドでコンテナ起動。

- ここでポスグレが DockerHub から pull してきてるはずです。
- rails と DB のコンテナが同時に起動してネットワークも完成してるはずです

```
[+] Running 4/4
 ⠿ Network rails_product_default   Created
 ⠿ Volume "rails_product_db-data"  Created
 ⠿ Container postgres_db           Started
 ⠿ Container rails                 Started
```

この部分 ↑

3. 再度`docker images`で確認！ぽスグレが追加されてるはずです

4. `docker-compose ps -a`でコンテナが作られているか？起動しているか？確認します！STATUS が Up になっていたらお k です。

5. おそらく、今`http://localhost:3000/`に繋げたらエラーが出てると思います。

これは DB がないよと怒られてますね。Rails 経由で作ってあげましょう！

6. `docker-compose exec web bash`でサーバー名が web 即ち、Rails のコンテナにアクセスし bash コマンドでコンテナの中に入ります。

7. コンテナ内で`rails db:create`で DB を作成

rails_product_development と rails_product_test の DB が作られるはずです。

8. コンテナ内で`rails db:migrate`でマイグレーションファイルにあるデータを作った DB に送ります。

ここでは、DB に products テーブルを作成したイメージで大丈夫です！

9. 寂しいしょうもないアプリが表示されたら成功です！！

ホストマシンに Rails が保存されてなくても Rails が使えたのがわかりましたね！b

しっかり作成、編集、削除できてるか確認してみてください！

DB 接続もうまく言ってると思います。

10. `docker-compose stop`で接続を切ることができます。ローカル 3000 番を再度リロードしてみてください、

アクセスできなくなってるはずです。ちなみに再度入る場合は`docker-compose up -d`です。

`docker-compose up -d`ではなく`docker-compose up`で起動すると log が常に表示されます。stop は control + c です。

11. 最後に削除を行います。`docker-compose ps -a`でコンテナ状態を確認しましょう。停止中だと思います

`docker-compose down`でコンテナ停止と削除同時に行えます！

`docker-compose ps -a`確認するとなくなってると思います。

イメージ削除もやっちゃいましょう！

`docker images`で imageID を確認。

`docker rmi イメージID`で削除！

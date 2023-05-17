# rubyのイメージをDockerHubからpullしてます。
FROM ruby:3.2.2
# railsに必要なパッケージ（ライブラリ）をインストールしてます
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn

# コンテナ内で開発アプリ専用ディレクトリを作りつつ、移動
WORKDIR /rails_product-in
# Gemfileはコンテナ内でbundle installしたいためホストのGemfile Gemfile.lockを
# コンテナ内のrails_product-inにコピー。
ADD Gemfile Gemfile.lock /rails_product-in/
# bundle install実行
RUN bundle install
# デフォルトコマンドをrailsサーバーを立ち上げるコマンドにしてます。
CMD ["rails", "s", "-b", "0.0.0.0"]

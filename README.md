# README

<img alt="stack" src="https://skillicons.dev/icons?theme=dark&perline=7&i=css,bootstrap,rails,minitest" />

test: minitest

[開発記録](./.md/./DEV.md)

## セットアップ方法

### 依存関係のインストール

```bash
rails -v
# Rails 7.0.4.3
bundle -v
# Bundler version 2.6.3

bundle install
```

### データベースのセットアップ

```bash
rails db:create
rails db:migrate
rails db:seed
```

### アプリケーションの起動

```bash
rails server
```

### ロケール設定

日本語にも少しだけ対応

```ruby
# config/application.rb
config.i18n.default_locale = :ja #:en
```

### テストの実行

```bash
rails test
```

### Lint

```bash
rubocop
```

### debug情報を表示する

```rb
# config/environments/development.rb
config.consider_all_requests_local = true
```

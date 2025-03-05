# README

<img alt="stack" src="https://skillicons.dev/icons?theme=dark&perline=7&i=css,rails,js,minitest" />

[開発記録](./.md/./DEV.md)

## セットアップ方法

### 依存関係のインストール

```bash
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

```ruby
# config/application.rb
config.i18n.default_locale = :ja
```

### テストの実行

```bash
rails test
```

### Lint

```bash
rubocop
```

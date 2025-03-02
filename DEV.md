blender で cake や coffee の 3Dmodel を作成して、埋め込めたら面白そう、できれば cube 上の店もつくりたい。

## must

- CRUD 操作の実装
- input の validation
- minitest 自分の手で書く
- 写真のアップロード
- 日記をつける

## やりたいこと

- レスポンシブ対応 sidebar<->hamburger
- blender で商品のモデル作成
- three.js による埋め込み
- blender で店の model を作成
- 地図の埋め込み
- User の実装
- rails --api

## 参考サイト

- [tullys](https://www.tullys.co.jp/)
- [starbacks](https://www.starbucks.co.jp/)

- [importmap](https://note.com/everyleaf/n/n0a5934373f12)

## references

- [google-font](https://fonts.google.com/)

# March 1st 🌸

```sh
bundle exec rails _7.0.4.3_ new cafe_lp
cd cafe_lp
bundle install
```

### github

- workflow とりあえず minitest と rubocop のテストを pull request の時に行うようにする。
  master branch を protect した。private だと branch rule を作成できないみたい。色々と試してたら organization を作ってしまった。

- merge より rebase を多用してみる。reset --hard は使わないように解決する、使った git command も記録として極力残す。

### formatter & linter

rubocop の使い方がいまいちわからないので保存時に.rb だけ整形されない。.erb は`gem 'htmlbeautifier'`で、他は`prettier`で整形されるようにした。

```sh
# auto correct
rubocop -a
```

### layout

figma の使い方を覚えた方が良さそう？

とりあえず商品ページを並べるための home を作成する。

```rb :test/test_helper.rb
require "minitest/reporters"
Minitest::Reporters.use!
```

test がいい感じになる library

```sh
bin/rails generate controller static-pages home about
bin/rails generate model Product uid:string name:string cost:decimal price:decimal ref:string description:text category:string

#
bin/rails generate migration add_unique_index_to_products_uid
bin/rails db:migrate
```

validate で小数の精度を要求する場合。
format: { with: /\A\d+(\.\d{1,2})?\z/ }

uid の作成方法

```rb
require 'securerandom'
uid = SecureRandom.uuid
```

title は SEO 対策につけておいた方が良さそう

```css
object-fit: cover; /* 縦横比を保ちながら、親要素に合わせてトリミング */
```

## icon

```sh
# Gemfile
gem 'font-awesome-sass'

#custom.scss
@import "font-awesome";
```

# March 2nd 🍡

header の css を当てる developer tool をもっと有効活用したら、楽に作業できそう。
`width: 100%;`を当てていないから flex-end などの挙動がおかしかった。
`⌥ ⌘　T`close other window がかなり便利

`⇧ ⌘ T`で tab 復元

```sh
bin/rails generate controller Products index show new edit
```

## CRUD 操作

new->create
edit->update

定型文なのでまずこれを用意する。
new と create で 2 回 new するのは謎

```rb :foo_controller.rb
before_action :set_foo, only: [:show, :edit, :update, :destroy]

private
  def foo_params
    params.require(:foo).permit("必要なcolumn")
  end

  def set_foo
    @foo = Foo.find(params[:id])
  end
```

## destroy 時の error

```sh
Uncaught TypeError: Failed to resolve module specifier "controllers". Relative references must start with either "/", "./", or "../".
```

またこのエラーに遭遇。
`app/javascript/controllers`を tutorial から丸ごと移植すると解決。importmap 関連の directory が最初からないのが問題。`mkdir -p`sub directory がない場合作成してくれるのでかなり便利！

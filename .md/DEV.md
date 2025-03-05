[todo](./todo.md)

## 参考サイト

**FREE IMAGE**

- https://www.pexels.com/

**DESIGN**

- https://webdesignclip.com/
- [bach-kaffe](https://www.bach-kaffee.co.jp)
- [tullys](https://www.tullys.co.jp/)
- [starbacks](https://www.starbucks.co.jp/)
- [mac](https://www.mcdonalds.co.jp/)

- **TECH BLOG**

- [importmap](https://note.com/everyleaf/n/n0a5934373f12)
- [custom 404 500](https://qiita.com/YutoYasunaga/items/7c2e6962966677610d39)
- [preview](https://zenn.dev/redheadchloe/articles/24e0fb357df71b)

**CSS**

- https://developer.mozilla.org/ja/docs/Web/CSS
- [画像 scroll](https://rita-plus.com/blog/css-animation-scroll-infinity/)

**CATEGORY ANY**

- [google-font](https://fonts.google.com/)
- [http status code](https://learn.microsoft.com/ja-jp/dotnet/api/system.net.httpstatuscode?view=net-8.0)

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

rubocop の使い方がいまいちわからないので保存時に.rb だけ整形されない。.erb は`gem 'htmlbeautifier'`で、他は`prettier`
で整形されるようにした。

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

# uidをつけたら警告が出たので
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

create するときに割り当てることを忘れずに

```rb

def create
  @product.uid ||= SecureRandom.uuid
end
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
`app/javascript/controllers`を tutorial から丸ごと移植すると解決。importmap 関連の directory が最初からないのが問題。
`mkdir -p`sub directory がない場合作成してくれるのでかなり便利！

product.css を頑張った。hover のアクションが色々とあって面白い。今回 ease-in-out はかなりハマっていると思う。1 商品ごとの
width を 31％に拘らなければ、もっと簡単に書ける気がする。

午後にやりたいこと

- ~~edit の実装~~
- ~~img の埋め込み~~
- ~~minitest を書く~~

再開。少し tutorial を読んでいた、vscode 色々といじっていたら erb にカラーが適用されなくなってしまった。

```sh
 POST http://127.0.0.1:3000/products 422 (Unprocessable Entity)
 #422 (Unprocessable Entity) は、リクエスト自体はサーバーに到達したものの、バリデーションエラーなどの理由で処理できなかった時に発生させる
```

status を書いておいたので、debug が楽だった。strong parameter で permit している要素が足りていなかった。

## image の upload

参考 https://railstutorial.jp/chapters/user_microposts?version=7.0#sec-micropost_images

```sh
bin/rails active_storage:install
bin/rails db:migrate
```

```sh
#rubocop warning
Offenses:

app/models/product.rb:11:44: C: Rails/I18nLocaleTexts: Move locale texts to the locale files in the config/locales directory.
```

error メッセージのハードコーディングが検出された。めっちゃ優秀。locale によって error
メッセージの言語を変えられたほうが、ユーザーフレンドリーかもしれない。[guide](https://railsguides.jp/i18n.html)
i18n は`internationalization`が 18 文字だかららしい 😕

## MIME type

Multipurpose Internet Mail Extensions
多分追記

```rb
#model 今回はrefが一つだけなので
has_one_attached :ref

                 #controller
                 # create newに追加する。has_one_attachedは上書きする。
                 ...
                   @product.ref.attach(params[:product][:ref])
...
```

image の seed を作るのに時間がかかった。jpeg の中の拡張子が違くて validation に引っかかってしまっていたため変な挙動になっていた。
`in: %w[image/png image/jpg image/jpeg image/gif image/webp]`webp も追加するようにした。

## integration test

```sh
bin/rails generate integration_test product_new
bin/rails generate integration_test product_edit
bin/rails generate integration_test product_delete
```

| アクション  | HTTP メソッド | 確認方法                                                 |
| ----------- | ------------- | -------------------------------------------------------- |
| new/create  | POST          | assert_difference 'Product.count'で個数の変化を確認      |
| edit/update | PATCH         | assert_equal @product.reload.属性名で更新後の値を確認    |
| destroy     | DELETE        | assert_difference 'Product.count', -1 で個数の減少を確認 |

github で pull_request する前に`act pull_request`で local で検証できるみたい。
pull_request は最新コミットが反映されらしい、、、ｼﾗﾅｶｯﾀ

# March 3rd ☘️

**todo**

- delete したページのフォワーディング
- edit, index のスタイリング(index は sidevar でカテゴリーを選択できるようにしたい。Home は最初 4
  枚だけでもいいかもしれない)
- page-title background-color は文字の上半分だけかぶるようにしたい

## 404

product の削除->index にフォワーディング->ページを戻る->404

public/404.html は local 環境だと表示されないので、以下を設定する。これだと全ての debug 情報が失われてしまうので、確認したら戻す。

```rb
# config/environments/development.rb
config.consider_all_requests_local = false
```

production 環境が用意されている場合は

```sh
RAILS_ENV=production bin/rails s
```

でも大丈夫そう。404 以外に使う status

| エラー                        | 原因                                                                |
| ----------------------------- | ------------------------------------------------------------------- |
| **422 Unprocessable Entity**  | バリデーションエラー、Strong Parameters の制限、CSRF トークンエラー |
| **500 Internal Server Error** | Ruby の例外、データベースエラー、環境変数未設定、API のタイムアウト |

エラーログは `log/development.log` に蓄積される
[custom 404 500](https://qiita.com/YutoYasunaga/items/7c2e6962966677610d39)

404.html だと静的ファイルなので header や footer が適用されない。
長くなりそうなのでファイルを分けた

[エラーページをカスタムする](./custom404.md)

page not found のカスタムと戦っていたら、思ったより時間が経ってしまったけど、色々と勉強になった気がする

# March 4th 💐

css でスタイリング。home の画像スクロール[画像 scroll](https://rita-plus.com/blog/css-animation-scroll-infinity/)

```html
<li>
  <%= link_to root_path + "#map" do %>
  <i class="fa-solid fa-location-dot"></i>
  <% end %>
</li>
```

これでページの途中に飛べる。

```css
a:hover {
  color: #8b8b8b;
  text-decoration: underline;
  text-decoration-color: rgb(110, 180, 145);
  text-underline-offset: 10px;
  text-decoration-thickness: 3px;
}
```

この設定かなりお気に入り。

`link_to "#"`を単に`#`と書いてしまうと`too many redirects`で動かなくなってしまう。
言語切り替えはできれば dropdown からやりたい。

[linear gradient](https://developer.mozilla.org/ja/docs/Web/CSS/gradient/linear-gradient)
👆 面白そう 使わなかったけど

`>` を使うと一つ下の子供にのみ影響できるらしい
画像のリサイズが難しい。。。

`flex-grow` = 残り空間をどれだけ割り当てるか

## 親要素の width を無視して 100vh 当てる

[example](../app/assets/stylesheets/product/index.css#L1-L10)

## sidebar

sidebar + main で sidbar のリンクを触れたら`@current = @drinks`みたいな感じにしたかったけど、簡単には行かなかった。
Ajax を使うか js で`onClick`で書くかなので、drinks,meals,etc それぞれのページを作った方が楽そう、、、
眠いので一回眠る。

## `application.html.erb`以外の基底 view を使用する方法

```rb

class UsersController < ApplicationController
  layout "users" # app/views/layouts/users.html.erb を使用
  # layout false  # レイアウトを適用しない
end
```

今日あまり眠れなくて、なかなかやる気が出ない。discord を clone する講座が値引きされていたので買った。その前に少し modern js
を勉強しておく。

とりあえず 後やることの[list](./todo.md#L22)

## March 5th 🍎

少し jet brains 製品に触れてみる。mdはこちらの方が見やすいかもしれない、ただ表の枠線を除きたい。

| keymap | action     |
| ------ | ---------- |
| ^ ⇧ -  | Go forward |

でできるようにした。
jet brainsだと`⌘ [ ]`でできるので、vscodeでもこっちにしたほうが便利なのかもしれない。configがxmlであまり慣れない。とりあえずprettierを導入したい。

| vscode        | JetBrains   | Action |
| ------------- | ----------- | ------ |
| reload window | restart IDE | 再起動 |
|               | ⌘⌥L         | format |
|               |             |        |

erbの他にhamlというものがあるらしい。
products-indexは、`@current`によってviewが切り替わるようにしたい。
`@current.category`のようにアクセスしようとしていて、かなり悩んだ。`@current`は配列なのでcategoryもインスタンス変数として持つことにした。

```rb
def index
    @category = params[:category] || 'drinks'
    @current = Product.where(category: @category)
end

# 呼び出し側
<li><%= link_to "Drinks", products_path(category: 'drinks')%></li>
```

` <%= @current.count%>`debugに便利かもしれない。もっと細かくminitestを書く若しくはdebuggerを使った方がいいかも。
parameterについて理解が足りていなかったけど、jsの`onClick`みたいなものがない代わりにparameterを使って関数を発火できた。

## 検索機能

とりあえずnameだけ検索、価格とかで検索できたら面白そう。検索boxのcssがあまり納得いっていないかもしれない。
部分検索はsqlのlikeを使えばいい、ここら辺は生sqlをもっと勉強した方が良さそう。複数形にも一応対応

```rb
def index
  if params[:search].present?
        @current = Product.where("name LIKE ?", "%#{params[:search]}%")
        @category = "#{helpers.pluralize(@current.count, 'result')} found"
  else
  ...
```

## March 6th

## detail

```rb
<%= number_to_currency(@product.price.floor, unit: "¥", separator: ".", delimiter: ",", precision: 0) %>
```

三桁区切りで,を入れてくれる便利かもしれない

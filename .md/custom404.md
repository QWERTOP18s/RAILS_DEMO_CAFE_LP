1. `ErrorsController` を作成
2. `rescue_from`で redirect する
3. `routes.rb` でエラールートを設定

```sh
bin/rails generate controller Errors not_found internal_server_error
```

```rb
#errors_controller.rb
class ErrorsController < ApplicationController
  def not_found
    render template: "errors/not_found", status: :not_found
  end

  def internal_server_error
    render template: "errors/internal_server_error", status: :internal_server_error
  end
end
```

```rb
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from StandardError, with: :render_internal_error

  private

  def render_not_found
    redirect_to errors_not_found_path
  end

  def render_internal_error
    redirect_to errors_internal_server_error_path
  end
end
```

```rb
# # config/routes.rb
# Rails.application.routes.draw do

#   # エラーページ用のルートを追加
#   match "/404", to: "errors#not_found", via: :all
#   match "/500", to: "errors#internal_server_error", via: :all
# end
```

上の routes 設定だとあまり上手く行かなかった。

```
# config/routes.rb
get '*path', to: 'errors#not_found'
```

404 をキャッチするなら上のようにかけるけど、500 がキャッチで来ていない気がする。`rescue_from`についてもあまり理解できていない。
とりあえず 404 だけこの方法で処理して後で治せそうだったらなおす
この方法だと development 環境でも処理できる

```rb
#not_found.html.erb
<h1>404 Not Found</h1>
<p> <%= I18n.t('errors.messages.not_found') %></p>
```

多言語対応できるようにした。default の設定は config から

```rb
#config/application.rb
config.i18n.default_locale = :ja
```

```rb
#routes.rb
#routes.rb
  match '*path', to: 'errors#not_found', via: :all, constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
```

activeStorage が使えなくなってしまっ低田ので、上のようにした。

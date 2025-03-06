`resources :events, only: [:update, :create, :destroy]`

イベントの `update` と `create` 操作をモーダルで実装したい

### 1. コントローラー

```ruby
# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :set_event, only: [:update, :destroy]

  def create
    @event = Event.new(event_params)
    if @event.save
        format.js   # create.js.erb を呼び出す
      end
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
        format.js   # update.js.erb を呼び出す
      end
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date)
  end
end
```

### 2. ビュー

```rb
# _form.html.erb
<%= form_with(model: @event, remote: true) do |form| %>
  <div class="form-group">
    <%= form.label :name %>
    <%= form.text_field :name, class: "form-control" %>
  </div>
  <div class="form-group">
    <%= form.label :description %>
    <%= form.text_area :description, class: "form-control" %>
  </div>
  <div class="form-group">
    <%= form.label :date %>
    <%= form.date_field :date, class: "form-control" %>
  </div>
  <%= form.submit "Save", class: "btn btn-primary" %>
<% end %>
```

```rb
# _modal.html.erb
<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="eventModalLabel">Create or Edit Event</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <%= render 'form', event: @event %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <%= form.submit 'Save', class: 'btn btn-primary' %>
      </div>
    </div>
  </div>
</div>
```

### 3. js.erb

```js
// create.js.erb
// 新しいイベントを作成後、モーダルを閉じてイベントリストに追加する
$("#eventModal").modal("hide");
$("#events-list").append("<%= j render(@event) %>"); // 新しいイベントをリストに追加
```

```js
// update.js.erb
// 更新されたイベント情報をリストに反映
$("#eventModal").modal("hide");
$("#event_<%= @event.id %>").replaceWith("<%= j render(@event) %>"); // 更新されたイベントをリストで置き換え
```

### 4. モーダルを表示するためのボタン

`data-bs-toggle="modal"`を使ってモーダルを開く。

```rb
# Create
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#eventModal">
  Create Event
</button>


# Edit
<%= link_to 'Edit', edit_event_path(event), class: 'btn btn-warning', data: { bs_toggle: 'modal', bs_target: '#eventModal' } %>
```

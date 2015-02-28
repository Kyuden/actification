# Actification

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'actification'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install actification

## Database setup

Create migration for actifications and migrate the database

```console
rails g actification:migration
rake db:migrate
```

## Usage

TODO: Write usage instructions here

```ruby
# app/actifications/user_actification.rb
class ArticleActification < Actification::Base
  default from: current_user

  def publish_article(article)
    actice(to:       article.active_user,
           body:     "#{article.auther} published 「#{article.title}」",
           link_url: article_path(article))
  end

  def delete_article(article)
    actice(to:   article.watch_user,
           from: article.user_id
           body: "#{article.auther} deleted 「#{article.title}」")
  end
end
```

```ruby
# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController

  def create
    @article = Article.new(article_params)

    if @article.save
      ArticleActification.publish_article(@article)
      redirect_to @article
    else
      render :new
    end
  end
end
```

```ruby
# app/controllers/top_controller.rb
class TopController < ApplicationController
  def index
    @actifications = Actification::Model.all
  end
end
```

```ruby
# config/initializers/actification.rb
Actification.configure do |config|
  config.cleaner = true

  # To use root_path in xxxActification class
  config.include Rails.application.routes.url_helpers
end
```

```ruby
# migration.rb
class Actification::Base < ActiveRecord::Migration
  def change
    create_table :actifications do |t|
      t.integer :to,           null: false
      t.integer :from
      t.string  :body,         null: false, limit: 512
      t.string  :link_url
      t.boolean :read,         null: false, default: false
      t.string  :type,

      t.timestamps
    end

    add_index :actifications, [:read, :to]
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/actification/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

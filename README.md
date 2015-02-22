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
           body:     "#{auther.name} published 「#{articletitle}」",
           link_url: article_url)
  end

  def delete_article(article)
    actice(to:   article.watch_user,
           body: "#{auther.name} deleted 「#{articletitle}」")
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
    @actifications = Actification::Base.all
    @article_actifications = ArticleActification.all
  end
end
```

```ruby
# config/initializers/actification.rb
Actification.configure do |config|
  config.cleaner = true
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

# Assignment 4 - Reverse article titles

The articles overview page can be found [here](/articles). The customer is from Australia and wants to reverse the titles of the articles. It is up to you to correctly implement it.

## Haskell

The articles page is handled in the `getArticlesR` function. In the function, the articles are fetched from the database.

    (articles :: [Entity Article]) <- runDB $ selectList [] []

The articles are looped over, and title printed in the `articles.hamlet` HTML template view:

    $forall Entity articleId article <- articles
      <li>
        #{articleTitle article}

The `#{articleTitle article}` line prints the article title. Reverse that title using a function. Tip: use [Hoogle](https://www.haskell.org/hoogle/) to search for function names and how to use them.

## Ruby

The article page is handeld by the `get "articles"` block. Inside this block the articles are fetched using the following line:

    @articles = Article.all

The template called `articles.erb` loops over those articles and displays their title. This is done with the following lines:

    <% @articles.each do |article| %>
        <li><%= article.title %></li>
    <% end %>

This title is of the type `String` which provides a function to reverse it's contents. Tip: use [ruby-doc](http://www.ruby-doc.org/core-2.2.0/String.html) to search for function names and how to use them

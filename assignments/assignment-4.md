# Assignment 4 - Reverse article titles

The articles overview page can be found [here](/articles). The customer is from Australia and wants to reverse the titles of the articles. It is up to you to correctly implement it.

## Haskell

The articles page is handled in the `getArticlesR` function. In the function, the articles are fetched from the database.

    (articles :: [Entity Article]) <- runDB $ selectList [] []

The articles are looped over, and title printed in the `articles.hamlet` HTML template view:

    $forall Entity articleId article <- articles
      <li>
        #{articleTitle article}

The `#{articleTitle article}` line prints the article title. Reverse that title using a function. Tip: use [Hoogle](https://www.haskell.org/hoogle/) to search for function names and their usages.

## Ruby

To be added

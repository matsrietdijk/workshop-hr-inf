# Assignment 2 - Reorder the authors

On the [about](http://0.0.0.0:4567/about) page the client wanted to display all authors. Your colleague implemented this but forgot one thing: the client requested the authors to be ordered ascending based on their name. Your colleague isn't available at the moment so you are assigned to fix this.

## Haskell

The Haskell code ordering the authors is as follows:

    getAboutR :: Handler Html
    getAboutR = do
        (authors :: [Entity Author]) <- runDB $ selectList [] [Desc AuthorName]

As you can see, the ordering of the `AuthorName` is `Desc` (descending).

## Ruby

The Ruby code ordering the authors is as follows:

    get "/about" do
      @authors = Author.all.order(name: :desc)
      erb :about
    end

The `name:` is ordered `:desc`.

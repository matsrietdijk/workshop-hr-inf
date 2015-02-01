# Assignment 3 - Count author's articles

All authors have written 10 articles. These numbers are not yet shown in the [about](http://0.0.0.0:4567/about) page. The customer wants the number of articles of each author behind their name.

## Haskell

The about page is handled in the `getAboutR` function. In the function, the authors and articles are fetched from the database.

    (authors :: [Entity Author]) <- runDB $ selectList [] [Desc AuthorName]
    (articles :: [Entity Article]) <- runDB $ selectList [] []

Your coworker also has written a count function that count all articles of an author:

    count articles authorid = length $ filter (\(Entity _ x) -> articleAuthorId x == authorid) articles

But he has forgotten to actually use the count function in the HTML template `about.hamlet` view. Use the `count` function with the `articles` and `authorId` variables to display the number of articles of each author.

## Ruby

The `get "/about"` function call handles the about page. Inside this function the authors are fetched from the database with the following line:

    @authors = Author.all.order(name: :desc)

The `author` model already has a function build in to get all articles for an author. This function is called `articles` and should be performed on an `author` object. The result of the `articles` function is an array containing the articles, to count the number of articles the `count` function should be used on this array. All those function calls can be done inside the template, so the handler doesn't have to be changed.

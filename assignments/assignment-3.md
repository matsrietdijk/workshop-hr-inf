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

To be added

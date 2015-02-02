# Assignment 5 - Implement route

The customer wants a page that shows his first name when he types it in the URL bar. Its up to you to make it happen.

## Haskell

In Haskell, this is done by adding a route element that is handled by a `Handler`. There are certain routes predefined in `app.hs`:

    mkYesod "App" [parseRoutes|
    /             HomeR       GET
    /task/#Int    AssignmentR GET
    |]

The `/task/#Int` route is to show the assignments. It accepts a number. When you go to `/task/1` it loads up assignment 1. You can also make a route accept text by using `#Text`.

Create a `GET` route `/name` that accepts some text that is handled in `NameR`.

After you create the route, it needs to be handled in a function called `getNameR`. The `getNameR` function will receive the text as a parameter. A HTML template view has already been created `name.hamlet`. Use the following code to use the HTML template:

    defaultLayout $(whamletFile "views/name.hamlet")

The `getAssignmentR` function can be used as inspiration for parameter handling. The following section has a `getPersonR` function that does something similar: [http://www.yesodweb.com/book/routing-and-handlers#routing-and-handlers_arguments](http://www.yesodweb.com/book/routing-and-handlers#routing-and-handlers_arguments)

## Ruby

In Ruby this can be achieved by adding a `get` block within the class `App`. The `get "/task/:id"` route is used to show all assignments. When navigating to `/task/1` the first assignments is loaded. This same approach can be used for ready a name from an url.

Create `get` block for the `name` route which accepts a name as a parameter. A template has already been made to display the this name. To use this template add the following line to the bottom of the new handler block:

    erb :name

The `get "/task/:id"` block can be used as inspiration for parameter handling. The following section in the `sinatra` documentation shows how to handle parameters: [http://www.sinatrarb.com/intro.html#Accessing%20Variables%20in%20Templates](http://www.sinatrarb.com/intro.html#Accessing%20Variables%20in%20Templates)

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import Yesod
import Data.Text

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

instance Yesod App

getHomeR :: Handler Html
getHomeR = do
    -- render the template file "views/index.hamlet"
    defaultLayout $(whamletFile "views/index.hamlet")
  where
    -- the function "title" returning the text "Hello World!"
    title :: Text
    title = "Hello World!"

main :: IO ()
main = warp 3000 App

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Yesod
import Data.Text
import Database.Persist
import Database.Persist.Sqlite

data App = App
           { connPool :: PersistConfigPool SqliteConf
           , persistConfig :: SqliteConf
           }

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Author
    name Text

Article
    title Text
    content Textarea
    authorId AuthorId
|]

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

instance Yesod App

instance YesodPersist App where
    type YesodPersistBackend App = SqlBackend
    runDB = defaultRunDB persistConfig connPool

getHomeR :: Handler Html
getHomeR = do
    -- render the template file "views/index.hamlet"
    defaultLayout $(whamletFile "views/index.hamlet")
  where
    -- the function "title" returning the text "Hello World!"
    title = "Hello World!" :: Text

main :: IO ()
main = do
    pool <- createPoolConfig sqlConf
    runPool sqlConf (runMigration migrateAll) pool
    warp 3000 App
              { connPool = pool
              , persistConfig = sqlConf
              }
  where sqlConf = SqliteConf "workshop.sqlite3" 1

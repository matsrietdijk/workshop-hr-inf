{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ViewPatterns #-}

import System.Directory                   (doesFileExist)
import Yesod
import Yesod.Static
import Text.Hamlet                        (hamletFile)
import Text.Markdown
import qualified Data.Text.Lazy.IO as TIO (readFile)
import ClassyPrelude
import Data.Text (Text)
import Data.Int
import Database.Persist
import Database.Persist.Sqlite

$(staticFiles "../static")

data App = App
           { connPool :: PersistConfigPool SqliteConf
           , persistConfig :: SqliteConf
           , getStatic :: Static
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
/static       StaticR     Static getStatic
/             HomeR       GET
/task/#Int    AssignmentR GET
/about        AboutR      GET
|]

instance Yesod App where
    defaultLayout widget = do
        p <- widgetToPageContent $ do
            addStylesheet $ StaticR css_bootstrap_css
            addStylesheet $ StaticR css_app_css
            widget
        withUrlRenderer $(hamletFile "views/layout.hamlet")

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

getAssignmentR :: Int -> Handler Html
getAssignmentR num = do
  contentRaw <- liftIO $ TIO.readFile $ "../assignments/assignment-" ++ (show num) ++ ".md"
  let md = markdown def contentRaw
  defaultLayout $(whamletFile "views/assignment.hamlet")

getAboutR :: Handler Html
getAboutR = do
    (authors :: [Entity Author]) <- runDB $ selectList [] [Desc AuthorName]
    (articles :: [Entity Article]) <- runDB $ selectList [] []
    defaultLayout $(whamletFile "views/about.hamlet")
    where
      count articles authorid = length $ filter (\(Entity _ x) -> articleAuthorId x == authorid) articles

main :: IO ()
main = do
    db <- doesFileExist "workshop.sqlite3"
    pool <- createPoolConfig sqlConf
    s <- static "../static"
    -- let runAll = mapM_ (flip runSqlPool pool)
    let runDB = flip runSqlPool pool
    runDB $ runMigration migrateAll
    case db of
      True  -> return ()
      False -> runDB $ runSeed 3 10

    warp 4567 App
              { connPool = pool
              , persistConfig = sqlConf
              , getStatic = s
              }
  where sqlConf = SqliteConf "workshop.sqlite3" 1
        runSeed authors articles = do
            mapM_ (insert_ . Author . (<>) "Author " . tshow) [1..authors]
            mapM_ (\(a, b) -> insert_ $ Article
                                            ("Article " <> tshow a <> "." <> tshow b)
                                            (Textarea "Lorem ipsum")
                                            (toSqlKey a)) [(a, b)| a <- [1..authors], b <-[1..articles]]

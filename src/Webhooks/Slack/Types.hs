{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Webhooks.Slack.Types
       (--FromSlack
      ToSlack(..)
      , Channel(..)
      , EMOJI(..)
      , BotName(..)
--      , Icon(..)
       ,Token(..)
       ) where

import           Webhooks.Slack.Emoji
import           Data.Text (Text)
import           Data.Aeson
import           Data.Maybe (catMaybes)

-- | Username can be anything
newtype BotName = BotName Text deriving (Show, ToJSON)

-- | Channel is `#mychan` or `@user`
--
-- In the future can be:
-- data Channel = HashChannel | DirectMessage
newtype Channel = Channel Text deriving (Show, ToJSON)

-- | meh
newtype Url = Url Text deriving (Show, ToJSON)

--data Icon = Icon Url | Emoji EMOJI deriving Show

data ToSlack = ToSlack { text     :: Text
                       , channel  :: Maybe Channel
                       , username :: Maybe BotName
                       , icon_emoji :: Maybe EMOJI
                       , icon_url :: Maybe Url
 } deriving Show

mField :: (ToJSON a, Functor f) => Text -> f a -> f (Text, Value)
mField field = fmap ((field .=) . toJSON)

instance ToJSON ToSlack where
  toJSON (ToSlack t mc mu mie miu) =
    object conjoined
    where base = ["text" .= t]
          maybeAdd =
            catMaybes [ mField "channel" mc
                      , mField "username" mu
                      , mField "icon_emoji" mie
                      , mField "icon_url" miu ]
          conjoined = base ++ maybeAdd

-- | Slack Token
newtype Token = Token Text deriving Show

module Webhooks.Slack.Types
       (--FromSlack
      ToSlack(..)
      , Channel(..)
      , EMOJI(..)
      , BotName(..)
      , Icon(..)
       ,Token(..)
       ) where

import           Webhooks.Slack.Emoji
import           Data.Text (Text)

-- | Username can be anything
newtype BotName = BotName Text deriving Show

-- | Channel is `#mychan` or `@user`
--
-- In the future can be:
-- data Channel = HashChannel | DirectMessage
newtype Channel = Channel Text deriving Show

-- | meh
newtype Url = Url Text deriving Show

data Icon = Icon Url | Emoji EMOJI deriving Show

data ToSlack = ToSlack { text     :: Text
                       , channel  :: Maybe Channel
                       , username :: Maybe BotName
                       , icon     :: Maybe Icon } deriving Show

-- | Slack Token
newtype Token = Token Text deriving Show

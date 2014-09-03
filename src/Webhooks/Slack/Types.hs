module Webhooks.Slack.Types
       (FromSlack
       ,ToSlack
       ,Token
       ) where

import           Webhooks.Slack.Emoji

-- | Username can be anything
type Username = Text

-- | Channel is `#mychan` or `@user`
--
-- In the future can be:
-- data Channel = HashChannel | DirectMessage
type Channel = Text

-- | meh
type URL = Text

data Icon = URL | Emoji

data ToSlack = ToSlack { text     :: Text
                       , channel  :: Maybe Channel
                       , username :: Maybe Username
                       , icon     :: Maybe Icon }

-- | Slack Token
data Token = Text

{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
module Webhooks.Docker.Hub.Types
  ( FromHub(..)
  , Repository(..)
  , PushData(..)
  , Username(..)) where

import Data.Text (Text)
--import Data.Time (UTCTime)
import Data.Aeson
import Control.Applicative ((<$>),(<*>))

data FromHub = FromHub
  { push_data :: PushData
  , callback_url :: Text
  , repository :: Repository }

instance FromJSON FromHub where
  parseJSON (Object o) = FromHub
    <$> o .: "push_data"
    <*> o .: "callback_url"
    <*> o .: "repository"

newtype Username = Username Text deriving (Show, FromJSON)

data PushData = PushData
  { pushed_at :: Int --UTCTime
  , images :: [Text]
  , pusher :: Username }

instance FromJSON PushData where
  parseJSON (Object o) = PushData
    <$> o .: "pushed_at"
    <*> o .: "images"
    <*> o .: "pusher"

data Repository = Repository
  { status :: Text -- ^ Enum?
  , description :: Text
  , is_trusted :: Bool
  , full_description :: Maybe Text
  , repo_url :: Text
  , owner :: Username
  , is_official :: Bool
  , is_private :: Bool
  , name :: Text
  , namespace :: Text
  , star_count :: Int
  , comment_count :: Int
  , date_created :: Int --UTCTime
  , dockerfile :: Text
  , repo_name :: Text }

instance FromJSON Repository where
  parseJSON (Object o) = Repository
    <$> o .: "status"
    <*> o .: "description"
    <*> o .: "is_trusted"
    <*> o .:? "full_description"
    <*> o .: "repo_url"
    <*> o .: "owner"
    <*> o .: "is_official"
    <*> o .: "is_private"
    <*> o .: "name"
    <*> o .: "namespace"
    <*> o .: "star_count"
    <*> o .: "comment_count"
    <*> o .: "date_created"
    <*> o .: "dockerfile"
    <*> o .: "repo_name"

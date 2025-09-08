module TestcontainersPostgresql.Configs.Auth where

import Data.Function
import Data.Text (Text)
import qualified Data.Text as Text
import qualified TestContainers
import Prelude

data Auth
  = TrustAuth
  | CredentialsAuth
      -- | User.
      Text
      -- | Password.
      Text
  deriving stock (Show, Eq)

updateContainerRequest :: Auth -> TestContainers.ContainerRequest -> TestContainers.ContainerRequest
updateContainerRequest = TestContainers.setEnv . toEnvs

toEnvs :: Auth -> [(Text, Text)]
toEnvs = \case
  TrustAuth ->
    [ ("POSTGRES_HOST_AUTH_METHOD", "trust")
    ]
  CredentialsAuth user password ->
    [ ("POSTGRES_USER", prepareValue user),
      ("POSTGRES_PASSWORD", prepareValue password)
    ]
  where
    prepareValue :: Text -> Text
    prepareValue =
      Text.concatMap
        ( \case
            '\'' -> "\\'"
            '\\' -> "\\\\"
            c -> Text.singleton c
        )

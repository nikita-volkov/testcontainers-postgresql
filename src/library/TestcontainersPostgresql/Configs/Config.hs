module TestcontainersPostgresql.Configs.Config where

import Data.Function
import Data.Text (Text)
import qualified Data.Text.Lazy as Text.Lazy
import qualified TestContainers
import qualified TestcontainersPostgresql.Configs.Auth as Configs.Auth
import Prelude

data Config = Config
  { forwardLogs :: Bool,
    tagName :: Text,
    auth :: Configs.Auth.Auth
  }

toContainerRequest :: Config -> TestContainers.ContainerRequest
toContainerRequest (Config forwardLogs tagName auth) =
  TestContainers.fromTag tagName
    & TestContainers.containerRequest
    & TestContainers.setExpose [5432]
    & TestContainers.setWaitingFor waitUntilReady
    & Configs.Auth.updateContainerRequest auth
    & (if forwardLogs then TestContainers.withFollowLogs TestContainers.consoleLogConsumer else id)
  where
    waitUntilReady :: TestContainers.WaitUntilReady
    waitUntilReady =
      mconcat
        [ TestContainers.waitForLogLine TestContainers.Stderr (Text.Lazy.isInfixOf "database system is ready to accept connections"),
          TestContainers.waitUntilMappedPortReachable 5432
        ]

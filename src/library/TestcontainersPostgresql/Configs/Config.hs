module TestcontainersPostgresql.Configs.Config where

import Data.Function
import Data.Text (Text)
import qualified Data.Text.Lazy as Text.Lazy
import qualified TestContainers
import qualified TestContainers.Hspec
import qualified TestcontainersPostgresql.Configs.Distro as Configs.Distro
import Prelude

data Config = Config
  { forwardLogs :: Bool,
    distro :: Configs.Distro.Distro
  }

toContainerRequest :: Config -> TestContainers.ContainerRequest
toContainerRequest (Config forwardLogs distro) =
  Configs.Distro.toContainerRequest distro
    & TestContainers.setExpose [5432]
    & TestContainers.setWaitingFor waitUntilReady
    & TestContainers.setEnv [("POSTGRES_HOST_AUTH_METHOD", "trust")]
    & (if forwardLogs then TestContainers.withFollowLogs TestContainers.consoleLogConsumer else id)
  where
    waitUntilReady :: TestContainers.WaitUntilReady
    waitUntilReady =
      mconcat
        [ TestContainers.waitForLogLine TestContainers.Stderr (Text.Lazy.isInfixOf "database system is ready to accept connections"),
          TestContainers.waitUntilMappedPortReachable 5432
        ]

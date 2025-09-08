module TestcontainersPostgresql
  ( Configs.Config.Config (..),
    Configs.Distro.Distro (..),
    run,
  )
where

import Data.Function
import Data.Text (Text)
import qualified Data.Text.Lazy as Text.Lazy
import qualified TestContainers
import qualified TestContainers.Hspec
import qualified TestcontainersPostgresql.Configs.Config as Configs.Config
import qualified TestcontainersPostgresql.Configs.Distro as Configs.Distro
import Prelude

setup :: (TestContainers.MonadDocker m) => Configs.Config.Config -> m (Text, Int)
setup config = do
  container <- TestContainers.run (Configs.Config.toContainerRequest config)
  pure $ TestContainers.containerAddress container 5432

-- | Run a session on a PostgreSQL container on the scope of a host and a port.
run :: Configs.Config.Config -> ((Text, Int) -> IO ()) -> IO ()
run config = do
  TestContainers.Hspec.withContainers (setup config)

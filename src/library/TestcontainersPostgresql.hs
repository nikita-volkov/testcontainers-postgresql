module TestcontainersPostgresql
  ( Configs.Config.Config (..),
    Configs.Auth.Auth (..),
    run,
    setup,
  )
where

import Data.Function
import Data.Text (Text)
import Data.Word (Word16)
import qualified TestContainers
import qualified TestContainers.Hspec
import qualified TestcontainersPostgresql.Configs.Auth as Configs.Auth
import qualified TestcontainersPostgresql.Configs.Config as Configs.Config
import Prelude

setup :: (TestContainers.MonadDocker m) => Configs.Config.Config -> m (Text, Word16)
setup config = do
  container <- TestContainers.run (Configs.Config.toContainerRequest config)
  let (host, port) = TestContainers.containerAddress container 5432
  pure (host, fromIntegral port)

-- | Run a session on a PostgreSQL container in the scope of a host and a port.
run :: Configs.Config.Config -> ((Text, Word16) -> IO ()) -> IO ()
run config = do
  TestContainers.Hspec.withContainers (setup config)

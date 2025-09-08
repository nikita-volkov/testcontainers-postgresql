module TestcontainersPostgresql.Configs.Distro where

import Data.Function
import Data.Text (Text)
import qualified Data.Text.Lazy as Text.Lazy
import qualified TestContainers
import qualified TestContainers.Hspec
import Prelude

data Distro
  = Distro17
  | Distro9
  deriving stock (Show, Eq)

toTag :: Distro -> Text
toTag Distro17 = "postgres:17"
toTag Distro9 = "postgres:9"

toToImage :: Distro -> TestContainers.ToImage
toToImage = TestContainers.fromTag . toTag

toContainerRequest :: Distro -> TestContainers.ContainerRequest
toContainerRequest = TestContainers.containerRequest . toToImage

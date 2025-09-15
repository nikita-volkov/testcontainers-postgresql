module TestcontainersPostgresql.Configs.Distro where

import Data.Function
import Data.Text (Text)
import qualified TestContainers
import Prelude

data Distro
  = Distro8
  | Distro9
  | Distro10
  | Distro11
  | Distro12
  | Distro13
  | Distro14
  | Distro15
  | Distro16
  | Distro17
  | Distro18
  deriving stock (Show, Eq, Enum, Bounded)

toTag :: Distro -> Text
toTag = \case
  Distro8 -> "postgres:8"
  Distro9 -> "postgres:9"
  Distro10 -> "postgres:10"
  Distro11 -> "postgres:11"
  Distro12 -> "postgres:12"
  Distro13 -> "postgres:13"
  Distro14 -> "postgres:14"
  Distro15 -> "postgres:15"
  Distro16 -> "postgres:16"
  Distro17 -> "postgres:17"
  Distro18 -> "postgres:18"

toToImage :: Distro -> TestContainers.ToImage
toToImage = TestContainers.fromTag . toTag

toContainerRequest :: Distro -> TestContainers.ContainerRequest
toContainerRequest = TestContainers.containerRequest . toToImage

# testcontainers-postgresql

[![Hackage](https://img.shields.io/hackage/v/testcontainers-postgresql.svg)](https://hackage.haskell.org/package/testcontainers-postgresql)
[![Continuous Haddock](https://img.shields.io/badge/haddock-master-blue)](https://nikita-volkov.github.io/testcontainers-postgresql/)

A Haskell library providing Testcontainers integration for PostgreSQL databases. This library simplifies running PostgreSQL containers for testing purposes, with support for various PostgreSQL versions and authentication methods.

## Features

- **Multiple PostgreSQL Versions**: Support for PostgreSQL versions 9 through 17
- **Flexible Authentication**: Choose between trust-based authentication or username/password credentials
- **Log Forwarding**: Optional log forwarding to the console for debugging

## Quick Start

```haskell
import TestcontainersPostgresql
import TestcontainersPostgresql.Configs.Config
import TestcontainersPostgresql.Configs.Distro
import TestcontainersPostgresql.Configs.Auth

main :: IO ()
main = do
  let config = Config
        { forwardLogs = True
        , distro = Distro16  -- PostgreSQL 16
        , auth = TrustAuth   -- Trust-based authentication
        }

  run config $ \(host, port) -> do
    putStrLn $ "PostgreSQL is running at " ++ show host ++ ":" ++ show port
    -- Your test code here
    -- Connect to PostgreSQL using host and port
```

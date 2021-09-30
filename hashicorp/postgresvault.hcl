job "PostgreVault" {
    datacenters = ["dc1"]
    type = "service"

    group "database"{
        count = 1

        
        
        volume "postgres" {
            type      = "host"
            read_only = false
            source    = "postgres"
        }


        network {
            port "db"{
                static = "5432"
            }
        }
        
        task "postgres"{
            driver = "docker"
            
            vault {
                policies = ["psql"]
                change_mode   = "signal"
                change_signal = "SIGUSR1"
            }

            volume_mount {
                volume      = "postgres"
                destination = "/var/lib/postgresql/data"
                read_only   = false
            }

            config {
                image = "postgres:latest"
                ports = ["db"]
              
            }

            template {
                data = <<EOF
            POSTGRES_USER="{{ with secret "env/psql" }}{{ .Data.username}}{{end}}"
            POSTGRES_PASSWORD="{{ with secret "env/psql" }}{{ .Data.password}}{{end}}"
            EOF
                destination = "secrets/file.env"

            }


            service {
                name = "postgres-teste"
                port = "db"
            }

        }
    }
}
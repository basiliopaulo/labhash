job "PostgreSQL" {
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
            
            volume_mount {
                volume      = "postgres"
                destination = "/var/lib/postgresql/data"
                read_only   = false
            }

            config {
                image = "postgres:latest"
                ports = ["db"]
            }

            
            service {
                name = "postgres-teste"
                port = "db"
            }

        }
    }
}
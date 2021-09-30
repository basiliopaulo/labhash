client {
  enabled = true
  servers = ["127.0.0.1:4646"]
  host_volume "postgres" {
    path      = "/opt/postgres/data"
    read_only = false
  }
}
plugin "docker" {
  config {
    volumes {
      enabled      = true
      selinuxlabel = "z"
    }
  }
}
vault {
  enabled = true
  address = "http://192.168.72.108:8200"
}

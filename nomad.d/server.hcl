server {
  # license_path is required as of Nomad v1.1.1+
  #license_path = "/etc/nomad.d/nomad.hcl"
  enabled = true
  bootstrap_expect = 1
}

vault {
  enabled = true
  address = "http://192.168.72.108:8200"
  task_token_ttl = "1h"
  create_from_role = "nomad-cluster"
  token = "s.ApR6F0BfimvBkvdjJYOqaGxy"
}
# === VERSION ===
#
default.elasticsearch[:version]       = "0.20.1"
default.elasticsearch[:checksum]      = "9396dcff279c2d1c33582eb65e05ee93112bbe3a4c0833b89ecbe228b2650990"
default.elasticsearch[:repository]    = "elasticsearch/elasticsearch"
default.elasticsearch[:filename]      = "elasticsearch-#{node.elasticsearch[:version]}.tar.gz"
default.elasticsearch[:download_url]  = "https://github.com/downloads/" +
                                        "#{node.elasticsearch[:repository]}/#{node.elasticsearch[:filename]}"

# === USER & PATHS
#
default.elasticsearch[:dir]       = "/usr/local"
default.elasticsearch[:user]      = "elasticsearch"
default.elasticsearch[:group]     = "elasticsearch"
default.elasticsearch[:conf_path] = "#{node.elasticsearch[:dir]}/etc/elasticsearch"
default.elasticsearch[:data_path] = "#{node.elasticsearch[:dir]}/var/data/elasticsearch"
default.elasticsearch[:log_path]  = "#{node.elasticsearch[:dir]}/var/log/elasticsearch"
default.elasticsearch[:pid_path]  = "#{node.elasticsearch[:dir]}/var/run/elasticsearch"

# === MEMORY ===
#
# Maximum amount of memory to use is automatically computed as a bit over 1/2 of total available memory on the machine.
# You may choose to set it in your node/role configuration instead.
# By default, the `mlockall` is set to true: on weak machines and Vagrant boxes, you may want to disable it.
#
allocated_memory = "#{(node.memory.total.to_i * 0.6 ).floor / 1024}m"
default.elasticsearch[:allocated_memory] = allocated_memory
default.elasticsearch[:mlockall] = true

# === LIMITS ===
#
default.elasticsearch[:limits]  = {}
default.elasticsearch[:limits][:memlock] = 'unlimited'
default.elasticsearch[:limits][:nofile]  = '64000'

# === PERSISTENCE ===
#
default.elasticsearch[:gateway][:type] = nil

# === VARIA ===
#
default.elasticsearch[:index_auto_create_index] = true
default.elasticsearch[:index_mapper_dynamic]    = true
default.elasticsearch[:disable_delete_all_indices] = true
default.elasticsearch[:thread_stack_size]       = "256k"

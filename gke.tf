resource "google_container_cluster" "primary"{
    name= "test-cluster"
    location= var.region
    network= google_compute_network.vpc_network.id
    subnetwork= google_compute_subnetwork.vpc_subnet.id

    remove_default_node_pool= true
    initial_node_count= 1
}

resource "google_container_node_pool" "primary_nodes" {
    name= "test-pool"
    location= var.location
    cluster= google_container_cluster.primary.name

    node_config {
        machine_type= "e2-standard-2"

        oauth_scopes= [
            "https://www.googleapis.com/auth/cloud-platform",
        ]
    }

    initial_node_count= 3
}
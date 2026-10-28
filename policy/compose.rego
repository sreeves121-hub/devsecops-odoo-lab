package main

import rego.v1

deny contains msg if {
	some name, svc in input.services
	svc.privileged == true
	msg := sprintf("compose service '%s' runs privileged", [name])
}

deny contains msg if {
	some name, svc in input.services
	svc.network_mode == "host"
	msg := sprintf("compose service '%s' uses host networking", [name])
}

deny contains msg if {
	some name, svc in input.services
	some port in svc.ports
	is_string(port)
	not startswith(port, "127.0.0.1:")
	msg := sprintf("compose service '%s' publishes '%s' on all interfaces; bind to 127.0.0.1", [name, port])
}

deny contains msg if {
	some name, svc in input.services
	endswith(svc.image, ":latest")
	msg := sprintf("compose service '%s' uses the :latest tag", [name])
}

# Not a hard failure, but worth a conversation: the Docker socket gives root-equivalent access to the host.
warn contains msg if {
	some name, svc in input.services
	some vol in svc.volumes
	is_string(vol)
	contains(vol, "docker.sock")
	msg := sprintf("compose service '%s' mounts the Docker socket (read-only still exposes the API)", [name])
}

package main

import rego.v1

workload_kinds := {"Deployment", "StatefulSet", "DaemonSet"}

deny contains msg if {
	input.kind in workload_kinds
	some c in input.spec.template.spec.containers
	endswith(c.image, ":latest")
	msg := sprintf("%s/%s: container '%s' uses the :latest tag", [input.kind, input.metadata.name, c.name])
}

deny contains msg if {
	input.kind in workload_kinds
	some c in input.spec.template.spec.containers
	c.securityContext.privileged == true
	msg := sprintf("%s/%s: container '%s' runs privileged", [input.kind, input.metadata.name, c.name])
}

deny contains msg if {
	input.kind in workload_kinds
	some c in input.spec.template.spec.containers
	not c.securityContext.allowPrivilegeEscalation == false
	msg := sprintf("%s/%s: container '%s' must set allowPrivilegeEscalation: false", [input.kind, input.metadata.name, c.name])
}

deny contains msg if {
	input.kind in workload_kinds
	some c in input.spec.template.spec.containers
	not "ALL" in c.securityContext.capabilities.drop
	msg := sprintf("%s/%s: container '%s' must drop ALL capabilities", [input.kind, input.metadata.name, c.name])
}

deny contains msg if {
	input.kind in workload_kinds
	not input.spec.template.spec.securityContext.runAsNonRoot == true
	msg := sprintf("%s/%s: pod must set runAsNonRoot: true", [input.kind, input.metadata.name])
}

deny contains msg if {
	input.kind in workload_kinds
	some c in input.spec.template.spec.containers
	not c.resources.limits.memory
	msg := sprintf("%s/%s: container '%s' has no memory limit", [input.kind, input.metadata.name, c.name])
}

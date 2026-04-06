# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::kubernetes::minikube()
#
#  Environment:	 MINIKUBE_ACTIVE_DOCKERD
#>
######################################################################
p6df::modules::kubernetes::minikube() {

  p6_run_code "$(p6_run_code minikube -p minikube docker-env)"
  p6df::modules::kubernetes::ctx "$MINIKUBE_ACTIVE_DOCKERD"
  p6df::modules::kubernetes::ns "default"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::minikube::start()
#
#>
######################################################################
p6df::modules::kubernetes::minikube::start() {

  p6_run_code "minikube start"

  p6df::modules::kubernetes::minikube

  p6_return_void
}

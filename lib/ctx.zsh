# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::kubernetes::on()
#
#  Environment:	 HOME KUBECONFIG
#>
######################################################################
p6df::modules::kubernetes::on() {

  KUBECONFIG="$HOME"/.kube/config
  p6_file_chmod "600" "$KUBECONFIG"
  p6_env_export "KUBECONFIG" "$KUBECONFIG"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::off()
#
#  Environment:	 KUBECONFIG P6_KUBE_CFG P6_KUBE_NS
#>
######################################################################
p6df::modules::kubernetes::off() {

  p6_env_export_un "KUBECONFIG"
  p6_env_export_un "P6_KUBE_CFG"
  p6_env_export_un "P6_KUBE_NS"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::ctx(ctx)
#
#  Args:
#	ctx -
#
#  Environment:	 P6_KUBE_CFG
#>
######################################################################
p6df::modules::kubernetes::ctx() {
  local ctx="$1"

  p6_run_code "kubectx $ctx"

  p6_env_export "P6_KUBE_CFG" "$ctx"

  p6df::modules::kubernetes::on

  p6_return_void
}

######################################################################
#<
#
# Function: str ctx = p6df::modules::kubernetes::ctx::get()
#
#  Returns:
#	str - ctx
#
#>
######################################################################
p6df::modules::kubernetes::ctx::get() {

  local ctx=$(p6_run_code "kubectx -c")

  p6_return_str "$ctx"
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::ns(ns)
#
#  Args:
#	ns -
#
#  Environment:	 P6_KUBE_NS
#>
######################################################################
p6df::modules::kubernetes::ns() {
  local ns="$1"

  p6_run_code "kubens $ns"

  p6_env_export "P6_KUBE_NS" "$ns"

  p6_return_void
}

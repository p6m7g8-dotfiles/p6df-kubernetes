# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::kubernetes::deps()
#
#>
######################################################################
p6df::modules::kubernetes::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-zsh
    p6m7g8-dotfiles/p6kubernetes
    ohmyzsh/ohmyzsh:plugins/kubectl
  )
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::vscodes()
#
#>
######################################################################
p6df::modules::kubernetes::vscodes() {

  # kubernetes
  code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
  code --install-extension ipedrazas.kubernetes-snippets

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::external::brew()
#
#>
######################################################################
p6df::modules::kubernetes::external::brew() {

  p6df::modules::homebrew::cli::brew::install buildkit

  p6df::modules::homebrew::cli::brew::install kind

  p6df::modules::homebrew::cli::brew::install kubebuilder
  p6df::modules::homebrew::cli::brew::install kubecfg
  p6df::modules::homebrew::cli::brew::install kubectx
  p6df::modules::homebrew::cli::brew::install kubeseal
  p6df::modules::homebrew::cli::brew::install kubespy
  p6df::modules::homebrew::cli::brew::install minikube

  p6df::modules::homebrew::cli::brew::install --cask kubecontext
  p6df::modules::homebrew::cli::brew::install --cask kubernetic

  sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
  sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::prompt::line()
#
#>
######################################################################
p6df::modules::kubernetes::prompt::line() {

  p6_kubernetes_prompt_info
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::on()
#
#  Environment:	 KUBECONFIG
#>
######################################################################
p6df::modules::kubernetes::on() {

  KUBECONFIG=$HOME/.kube/config
  chmod 600 $KUBECONFIG
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

######################################################################
#<
#
# Function: p6df::modules::kubernetes::minikube()
#
#  Environment:	 MINIKUBE_ACTIVE_DOCKERD
#>
######################################################################
p6df::modules::kubernetes::minikube() {

  p6_run_code $(p6_run_code minikube -p minikube docker-env)
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

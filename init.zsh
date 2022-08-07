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
  code --install-extension ipedrazas.kubernetes-snippets
  code --install-extension ms-vscode-remote.remote-containers
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::external::brew()
#
#>
######################################################################
p6df::modules::kubernetes::external::brew() {

  brew install buildkit

  brew install kind

  brew install kubeaudit
  brew install kubebuilder
  brew install kubecfg
  brew install kubectx
  brew install kubeseal
  brew install kubespy
  brew install minikube

  brew install --cask kube-forwarder
  brew install --cask kubecontext
  brew install --cask kubernetic

  sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
  sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
  brew install --cask minishift
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::init()
#
#>
######################################################################
p6df::modules::kubernetes::init() {

  p6df::modules::kubernetes::prompt::init
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::prompt::init()
#
#>
######################################################################
p6df::modules::kubernetes::prompt::init() {

  p6df::core::prompt::line::add "p6df::modules::kubernetes::prompt::line"
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
}

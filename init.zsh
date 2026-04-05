# shellcheck shell=bash
######################################################################
p6df::modules::kubernetes::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-zsh
    p6m7g8-dotfiles/p6kubernetes
    ohmyzsh/ohmyzsh:plugins/kubectl
    ahmedasmar/devops-claude-skills:k8s-troubleshooter
    geored/sre-skill
    rohitg00/awesome-claude-code-toolkit:plugins/k8s-helper
  )
}

######################################################################
p6df::modules::kubernetes::home::symlinks() {

  p6_file_symlink "$P6_DFZ_SRC_DIR/ahmedasmar/devops-claude-skills/k8s-troubleshooter/skills"                                "$HOME/.claude/skills/k8s-troubleshooter"
  p6_file_symlink "$P6_DFZ_SRC_DIR/geored/sre-skill/debugging-kubernetes-incidents"                                          "$HOME/.claude/skills/debugging-kubernetes-incidents"
  p6_file_symlink "$P6_DFZ_SRC_DIR/akin-ozer/cc-devops-skills/devops-skills-plugin/skills/k8s-debug"                         "$HOME/.claude/skills/k8s-debug"
  p6_file_symlink "$P6_DFZ_SRC_DIR/akin-ozer/cc-devops-skills/devops-skills-plugin/skills/k8s-yaml-generator"                "$HOME/.claude/skills/k8s-yaml-generator"
  p6_file_symlink "$P6_DFZ_SRC_DIR/akin-ozer/cc-devops-skills/devops-skills-plugin/skills/k8s-yaml-validator"                "$HOME/.claude/skills/k8s-yaml-validator"

  p6_return_void
}

######################################################################
p6df::modules::kubernetes::external::brews() {

  p6df::core::homebrew::cli::brew::install buildkit

  p6df::core::homebrew::cli::brew::install kind

  p6df::core::homebrew::cli::brew::install kubebuilder
  p6df::core::homebrew::cli::brew::install kubecfg
  p6df::core::homebrew::cli::brew::install kubectx
  p6df::core::homebrew::cli::brew::install kubeseal
  p6df::core::homebrew::cli::brew::install kubespy
  p6df::core::homebrew::cli::brew::install minikube

  p6df::core::homebrew::cli::brew::install --cask kubecontext
  p6df::core::homebrew::cli::brew::install --cask kubernetic

  sudo chown root:wheel "$(brew --prefix)"/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
  sudo chmod u+s "$(brew --prefix)"/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

  p6_return_void
}

######################################################################
p6df::modules::kubernetes::mcp() {

  p6df::core::homebrew::cli::brew::install kubernetes-mcp-server

  p6df::modules::anthropic::mcp::server::add "kubernetes" "kubernetes-mcp-server"
  p6df::modules::openai::mcp::server::add "kubernetes" "kubernetes-mcp-server"

  p6_return_void
}
######################################################################
p6df::modules::kubernetes::vscodes() {

  # kubernetes
  p6df::modules::vscode::extension::install ms-kubernetes-tools.vscode-kubernetes-tools
  p6df::modules::vscode::extension::install ipedrazas.kubernetes-snippets

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::deps()
#
#>
######################################################################
#<
#
# Function: p6df::modules::kubernetes::home::symlinks()
#
#  Environment:	 HOME P6_DFZ_SRC_DIR
#>
######################################################################
#<
#
# Function: p6df::modules::kubernetes::vscodes()
#
#>
######################################################################
#<
#
# Function: p6df::modules::kubernetes::external::brews()
#
#>
######################################################################
#<
#
# Function: p6df::modules::kubernetes::prompt::context()
#
#>
######################################################################
p6df::modules::kubernetes::prompt::context() {

  p6_kubernetes_prompt_info
}

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

######################################################################
#<
#
# Function: p6df::modules::kubernetes::mcp()
#
#>

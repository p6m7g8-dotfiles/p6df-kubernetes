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
    ahmedasmar/devops-claude-skills:k8s-troubleshooter
    geored/sre-skill
    rohitg00/awesome-claude-code-toolkit:plugins/k8s-helper
  )
}

######################################################################
#<
#
# Function: p6df::modules::kubernetes::home::symlinks()
#
#  Environment:	 HOME P6_DFZ_SRC_DIR
#>
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
#<
#
# Function: p6df::modules::kubernetes::external::brews()
#
#>
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
#<
#
# Function: p6df::modules::kubernetes::mcp()
#
#>
######################################################################
p6df::modules::kubernetes::mcp() {

  p6df::core::homebrew::cli::brew::install kubernetes-mcp-server

  p6df::modules::anthropic::mcp::server::add "kubernetes" "kubernetes-mcp-server"
  p6df::modules::openai::mcp::server::add "kubernetes" "kubernetes-mcp-server"

  p6_return_void
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
  p6df::modules::vscode::extension::install ms-kubernetes-tools.vscode-kubernetes-tools
  p6df::modules::vscode::extension::install ipedrazas.kubernetes-snippets

  p6_return_void
}

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



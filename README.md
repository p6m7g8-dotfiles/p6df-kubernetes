# P6's POSIX.2: p6df-kubernetes

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

TODO: Add a short summary of this module.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Functions

#### p6df-kubernetes

##### p6df-kubernetes/init.zsh

- `p6df::modules::kubernetes::deps()`
- `p6df::modules::kubernetes::external::brews()`
- `p6df::modules::kubernetes::home::symlinks()`
- `p6df::modules::kubernetes::mcp()`
- `p6df::modules::kubernetes::prompt::context()`
- `p6df::modules::kubernetes::vscodes()`

#### p6df-kubernetes/lib

##### p6df-kubernetes/lib/ctx.zsh

- `p6df::modules::kubernetes::ctx(ctx)`
  - Args:
    - ctx
- `p6df::modules::kubernetes::ns(ns)`
  - Args:
    - ns
- `p6df::modules::kubernetes::off()`
- `p6df::modules::kubernetes::on()`
- `str ctx = p6df::modules::kubernetes::ctx::get()`

##### p6df-kubernetes/lib/minikube.zsh

- `p6df::modules::kubernetes::minikube()`
- `p6df::modules::kubernetes::minikube::start()`

## Hierarchy

```text
.
├── init.zsh
├── lib
│   ├── ctx.zsh
│   └── minikube.zsh
└── README.md

2 directories, 4 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>

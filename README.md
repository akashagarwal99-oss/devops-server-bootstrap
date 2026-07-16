# DevOps Server Bootstrap

A collection of reusable installation scripts to quickly provision a fresh Ubuntu server for DevOps and Cloud Engineering projects.

## Tools Installed

- Java 21
- Git
- Docker CE
- Jenkins LTS
- AWS CLI v2
- kubectl
- Helm
- eksctl

## Repository Structure

```
scripts/
```

Contains individual installation scripts.

```
install-all.sh
```

Runs all installation scripts sequentially.

```
docs/
```

Contains setup guides and troubleshooting documentation.

## Usage

```bash
chmod +x install-all.sh
./install-all.sh
```

## Supported Operating System

- Ubuntu Server 24.04 LTS

## Author

Akash Agarwal

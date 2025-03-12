# Embedded CI Lab  
**Automated Embedded Firmware Testing with CI/CD & QEMU**  

## Overview  
Embedded CI Lab is a research-driven project focused on **automated testing and continuous integration (CI/CD) for embedded firmware**.  
By leveraging **QEMU, Jenkins, Google Test, and SonarQube**, this project aims to simulate real-world embedded software workflows and automate firmware validation.  

## Key Features  
✅ **QEMU-based Embedded Firmware Simulation** – Run firmware in a virtual environment before deployment.  
✅ **Jenkins CI/CD Pipeline** – Automate build, test, and deployment cycles.  
✅ **Google Test Integration** – Unit test framework for embedded software.  
✅ **SonarQube & Valgrind** – Code quality analysis and runtime memory validation.  
✅ **UART & File System Testing** – Simulate hardware-level interactions for firmware validation.  

## Development Roadmap  
1️⃣ **Setup Jenkins CI/CD for automated builds**  
2️⃣ **Develop firmware with UART communication & memory management**  
3️⃣ **Integrate QEMU to test firmware in a virtual environment**  
4️⃣ **Apply Google Test for unit testing and validation**  
5️⃣ **Implement SonarQube & Valgrind for code quality analysis**  

## Getting Started  
### 1. Clone the repository  
```bash
git clone https://github.com/YOUR_USERNAME/embedded-ci-lab.git
cd embedded-ci-lab
```
### 2. Set up the development environment (Jenkins, QEMU)
```bash
// Jenkins
sudo apt update && sudo apt upgrade -y

sudo apt install openjdk-17-jdk -y

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y

sudo systemctl enable --now jenkins

// QEMU
sudo apt install qemu-system qemu-utils -y
sudo apt install qemu-system-arm qemu-system-riscv64 -y
```
### 3. Run the firmware in QEMU
```bash
```

### Webhook test

**License**
This project is open-source under the MIT License.

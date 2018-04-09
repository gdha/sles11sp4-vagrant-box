vm_description='SLES 11 SP4 box meant for
Relax-and-Recover Automated Testing
https://gdha.github.io/rear-automated-testing/'

vm_version='0.0.3'

/usr/local/bin/packer build \
    -var "vm_description=${vm_description}" \
    -var "vm_version=${vm_version}"         \
    "sles11sp4.json"


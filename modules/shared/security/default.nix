{
  imports = [
    ./apparmor.nix # apparmor configuration and policies
    ./auditd.nix # auditd
    ./clamav.nix # clamav antivirus
    ./impurity-tracker.nix # find applications that depend on /bin/sh or /usr/bin/env
    ./kernel.nix # kernel hardening
    # ./memalloc.nix # memory allocator hardening
    ./pam.nix # pam configuration
    ./pki.nix # pki certificate bundles
    ./polkit.nix # polkit configuration
    ./selinux.nix # selinux support + kernel patches
    ./sudo.nix # sudo rules and configuration
    ./virtualization.nix # hypervisor hardening
    ./usbguard.nix # usbguard
  ];
}

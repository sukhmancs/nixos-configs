{
  imports = [
    ./apparmor # apparmor configuration and policies
    ./misc # bluetooth, git, machine-id, securetty, and issue configuration

    ./auditd.nix # auditd
    #./clamav.nix # clamav antivirus
    ./coredump.nix # coredump hardening
    ./entropy.nix # entropy gathering
    ./impurity-tracker.nix # find applications that depend on /bin/sh or /usr/bin/env
    ./kernel.nix # kernel hardening
    ./network.nix # network hardening
    ./nix.nix # nix command hardening
    # ./memalloc.nix # memory allocator hardening
    ./ids.nix # intrusion detection system
    ./pam.nix # pam configuration
    ./pki.nix # pki certificate bundles
    ./polkit.nix # polkit configuration
    ./selinux.nix # selinux support + kernel patches
    ./sudo.nix # sudo rules and configuration
    ./systemd-boot.nix # systemd-boot loader hardening
    ./virtualization.nix # hypervisor hardening
    ./usbguard.nix # usbguard
  ];
}

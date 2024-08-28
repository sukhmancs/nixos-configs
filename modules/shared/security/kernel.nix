{
  lib,
  config,
  ...
}: {
  boot = {
    kernel = {
      sysctl = {
        # Unprivileged userns has a large attack surface and has been the cause
        # of many privilege escalation vulnerabilities, but can cause breakage.
        # See overrides.
        "kernel.unprivileged_userns_clone" = "0";

        # Yama restricts ptrace, which allows processes to read and modify the
        # memory of other processes. This has obvious security implications.
        # See overrides.
        "kernel.yama.ptrace_scope" = "3";

        # Disables magic sysrq key. See overrides file regarding SAK (Secure
        # attention key).
        "kernel.sysrq" = "0";

        # Disable binfmt. Breaks Roseta, see overrides file.
        "fs.binfmt_misc.status" = "0";

        # Disable io_uring. May be desired for Proxmox, but is responsible
        # for many vulnerabilities and is disabled on Android + ChromeOS.
        # See overrides file. mpd and other services may break.
        "kernel.io_uring_disabled" = "2";

        # Disable ip forwarding to reduce attack surface. May be needed for
        # VM networking. See overrides file.
        "net.ipv4.ip_forward" = "0";
        "net.ipv4.conf.all.forwarding" = "0";
        "net.ipv4.conf.default.forwarding" = "0";
        "net.ipv6.conf.all.forwarding" = "0";
        "net.ipv6.conf.default.forwarding" = "0";

        # Privacy/security split.
        # See overrides file for details.
        "net.ipv4.tcp_timestamps" = "1";

        "dev.tty.ldisc_autoload" = "0";
        "fs.protected_fifos" = "2";
        "fs.protected_hardlinks" = "1";
        "fs.protected_regular" = "2";
        "fs.protected_symlinks" = "1";
        "fs.suid_dumpable" = "0";
        "kernel.dmesg_restrict" = "1";
        "kernel.kexec_load_disabled" = "1";
        "kernel.kptr_restrict" = "2";
        "kernel.perf_event_paranoid" = "3";
        "kernel.printk" = "3 3 3 3";
        "kernel.unprivileged_bpf_disabled" = "1";
        "net.core.bpf_jit_harden" = "2";
        "net.ipv4.conf.all.accept_redirects" = "0";
        "net.ipv4.conf.all.accept_source_route" = "0";
        "net.ipv4.conf.all.rp_filter" = "1";
        "net.ipv4.conf.all.secure_redirects" = "0";
        "net.ipv4.conf.all.send_redirects" = "0";
        "net.ipv4.conf.default.accept_redirects" = "0";
        "net.ipv4.conf.default.accept_source_route" = "0";
        "net.ipv4.conf.default.rp_filter" = "1";
        "net.ipv4.conf.default.secure_redirects" = "0";
        "net.ipv4.conf.default.send_redirects" = "0";
        "net.ipv4.icmp_echo_ignore_all" = "1";
        "net.ipv6.icmp_echo_ignore_all" = "1";
        "net.ipv4.tcp_dsack" = "0";
        "net.ipv4.tcp_fack" = "0";
        "net.ipv4.tcp_rfc1337" = "1";
        "net.ipv4.tcp_sack" = "0";
        "net.ipv4.tcp_syncookies" = "1";
        "net.ipv6.conf.all.accept_ra" = "0";
        "net.ipv6.conf.all.accept_redirects" = "0";
        "net.ipv6.conf.all.accept_source_route" = "0";
        "net.ipv6.conf.default.accept_redirects" = "0";
        "net.ipv6.conf.default.accept_source_route" = "0";
        "net.ipv6.default.accept_ra" = "0";
        "kernel.core_pattern" = "|/bin/false";
        "vm.mmap_rnd_bits" = "32";
        "vm.mmap_rnd_compat_bits" = "16";
        "vm.unprivileged_userfaultfd" = "0";
        "net.ipv4.icmp_ignore_bogus_error_responses" = "1";

        # enable ASLR
        # turn on protection and randomize stack, vdso page and mmap + randomize brk base address
        "kernel.randomize_va_space" = "2";

        # restrict perf subsystem usage (activity) further
        "kernel.perf_cpu_time_max_percent" = "1";
        "kernel.perf_event_max_sample_rate" = "1";

        # do not allow mmap in lower addresses
        "vm.mmap_min_addr" = "65536";

        # log packets with impossible addresses to kernel log
        # No active security benefit, just makes it easier to spot a DDOS/DOS by giving
        # extra logs
        "net.ipv4.conf.default.log_martians" = "1";
        "net.ipv4.conf.all.log_martians" = "1";

        # disable sending and receiving of shared media redirects
        # this setting overwrites net.ipv4.conf.all.secure_redirects
        # refer to RFC1620
        "net.ipv4.conf.default.shared_media" = "0";
        "net.ipv4.conf.all.shared_media" = "0";

        # always use the best local address for announcing local IP via ARP
        # Seems to be most restrictive option
        "net.ipv4.conf.default.arp_announce" = "2";
        "net.ipv4.conf.all.arp_announce" = "2";

        # reply only if the target IP address is local address configured on the incoming interface
        "net.ipv4.conf.default.arp_ignore" = "1";
        "net.ipv4.conf.all.arp_ignore" = "1";

        # drop Gratuitous ARP frames to prevent ARP poisoning
        # this can cause issues when ARP proxies are used in the network
        "net.ipv4.conf.default.drop_gratuitous_arp" = "1";
        "net.ipv4.conf.all.drop_gratuitous_arp" = "1";

        # ignore all ICMP echo and timestamp requests sent to broadcast/multicast
        "net.ipv4.icmp_echo_ignore_broadcasts" = "1";

        # number of Router Solicitations to send until assuming no routers are present
        "net.ipv6.conf.default.router_solicitations" = "0";
        "net.ipv6.conf.all.router_solicitations" = "0";

        # do not accept Router Preference from RA
        "net.ipv6.conf.default.accept_ra_rtr_pref" = "0";
        "net.ipv6.conf.all.accept_ra_rtr_pref" = "0";

        # learn prefix information in router advertisement
        "net.ipv6.conf.default.accept_ra_pinfo" = "0";
        "net.ipv6.conf.all.accept_ra_pinfo" = "0";

        # setting controls whether the system will accept Hop Limit settings from a router advertisement
        "net.ipv6.conf.default.accept_ra_defrtr" = "0";
        "net.ipv6.conf.all.accept_ra_defrtr" = "0";

        # router advertisements can cause the system to assign a global unicast address to an interface
        "net.ipv6.conf.default.autoconf" = "0";
        "net.ipv6.conf.all.autoconf" = "0";

        # number of neighbor solicitations to send out per address
        "net.ipv6.conf.default.dad_transmits" = "0";
        "net.ipv6.conf.all.dad_transmits" = "0";

        # number of global unicast IPv6 addresses can be assigned to each interface
        "net.ipv6.conf.default.max_addresses" = "1";
        "net.ipv6.conf.all.max_addresses" = "1";

        # enable IPv6 Privacy Extensions (RFC3041) and prefer the temporary address
        # https://grapheneos.org/features#wifi-privacy
        # GrapheneOS devs seem to believe it is relevant to use IPV6 privacy
        # extensions alongside MAC randomization, so that's why we do both
        "net.ipv6.conf.default.use_tempaddr" = lib.mkForce "2";
        "net.ipv6.conf.all.use_tempaddr" = lib.mkForce "2";

        # ignore all ICMPv6 echo requests
        "net.ipv6.icmp.echo_ignore_all" = "1";
        "net.ipv6.icmp.echo_ignore_anycast" = "1";
        "net.ipv6.icmp.echo_ignore_multicast" = "1";
      };
    };

    kernelParams = [
      # Requires all kernel modules to be signed. This prevents out-of-tree
      # kernel modules from working unless signed. See overrides.
      "module.sig_enforce=1"

      # May break some drivers, same reason as the above. Also breaks
      # hibernation. See overrides.
      "lockdown=confidentiality"

      # May prevent some systems from booting. See overrides.
      "efi=disable_eaiommurly_pci_dma"

      # Forces DMA to go through IOMMU to mitigate some DMA attacks. See
      # overrides.
      "iommu.passthrough=0"

      # linux security modules
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo,selinux"

      # prevent the kernel from blanking plymouth out of the fb
      "fbcon=nodefer"

      # Apply relevant CPU exploit mitigations, and disable symmetric
      # multithreading. May harm performance. See overrides.
      "mitigations=auto,nosmt"

      # Mitigates Meltdown, some KASLR bypasses. Hurts performance. See
      # overrides.
      "pti=on"

      # Gather more entropy on boot. Only works with the linux_hardened
      # patchset, but does nothing if using another kernel. Slows down boot
      # time by a bit.
      "extra_latent_entropy"

      # Disables multilib/32 bit applications to reduce attack surface.
      # See overrides.
      "ia32_emulation=0"

      "slab_nomerge"
      "init_on_alloc=1"
      "init_on_free=1"
      "page_alloc.shuffle=1"
      "randomize_kstack_offset=on"
      "vsyscall=none"
      "debugfs=off"
      "oops=panic"
      "quiet"
      "loglevel=0"
      "random.trust_cpu=off"
      "random.trust_bootloader=off"
      "intel_iommu=on"
      "amd_iommu=force_isolation"
      "iommu=force"
      "iommu.strict=1"
    ];

    blacklistedKernelModules = lib.concatLists [
      # Obscure network protocols
      [
        "dccp" # Datagram Congestion Control Protocol
        "sctp" # Stream Control Transmission Protocol
        "rds" # Reliable Datagram Sockets
        "tipc" # Transparent Inter-Process Communication
        "n-hdlc" # High-level Data Link Control
        "netrom" # NetRom
        "x25" # X.25
        "ax25" # Amatuer X.25
        "rose" # ROSE
        "decnet" # DECnet
        "econet" # Econet
        "af_802154" # IEEE 802.15.4
        "ipx" # Internetwork Packet Exchange
        "appletalk" # Appletalk
        "psnap" # SubnetworkAccess Protocol
        "p8022" # IEEE 802.3
        "p8023" # Novell raw IEEE 802.3
        "can" # Controller Area Network
        "atm" # ATM
      ]

      # Old or rare or insufficiently audited filesystems
      [
        "adfs" # Active Directory Federation Services
        "affs" # Amiga Fast File System
        "befs" # "Be File System"
        "bfs" # BFS, used by SCO UnixWare OS for the /stand slice
        "cifs" # Common Internet File System
        "cramfs" # compressed ROM/RAM file system
        "efs" # Extent File System
        "erofs" # Enhanced Read-Only File System
        "exofs" # EXtended Object File System
        "freevxfs" # Veritas filesystem driver
        "f2fs" # Flash-Friendly File System
        "vivid" # Virtual Video Test Driver (unnecessary, and a historical cause of escalation issues)
        "gfs2" # Global File System 2
        "hpfs" # High Performance File System (used by OS/2)
        "hfs" # Hierarchical File System (Macintosh)
        "hfsplus" # " same as above, but with extended attributes
        "jffs2" # Journalling Flash File System (v2)
        "jfs" # Journaled File System - only useful for VMWare sessions
        "ksmbd" # SMB3 Kernel Server
        "minix" # minix fs - used by the minix OS
        "nfsv3" # " (v3)
        "nfsv4" # Network File System (v4)
        "nfs" # Network File System
        "nilfs2" # New Implementation of a Log-structured File System
        "omfs" # Optimized MPEG Filesystem
        "qnx4" # extent-based file system used by the QNX4 and QNX6 OSes
        "qnx6" # "
        "squashfs" # compressed read-only file system (used by live CDs)
        "sysv" # implements all of Xenix FS, SystemV/386 FS and Coherent FS.
        "udf" # https://docs.kernel.org/5.15/filesystems/udf.html
      ]

      # Disable Thunderbolt and FireWire to prevent DMA attacks
      [
        "thunderbolt"
        "firewire-core"
      ]

      # you might possibly want your webcam to work
      # we whitelsit the module if the system wants
      # webcam to work
      [
        "uvcvideo" # this is why your webcam no worky
      ]

      # if bluetooth is enabled, whitelist the module
      # necessary for bluetooth dongles to work
      (lib.optionals (!config.hardware.bluetooth.enable) [
        "bluetooth" # let bluetooth work
        "btusb" # let bluetooth dongles work
      ])
    ];
  };
}

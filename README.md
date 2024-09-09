#### THIS REPOSITORY IS NOT BEING UPDATED ANYMORE
#### I SWITCHED TO GITLAB
#### https://gitlab.com/halcon741/halcon-overlay



#### A very EXPERIMENTAL overlay for my own use and testing/learning purposes.

Use it (with caution), if you want to.
If you find a bug, please feel free to report it.

#### PACKAGES:

* app-crypt/openpgp-keys-pm-utils - Package for testing the functionality of checking git commit signatures in ebuilds. Absent in ::gentoo.  
* app-crypt/openpgp-keys-worker - Ralf Hoffmann's openPGP key used to sign app-misc/worker releases. Absent in ::gentoo.  
* app-misc/Hello_World - Test program that I've written for learning purposes. It just prints 'Hello World!' to STDOUT. Absent in ::gentoo.  
* app-misc/worker - Version bump, relatively to the current 4.6.1 in ::gentoo (20.03.2021). The ebuild is significantly re-made. Verifying release signature is available (with USE flag 'verify-sig').  
* app-portage/g-cpan - So far for testing/learning purposes only.  
* app-text/evince - Building evince without gvfs and dbus. And it works! [MASKED], as I don't neither use nor maintain this ebuild anymore.  
* dev-libs/klibc - Minimal libc subset for use with initramfs. Dependency for sys-apps/v86d. Two ebuild versions, one of them is identical to the standard ebuild in ::gentoo before last-riting in March 2021.  
* dev-perl/JSON - Version bump, relatively to the (obsolete) current 2.940.0 in ::gentoo (03.02.2021). 
* dev-perl/Config-Identity - Dependency for Minilla. Absent in ::gentoo.  
* dev-perl/Data-Entropy - Entropy (randomness) management. The package is being installed in minimal configuration (without RandomnumbersInfo and RandomOrg modules). Absent in ::gentoo.  
* dev-perl/Data-Section-Simple - Dependency for Minilla. Absent in ::gentoo.  
* dev-perl/Digest-Bcrypt - Perl interface to the bcrypt digest algorithm (a simple wrapper around Crypt::Eksblowfish::Bcrypt). Absent in ::gentoo.  
* dev-perl/Gentoo-Overlay - Tools for working with Gentoo Overlays, written by recently deceased Kent Fredric (Rest in Peace...) Absent in ::gentoo.  
* dev-perl/Minilla - CPAN module authoring tool, recently suggested. The package can be installed with USE flag 'disthook' which applies the patch for making release.hooks run not at 'minil release' only, but at 'minil dist' too (according to my Minilla fork). So far, the package is being installed in minimal configuration (without "recommended" dependencies). Absent in ::gentoo.  
* dev-perl/Mojolicious - "Really live" ebuild. Each new stable (not development) release gets installed automatically without the need to edit the ebuild.  
* dev-perl/MooX-ClassAttribute - Dependency for Gentoo-Overlay. Absent in ::gentoo.  
* dev-perl/Perl-osnames - Tool for listing names of operating systems as they are detected by Perl. Absent in ::gentoo.  
* dev-perl/String-Format - Fixed Gentoo bug 715140. Version bump, relatively to the (obsolete) current 1.170.0 in ::gentoo (02.02.2021). The bump is important because String-Format-1.170.0 will not work in the next perl version (5.32). All its reverse dependencies, including Perl-Critic, won't work either. (Perl-Critic warns about it.)  
* dev-perl/Test-Deep-Fuzzy - Dependency for Minilla. Absent in ::gentoo.  
* dev-perl/Text-MicroTemplate - Dependency for Minilla. Absent in ::gentoo.  
* dev-perl/TOML - Dependency for Minilla. Absent in ::gentoo.  
* dev-perl/TOML-Parser - Dependency for Minilla. Absent in ::gentoo.  
* dev-vcs/hg-git - Started as a version bump, relatively to 0.9.0 in ::gentoo at 04.02.2021.  
* dev-vcs/tortoisehg - Version bump, relatively to the current 5.9.3 in ::gentoo (19.01.2022). 
* media-gfx/xnviewmp-bin - Attempt to build XnViewMP with system libraries. So far unsuccessful... [MASKED], as this ebuild is not yet ready. Absent in ::gentoo.  
* media-libs/avidemux-plugins - Fixed Gentoo bug 744859. Lets to get rid of dev-lang/spidermonkey and of python 2.7.  
* net-im/dino - Fixed Gentoo bug 790170.  
* net-libs/gnutls - For maintaining compatibility with some other packages.  
* net-wireless/rtl8192eu - Drivers for the rtl8192eu chipset for wireless adapters (D-Link DWA-131 rev E1 included). Based on the ebuild in Guru overlay. Updated to a newer commit. Absent in ::gentoo.  
* net-wireless/rtl8821ce-driver - Drivers for the rtl8821ce chipset for wireless adapters. Based on the ebuild in Trolltoo overlay. Updated to a newer commit. Absent in ::gentoo.  
* sys-apps/hwids - Dependency for sys-fs/eudev. Downloading from my fork. Based on ::gentoo ebuilds made at the announcement about planning hwids last-riting in November 2021.  
* sys-apps/pciutils - Various utilities dealing with the PCI bus. Version compatible with eudev (depending on hwids instead of hwdata).  
* sys-apps/v86d - Daemon to run x86 code in an emulated environment. Two ebuild versions, one of them is identical to the ebuild in sabayon ("for-gentoo") overlay before klibc last-riting in March 2021.  
* sys-fs/eudev - Downloading from a newly "adopted" project. 
* sys-power/pm-utils - New version, from my fork. Re-made ebuild. Included all the patches present in ::gentoo before last-riting in January 2021, non-specific Debian patches and a patch from c2p-overlay. Included all the additional files from Gentoo/Debian (the same). Deleted obsolete files which were being removed by Gentoo ebuild / Debian rules. Included pm-quirks. Fixed Gentoo bugs 666380, 579912, 549848, 489650, 443530, 703026 and Debian bugs 485443, 659260.  
* virtual/dev-manager - Copy of ::gentoo ebuild made at the announcement about eudev retirement in August 2021.  
* virtual/libudev - Copy of ::gentoo ebuild made at the announcement about eudev retirement in August 2021.  
* virtual/udev - Copy of ::gentoo ebuild made at the announcement about eudev retirement in August 2021.  
* www-apps/cgit - Building cgit without webapp-config. The ebuild is significantly re-made.  
* www-client/firefox - Version bump, relatively to the current 102.7.0esr in ::gentoo (18.02.2023). Gentoo bug 895132.  
* x11-libs/libpciaccess - Library providing generic access to the PCI bus and devices. Version compatible with eudev (depending on hwids instead of hwdata).  
* x11-misc/clipit - Fork of Parcellite. Based on the ebuild from Case_Of overlay. Fixed building with 'appindicator' USE flag (I would have reported a bug, if the tracker was on GitHub). Absent in ::gentoo.  
* x11-misc/drm_master_util - Non-root Xorg without elogind (for Linux kernels <5.8). Absent in ::gentoo.  
* x11-misc/fbpanel - Light-weight X11 desktop panel, eleksir's fork with a new version. There is only the old, original program in ::gentoo.  
  
If you need one of the [MASKED] ebuilds, you may want to unmask it in your /etc/portage directory.

#### How to add the overlay:

* using Mercurial, from OSDN (possible with Portage >=3.0.8)
  
eselect repository add halcon-overlay mercurial https://hg.osdn.net/view/halcon-overlay/code  
echo "sync-mercurial-pull-extra-opts = -b default" >> /etc/portage/repos.conf/eselect-repo.conf _(if you don't do that, you may get unstable branch)_  
emerge --sync halcon-overlay  _(this requires dev-vcs/mercurial to be installed)_

* using Git, from GitHub
  
eselect repository add halcon-overlay git https://github.com/halcon74/halcon-overlay.git  
emerge --sync halcon-overlay  

#### I push the commits (via hg-git) simultaneously to:

* Mercurial repository on OSDN - https://osdn.net/projects/halcon-overlay/scm/hg/code/tree/tip/
* Git repository on GitHub - https://github.com/halcon74/halcon-overlay

#### Gentoo Quality Assurance:
  (last run on the 23.03.2021)
  
* /var/db/repos/halcon-overlay # repoman -dx --without-mask full
  
RepoMan scours the neighborhood...  
  dependency.deprecated         2  
   media-gfx/xnviewmp-bin/xnviewmp-bin-0.96.5.ebuild: 'dev-qt/qtwebkit:5[qml]'  
   media-gfx/xnviewmp-bin/xnviewmp-bin-0.96.5.ebuild: 'dev-qt/qtwebkit:5[opengl]'  
  upstream.workaround           2  
   dev-libs/klibc/klibc-2.0.4-r3.ebuild: line 183: Upstream parallel compilation bug (ebuild calls emake -j1)  
   dev-libs/klibc/klibc-2.0.4-r4.ebuild: line 185: Upstream parallel compilation bug (ebuild calls emake -j1)  
RepoMan sez: "You're only giving me a partial QA payment?  
              I'll take it this time, but I'm not happy."  
  
* /var/db/repos/halcon-overlay # pkgcheck scan
  
app-crypt/openpgp-keys-worker  
  PotentialStable: version 20210320: slot(0), stabled arches: [ amd64, ppc, x86 ], potentials: [ ~arm, ~hppa, ~ppc64 ]  
  
dev-perl/MooX-ClassAttribute  
  NonexistentBlocker: version 0.11.0: nonexistent blocker DEPEND="!<=dev-perl/MooseX-ClassAttribute-0.260.0": no matches in repo history  
  NonexistentBlocker: version 0.11.0: nonexistent blocker DEPEND="!~dev-perl/Moo-1.1.0": no matches in repo history  
  
dev-perl/Test-Deep-Fuzzy  
  RedundantLongDescription: metadata.xml longdescription is too short  
  
app-misc/worker  
  RedundantVersion: version 4.6.1-r100: slot(0) keywords are overshadowed by version: 4.7.0-r1  
  PotentialStable: version 4.7.0-r1: slot(0), stabled arch: [ x86 ], potentials: [ ~amd64, ~arm, ~hppa, ~ppc, ~ppc64 ]  
  
dev-libs/klibc  
  PotentialStable: version 2.0.4-r3: slot(0), stabled arches: [ amd64, x86 ], potentials: [ ~alpha, ~arm, ~ia64, ~ppc, ~ppc64, ~sparc ]  
  
sys-apps/v86d  
  NonsolvableDepsInDev: version 0.1.10-r1: nonsolvable depset(depend) keyword(amd64) dev profile (default/linux/amd64/17.0/x32) (2 total): solutions: [ dev-libs/klibc ]  
  NonsolvableDepsInStable: version 0.1.10-r1: nonsolvable depset(depend) keyword(amd64) stable profile (default/linux/amd64/17.1) (52 total): solutions: [ dev-libs/klibc ]  
  NonsolvableDepsInDev: version 0.1.10-r2: nonsolvable depset(depend) keyword(~amd64) dev profile (default/linux/amd64/17.0/x32): solutions: [ dev-libs/klibc ]  
  NonsolvableDepsInStable: version 0.1.10-r2: nonsolvable depset(depend) keyword(~amd64) stable profile (default/linux/amd64/17.1) (26 total): solutions: [ dev-libs/klibc ]  
  
media-libs/avidemux-plugins  
  NonexistentBlocker: version 2.7.6-r1: nonexistent blocker RDEPEND="!<media-libs/avidemux-plugins-2.7.6": no matches in repo history  
  
sys-power/pm-utils  
  NonexistentBlocker: version 1.4.4: nonexistent blocker DEPEND="!<app-laptop/laptop-mode-tools-1.55-r1": no matches in repo history  
  NonexistentBlocker: version 1.4.4: nonexistent blocker DEPEND="!sys-power/pm-quirks": no matches in repo history  
  NonexistentBlocker: version 1.4.4: nonexistent blocker RDEPEND="!<app-laptop/laptop-mode-tools-1.55-r1": no matches in repo history  
  NonexistentBlocker: version 1.4.4: nonexistent blocker RDEPEND="!sys-power/pm-quirks": no matches in repo history  
  NonexistentBlocker: version 9999: nonexistent blocker DEPEND="!<app-laptop/laptop-mode-tools-1.55-r1": no matches in repo history  
  NonexistentBlocker: version 9999: nonexistent blocker DEPEND="!sys-power/pm-quirks": no matches in repo history  
  NonexistentBlocker: version 9999: nonexistent blocker RDEPEND="!<app-laptop/laptop-mode-tools-1.55-r1": no matches in repo history  
  NonexistentBlocker: version 9999: nonexistent blocker RDEPEND="!sys-power/pm-quirks": no matches in repo history  
  
eclass  
  EclassDocMissingFunc: unpacker: undocumented functions: find_unpackable_file, unpack_banner  
  EclassDocMissingFunc: verify-all-sigs: undocumented function: find_unpackable_file  
  

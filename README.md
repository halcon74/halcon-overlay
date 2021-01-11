#### A very EXPERIMENTAL overlay for my own use and testing/learning purposes.

Use it (with caution), if you want to.
If you find a bug, please feel free to report it.

#### PACKAGES:

* app-misc/Hello_World - Test program that I've written for learning purposes. It just prints 'Hello World!' to STDOUT.
* app-misc/worker - Version bump, relatively to the (obsolete!) current 3.8.3 in ::gentoo (20.12.2020). The ebuild is significantly re-made.
* app-portage/g-cpan - So far for testing/learning purposes only.
* app-text/evince - Building evince without gvfs and dbus. And it works!
* dev-perl/Mojolicious - "Really live" ebuild. Each new stable (not development) release gets installed automatically without the need to edit the ebuild.
* dev-vcs/hg-git - Version bump, relatively to the current 0.9.0_rc1 in ::gentoo (19.09.2020). Supports mercurial-5.5.1.
* media-gfx/xnviewmp-bin - Attempt to build XnViewMP with system libraries. So far unsuccessful...
* sys-power/pm-utils - New version, from my fork. Re-made ebuild. **Included all the patches present in ::gentoo before last-riting in January 2021, non-specific Debian patches and a patch from c2p-overlay. Included all the additional files from Gentoo/Debian (the same). Deleted obsolete files which was being removed by Gentoo ebuild / Debian rules. Included pm-quirks. Fixed Gentoo bugs 666380, 579912, 549848, 489650, 443530, 703026 and Debian bugs 485443, 659260**.
* x11-misc/drm_master_util - Non-root Xorg without elogind (for Linux kernels <5.8).

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

* /var/db/repos/halcon-overlay # repoman -dx full
  
RepoMan scours the neighborhood...  
RepoMan sez: "If everyone were like you, I'd be out of business!"  

* /var/db/repos/halcon-overlay # pkgcheck scan
  
app-text/evince  
  PotentialStable: version 3.34.2: slot(0), stabled arches: [ amd64, x86 ], potentials: [ ~alpha, ~arm, ~arm64, ~ia64, ~ppc, ~ppc64, ~sparc ]  

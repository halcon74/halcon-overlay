#### A very EXPERIMENTAL overlay for my own use and testing/learning purposes.

Use it (with caution), if you want to.
If you find a bug, please feel free to report it.

#### PACKAGES:

* app-text/evince - Building evince without gvfs and dbus. And it works!
* dev-perl/Mojolicious - A "really live" ebuild. Each new stable (not development) release gets installed automatically without the need to edit the ebuild.
* dev-vcs/hg-git - A version bump, relatively to the current 0.9.0_rc1 in ::gentoo (19.09.2020)
* media-gfx/xnviewmp-bin - An attempt to build XnViewMP with system libraries. So far unsuccessful...
* x11-misc/drm_master_util - Non-root Xorg without elogind (for Linux kernels <5.8).

#### How to add the overlay:

* eselect repository add halcon-overlay git https://github.com/halcon74/halcon-overlay.git

#### I am currently committing (via hg-git) simultaneously to:

* Mercurial repository - https://osdn.net/projects/halcon-overlay/scm/hg/code/tree/tip/
* Git repository - https://github.com/halcon74/halcon-overlay

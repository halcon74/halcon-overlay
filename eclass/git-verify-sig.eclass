# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: git-verify-sig.eclass
# @MAINTAINER:
# Alexey Mishustin <halcon@tuta.io>
# @AUTHOR:
# Vladimir Timofeenko <overlay.maintain@vtimofeenko.com>
# Alexey Mishustin <halcon@tuta.io>
# @BLURB: Allows verifying signature on top commit
# @DESCRIPTION:
# This eclass provides the ability to verify the signature on the
# top commit of repository checked out by git-r3.
# The interfaces exposed by this eclass aim to mimick the behavior
# of verify-sig.eclass.
#
#
# Example use:
# @CODE
# inherit git-verify-sig
# EGIT_REPO_URI="https://example.org/author/repository.git"
# EGIT_BRANCH="some-non-default-branch"
# BDEPEND="
#   git-verify-sig? ( app-crypt/openpgp-keys-example )"
#
# VERIFY_GIT_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/example.asc
#
# @CODE
# This will use the default git-r3_src_unpack to get the repo and
# verify the signature on the top commit.
# Alternatively, use git-verify-sig_verify-commit <git-directory> [<key-file>]
# specifying the directory where to verify the commit and the key to verify against.

if [[ ! ${_GIT_VERIFY_SIG_ECLASS} ]]; then

case "${EAPI:-0}" in
	0|1|2|3|4|5|6)
		die "Unsupported EAPI=${EAPI} (obsolete) for ${ECLASS}"
		;;
	7)
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for ${ECLASS}"
		;;
esac

EXPORT_FUNCTIONS src_unpack

inherit git-r3

IUSE="git-verify-sig"

BDEPEND="
	git-verify-sig? (
		app-crypt/gnupg
		>=app-portage/gemato-16
	)"

# @ECLASS-VARIABLE: VERIFY_GIT_SIG_OPENPGP_KEY_PATH
# @DEFAULT_UNSET
# @DESCRIPTION:
# Path to key bundle used to perform the verification.  This is required
# when using default src_unpack.  Alternatively, the key path can be
# passed directly to the verification functions.

# @FUNCTION: git-verify-sig_src_unpack
# @DESCRIPTION:
# Default src_unpack override that verifies signature for the
# newest (HEAD) commit if 'git-verify-sig' flag is enabled.  The function dies if the
# signatures fails to verify or the commit not signed.
git-verify-sig_src_unpack() {
	git-r3_src_unpack
	if use git-verify-sig; then
		git-verify-sig_verify-commit "${EGIT_CHECKOUT_DIR:-${WORKDIR}/${P}}"
	fi
}

# @FUNCTION: git-verify-sig_verify-commit
# @USAGE: [<git-directory> [<key-file>]]
# @DESCRIPTION:
# Verifies the newest (HEAD) commit in the supplied directory
# using the supplied key file
git-verify-sig_verify-commit() {
	local -x GIT_DIR
	local git_dir=${1:-${GIT_DIR}}
	local key=${2:-${VERIFY_GIT_SIG_OPENPGP_KEY_PATH}}

	[[ -n ${key} ]] ||
		die "${FUNCNAME}: no key passed and VERIFY_SIG_OPENPGP_KEY_PATH unset"

	local extra_args=( "-R" )

	gemato gpg-wrap -K "${key}" "${extra_args[@]}" -- \
		git --work-tree="${git_dir}" --git-dir="${git_dir}"/.git verify-commit HEAD ||
		die "Git commit verification failed"
}

_GIT_VERIFY_SIG_ECLASS=1
fi

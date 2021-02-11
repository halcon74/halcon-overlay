# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: git-verify-signature.eclass
# @MAINTAINER:
# Alexey Mishustin <halcon@tuta.io>
# @AUTHOR:
# Vladimir Timofeenko <overlay.maintain@vtimofeenko.com>
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
# inherit git-verify-signature
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
# Alternatively, use git-verify-signature_verify-commit <git-directory>
# specifying the directory where to verify the commit.
#
# Some notes:
# inherit verify-sig is used to properly add the dependencies

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

inherit git-r3 verify-sig

IUSE+=" git-verify-sig"

# @FUNCTION: git-verify-signature_src_unpack
# @DESCRIPTION:
git-verify-signature_src_unpack() {
	git-r3_src_unpack
	if use git-verify-sig; then
		git-verify-signature_verify-commit "${EGIT_CHECKOUT_DIR:-${WORKDIR}/${P}}"
	fi
}

# @FUNCTION: git-verify-signature_verify-commit
# @USAGE: <git-directory> [<key-file>]
# @DESCRIPTION:
# Verifies the HEAD commit in the supplied directory
# optionally using the supplied key file

git-verify-signature_verify-commit() {
	local git_dir=${1}
	local key=${2:-${VERIFY_GIT_SIG_OPENPGP_KEY_PATH}}

	local extra_args=( "-R" )

	gemato gpg-wrap -K "${VERIFY_GIT_SIG_OPENPGP_KEY_PATH}" "${extra_args[@]}" -- \
		git --work-tree="${git_dir}" --git-dir="${git_dir}"/.git verify-commit HEAD ||
		die "Git commit verification failed"
}

_GIT_VERIFY_SIG_ECLASS=1
fi

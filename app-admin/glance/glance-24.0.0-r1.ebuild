# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 systemd tmpfiles

DESCRIPTION="Services for discovering, registering, and retrieving VM images"
HOMEPAGE="
	https://launchpad.net/glance
	https://github.com/openstack/glance
	https://opendev.org/openstack/glance
"
SRC_URI="https://tarballs.openstack.org/${PN}/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-python/pbr-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.25.1[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/routes-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/webob-1.8.1[${PYTHON_USEDEP}]
	>=dev-python/sqlparse-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/alembic-0.9.6[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-8.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-upgradecheck-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.7.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/futurist-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/taskflow-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/WSME-0.8.0[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/paste-2.0.2[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-limit-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-5.29.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.31.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-reports-1.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.8.1[${PYTHON_USEDEP}]
	>=dev-python/retrying-1.2.3[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/glance_store-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.19.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/cursive-0.2.1[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.11[${PYTHON_USEDEP}]
	>=dev-python/os-win-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/castellan-0.17.0[${PYTHON_USEDEP}]

	>=dev-python/sqlalchemy-1.0.10[${PYTHON_USEDEP}]

	acct-user/glance
	acct-group/glance
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/ddt-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/requests-2.18.0[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testresources-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/psutil-3.2.2[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/boto3-1.9.199[${PYTHON_USEDEP}]
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/psycopg-2.8.4[${PYTHON_USEDEP}]
		>=dev-python/xattr-0.9.2[${PYTHON_USEDEP}]
		>=dev-python/python-swiftclient-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-4.1.0[${PYTHON_USEDEP}]
		>=dev-python/os-brick-3.1.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-privsep-1.32.0[${PYTHON_USEDEP}]

		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_compile_all() {
	oslo-config-generator --config-file etc/oslo-config-generator/glance-api.conf  || die
	oslo-config-generator --config-file etc/oslo-config-generator/glance-scrubber.conf || die
	oslo-config-generator --config-file etc/oslo-config-generator/glance-cache.conf || die
	oslo-config-generator --config-file etc/oslo-config-generator/glance-manage.conf || die
	oslo-config-generator --config-file etc/oslo-config-generator/glance-image-import.conf || die
	oslopolicy-sample-generator --config-file=etc/glance-policy-generator.conf || die
}

python_prepare_all() {
	rm glance/tests/test_hacking.py || die
	sed -i '/pysendfile/d' test-requirements.txt || die
	sed -i '/^hacking/d' test-requirements.txt || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	newinitd "${FILESDIR}/glance.initd" glance-api

	diropts -m 0750 -o glance -g glance
	dodir /var/log/glance /var/lib/glance/images /var/lib/glance/scrubber
	keepdir /etc/glance
	keepdir /var/log/glance
	keepdir /var/lib/glance/images
	keepdir /var/lib/glance/scrubber

	systemd_dounit "${FILESDIR}/openstack-glance-api.service"
	systemd_dounit "${FILESDIR}/openstack-glance-registry.service"
	systemd_dounit "${FILESDIR}/openstack-glance-scrubber.service"
	newtmpfiles "${FILESDIR}/glance.tmpfiles" glance.conf

	insinto /etc/logrotate.d
	newins "${FILESDIR}/glance.logrotate" glance

	insinto /etc/sudoers.d
	insopts -m 0440 -o root -g root
	newins "${FILESDIR}/glance.sudoers" glance

	insinto /etc/glance
	insopts -m 0640 -o glance -g glance
	doins -r etc/*.ini etc/*.conf etc/*.sample etc/*.json etc/meta*

	distutils-r1_python_install_all
	rm -r "${ED}"/usr/etc
}

pkg_postinst() {
	tmpfiles_process glance.conf
}

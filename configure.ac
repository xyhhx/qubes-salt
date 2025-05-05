# -*- Autoconf -*-
# vim: set syn=config :

AC_PREREQ([2.72])
AC_DIAGNOSE([all])

# initialize autoconf from env vars
# TODO: add checks to ensure that the envs exist
AC_INIT(
  # name
  [mirage-fw],
  # version
  m4_esyscmd([echo ${VERSION}]),
  # version string (exactly "version string")
  m4_esyscmd([echo `version ${VERSION}`]),
  # bug report
  m4_esyscmd([echo ${PACKAGE_MAINTAINERS}]),
  # url
  m4_esyscmd([echo ${PACKAGE_URL}]),
)

AC_CONFIG_SRCDIR([rpm_spec/${PACKAGE}.spec.in])
AC_DEFINE_UNQUOTED([RELEASE], [`${RELEASE}`], [rc1])

AS_IF(
  [ test -d "$srcdir/.m4" ],
  [AC_CONFIG_AUX_DIR([.m4])]
)

AM_INIT_AUTOMAKE

# TODO: review how many of these i really need
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PROG_SED
PKG_PROG_PKG_CONFIG

AC_CONFIG_FILES([Makefile ${PACKAGE}.spec:rpm_spec/mirage-fw.spec.in])
AC_OUTPUT

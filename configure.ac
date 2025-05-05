# -*- Autoconf -*-
# vim: set syn=config :

AC_PREREQ([2.72])

# initialize autoconf from env vars
# TODO: add checks to ensure that the envs exist
AC_INIT(
  m4_esyscmd([echo ${NAME}]),
  m4_esyscmd([echo ${VERSION}]),
  m4_esyscmd([echo "version ${VERSION}"]),
  m4_esyscmd([echo ${MAINTAINERS}]),
  m4_esyscmd([echo ${URL}]),
)

# NOTE: from now on, PACKAGE_NAME, PACKAGE_VERSION, PACKAGE_STRING,
# PACKAGE_BUGREPORT, and PACKAGE_URL are available. (these are also
# passed to the generated makefile )
# ---

AC_CONFIG_SRCDIR([rpm_spec/${PACKAGE_NAME.spec.in])
AC_DEFINE_UNQUOTED([RELEASE], [`${RELEASE}`], [rc1])

AS_IF(
  [ test -d "${srcdir}/.m4" ],
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

AC_SUBST([LOG_LEVEL],[error])
AC_SUBST([COMMIT_SHA], m4_esyscmd([shell git rev-parse --short HEAD]))

AC_CONFIG_FILES([Makefile ${PACKAGE_NAME.spec:rpm_spec/${PACKAGE}.spec.in])
AC_OUTPUT

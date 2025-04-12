
Name:           qubes-user-salt
Version:        0.1.1
Release:        1%{?dist}
Summary:        My Qubes OS salt formulae

License:        HL3-FULL
URL:            https://git.sr.ht/~xyhhx/qubes-user-salt
Source0:        %{name}-%{version}.tar.gz

Group:          System administration tools
BuildArch:      noarch

Requires:       qubes-mgmt-salt-base
BuildRequires:  make

%description
A series of salt formulae to provision a Qubes OS how I like it

%prep
%setup -q

# %build
make

%install
make install DESTDIR=%{buildroot}

%files
%defattr(-,root,root)
%license LICENSE
%doc README.md
%config(noreplace) /srv/user/pillar/top.sls
%attr(750,root,root) /srv/user/*

%changelog
* Fri Apr 11 2025 xyhhx <xyhhx@tuta.io> 0.1.1-1
- new package built with tito


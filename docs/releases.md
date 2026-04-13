# Releases

## Versioning

This repo will follow a Calver[^calver] versioning scheme in the format of
`YYYY.MM.minor.micro[+modifier]`, where the segments are as follows:

-   **`YYYY`** - full year - 1999, 2025, 2100, etc
-   **`MM`** - short month - 1, 2, 10, etc
-   **`MINOR`** - breaking changes, features, etc
-   **`MICRO`** - bug fixes, docs, ci/build, etc
-   **`MODIFIER`** - draft, test, rc1 (optional)

`MINOR` is a **0-indexed** number that increments when new features/VMs are
introduced, when VMs are removed, when manual work is needed to update, etc.
On the first of each month, the version is bumped to `YYYY.MM.0.0` which
indicates an automtaed release with no changes pushed. **All releases with
changes must have a minor version of 1 or higher.**

`MICRO`is a **0-indexed** number that is bumped whenever trivial changes are
pushed, such as bugfixes or changes that don't affect end user usage of the
repo like documentation or CI updates.

`MODIFIER` can be anything and is used to delimit variants of any release
whether or not it's been published.

## Release process

While the project is being managed on Codeberg[^codeberg-repo] (or any Forgejo
instance), the release cycle can look as follows:

### Milestone and checklist

-   Create a milestone for release _**Qubes User Salts vYYYY.MM.X.0**_
    -   Due date is optional
    -   Description is optional
-   Create an issue called _**[RELEASE] vYYYY.MM.X.0**_
    -   Include a checklist of things to do to QA the release
    -   Set the milestone of this issue to the milestone just created
-   Set the milestone of any existing issues scheduled to be released to this
milestone
-   Create new issues off this milestone as needed

### Releasing

-   Make sure all scheduled PRs are merged or rejected
-   Make sure all issues scheduled are closed
    -   If any can't make it, remove them from the milestone
-   Lint and test `main`
-   Create a new release branch of `main` called `releases/vYYYY.MM.X.0`
-   Generate release notes from the git commit log, adding them to
  `docs/release-notes/vYYYY.MM.X.0.md`
-   Tag this commit as `vYYYY.MM.X.0`
-   Push this tag and commit
-   Create a prerelease in Codeberg for this tag
    -   Copy the content of the release notes created earlier into the release
  description
-   Create a PR merging `releases.vYYYY.MM.X.0` into `main`
    -   Verify everything is good and sane
-   Merge the PR manually
-   Update the release to be stable

> [!Note]
> This procedure was based the old Forgejo release process[^forgejo-release]

[^calver]: <https://calver.org>
[^codeberg-repo]: <https://codeberg.org/xyhhx/qubes-mgmt-salt-user/issues/159>
[^forgejo-release]: <https://forgejo.org/docs/v1.21/developer/release/#stable-release-process>

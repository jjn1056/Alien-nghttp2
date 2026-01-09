# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Project Overview

Alien::nghttp2 provides the nghttp2 HTTP/2 C library for CPAN. It uses
Alien::Build to either detect the system library or build from source.

## Build Commands

```bash
# Build with system library (default)
perlbrew use perl-5.40.0@default
perl Makefile.PL
make
make test

# Force build from source
ALIEN_INSTALL_TYPE=share perl Makefile.PL
make
make test

# Clean
make clean
make realclean
```

## Key Files

| File | Purpose |
|------|---------|
| `alienfile` | Build recipe (system detection + source build) |
| `lib/Alien/nghttp2.pm` | Main module (inherits Alien::Base) |
| `Makefile.PL` | Build script using Alien::Build::MM |
| `t/00-load.t` | Basic loading test |
| `t/01-alien.t` | Test::Alien XS compilation test |

## Environment Variables

- `ALIEN_INSTALL_TYPE=system` - Only use system library, fail if not found
- `ALIEN_INSTALL_TYPE=share` - Always build from source
- (unset) - Try system first, fall back to source build

## Known Issues

**Download::Negotiate Warning**: During build you may see warnings about
"using the regular download negotiator plugin on a GitHub release page."

This is a **false positive bug in Alien::Build** (as of v2.84) that affects
**all** Alien distributions using `Download::GitHub` (including Alien::xz,
Alien::Ninja, etc.). The warning regex `/^http.*github.com.*releases$/`
incorrectly matches the GitHub API URL (`api.github.com`) when it should
only warn about web URLs (`github.com`).

Our alienfile correctly uses `Download::GitHub` plugin which uses the API:
- Correct: `https://api.github.com/repos/nghttp2/nghttp2/releases`
- The warning should only trigger for: `https://github.com/user/repo/releases`

This is cosmetic only - all tests pass and functionality is correct.
Bug report: https://github.com/PerlAlien/Alien-Build/issues/431

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

#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Superman Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

SUPERMAND=${SUPERMAND:-$BINDIR/supermand}
SUPERMANCLI=${SUPERMANCLI:-$BINDIR/superman-cli}
SUPERMANTX=${SUPERMANTX:-$BINDIR/superman-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/superman-wallet}
SUPERMANQT=${SUPERMANQT:-$BINDIR/qt/superman-qt}

[ ! -x $SUPERMAND ] && echo "$SUPERMAND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a SPMVER <<< "$($SUPERMANCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for supermand if --version-string is not set,
# but has different outcomes for superman-qt and superman-cli.
echo "[COPYRIGHT]" > footer.h2m
$SUPERMAND --version | sed -n '1!p' >> footer.h2m

for cmd in $SUPERMAND $SUPERMANCLI $SUPERMANTX $WALLET_TOOL $SUPERMANQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${SPMVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${SPMVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m

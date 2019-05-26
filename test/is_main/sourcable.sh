#!/usr/bin/env bash
source "$PREAMBLE"

is_main && echo "sourcable.sh running as main" || echo "sourcable.sh sourced"
#!/bin/sh

# Replace the path with the actual path to the built GhostStringHunterCLI executable
GHOST_STRING_HUNTER_CLI_PATH="/path/to/GhostStringHunterCLI"

UNUSED_STRINGS=$($GHOST_STRING_HUNTER_CLI_PATH "$SRCROOT")

for unused_string in $UNUSED_STRINGS; do
  echo "warning: Unused localized string: $unused_string"
done
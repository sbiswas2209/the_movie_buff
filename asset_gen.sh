#!/bin/bash

set -e

echo "Cleaning old generated files..."
fvm dart run build_runner clean

echo "Running build_runner..."
fvm dart run build_runner build --delete-conflicting-outputs

echo "Build runner completed successfully ✅"

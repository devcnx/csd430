#!/usr/bin/env bash
# ------------------------------------------------------------
# deploy_modules.sh
# Deploy every module (or snippet) that contains a webapp to Tomcat.
# ------------------------------------------------------------

# Ensure CATALINA_HOME is set – abort if not.
if [[ -z "${CATALINA_HOME}" ]]; then
  echo "Error: CATALINA_HOME is not set."
  echo "Set it with: export CATALINA_HOME=/opt/homebrew/opt/tomcat@10/libexec"
  exit 1
fi

# Base directories to scan
BASE_DIRS=("modules" "snippets")

# Function to deploy a single module
deploy_module() {
  local module_path="$1"
  local module_name
  module_name="$(basename "$module_path")"

  local webapp_path
  webapp_path="$module_path/src/main/webapp"

  if [[ -d "$webapp_path" ]]; then
    local target_dir="$CATALINA_HOME/webapps/$module_name"
    echo "Deploying $module_name → $target_dir"
    mkdir -p "$target_dir"
    cp -r "$webapp_path"/* "$target_dir"/
    echo "  → copied $(find "$webapp_path" -type f | wc -l) files"
  else
    echo "Skipping $module_name: $webapp_path not found"
  fi
}

# Walk through each base directory
for base in "${BASE_DIRS[@]}"; do
  if [[ -d "$base" ]]; then
    for module_dir in "$base"/*/; do
      # Guard against empty globs
      [[ -d "$module_dir" ]] || continue
      deploy_module "$module_dir"
    done
  else
    echo "Warning: $base directory does not exist"
  fi
done

echo "Deployment completed."
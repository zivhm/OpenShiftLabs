#!/usr/bin/env bash
set -euo pipefail

# Generate Killercoda scenario from OpenShiftLabs tutorials (pure-bash JSON, no comments)
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LABS_DIR="$ROOT_DIR/Labs/tutorials"
SCENARIO_DIR="$ROOT_DIR/killercoda/openshift-basics"

mkdir -p "$SCENARIO_DIR" "$SCENARIO_DIR/assets"

INTRO_MD="$SCENARIO_DIR/intro.md"
FINISH_MD="$SCENARIO_DIR/finish.md"
INDEX_JSON="$SCENARIO_DIR/index.json"

cat > "$INTRO_MD" << 'EOF'
# OpenShift Basics
This scenario reuses the original OpenShiftLabs READMEs and demo scripts.
EOF

cat > "$FINISH_MD" << 'EOF'
# Finish
Great job! You completed the OpenShift basics scenario.
EOF

# Collect labs ordered by prefix (000-...)
mapfile -t labs < <(find "$LABS_DIR" -maxdepth 1 -mindepth 1 -type d | sort)

# Prepare arrays for JSON assembly
steps_items=()
asset_items=()

# Helper to escape quotes in strings
escape_json() { sed 's/\\/\\\\/g; s/"/\\"/g' <<< "$1"; }

step_num=1
for lab in "${labs[@]}"; do
  lab_basename="$(basename "$lab")"    # e.g., 001-verify-cluster
  step_dir="$SCENARIO_DIR/step${step_num}"
  mkdir -p "$step_dir"

  # Task content: copy lab README if exists, else stub
  if [[ -f "$lab/README.md" ]]; then
    cp "$lab/README.md" "$step_dir/task.md"
  else
    printf "# %s\nRun the demo script." "$lab_basename" > "$step_dir/task.md"
  fi

  # Verify script stub per step (author to customize later)
  cat > "$step_dir/verify.sh" << 'EOF'
#!/usr/bin/env bash
set -euo pipefail
# TODO: implement per-step verification (e.g., oc get resources)

EOF
  chmod +x "$step_dir/verify.sh"

  # Copy demo script as asset if present
  asset_folder="$SCENARIO_DIR/assets/$lab_basename"
  mkdir -p "$asset_folder"
  if [[ -f "$lab/_demo.sh" ]]; then
    cp "$lab/_demo.sh" "$asset_folder/_demo.sh"
    asset_items+=("{\"file\": \"assets/$lab_basename/_demo.sh\", \"target\": \"/home/sandbox/$lab_basename/_demo.sh\"}")
  fi

  # Derive a human-readable title from lab folder name after numeric prefix
  raw_title="${lab_basename#*-}"
  title="$(escape_json "$raw_title")"
  steps_items+=("{\"title\": \"$title\", \"text\": \"step${step_num}/task.md\", \"verify\": \"step${step_num}/verify.sh\"}")

  step_num=$((step_num + 1))
done

# Join arrays by comma
join_by() { local IFS="$1"; shift; echo "$*"; }
steps_json=$(join_by ', ' "${steps_items[@]:-}")
assets_json=$(join_by ', ' "${asset_items[@]:-}")

# Write clean JSON (no trailing comments)
cat > "$INDEX_JSON" << EOF
{
  "title": "OpenShift Basics",
  "description": "Scenario generated from OpenShiftLabs tutorials",
  "backend": { "imageid": "ubuntu:2004" },
  "environment": { "showide": false, "uilayout": "terminal" },
  "details": {
    "intro": { "text": "intro.md" },
    "finish": { "text": "finish.md" },
    "steps": [ $steps_json ],
    "assets": { "host01": [ $assets_json ] }
  }
}
EOF

echo "Generated Killercoda scenario at: $SCENARIO_DIR"

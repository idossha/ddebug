
#!/usr/bin/env bash
set -e

PROJECT_DIR="/workspace"
REQUIREMENTS_FILE="/tmp/requirements.txt"

echo "🧠 Setting up Python debugging environment..."

# Ensure project dir exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "❌ Project directory not found: $PROJECT_DIR"
  exit 1
fi

cd "$PROJECT_DIR"

# Create venv if not exists
if [ ! -d "$PROJECT_DIR/.venv" ]; then
  echo "🐍 Creating virtual environment..."
  python3.11 -m venv "$PROJECT_DIR/.venv"
fi

# Activate venv
source "$PROJECT_DIR/.venv/bin/activate"

# Install requirements if provided
if [ -f "$REQUIREMENTS_FILE" ]; then
  echo "📦 Installing dependencies from $REQUIREMENTS_FILE..."
  pip install -q --upgrade pip
  pip install -r "$REQUIREMENTS_FILE"
else
  echo "⚠️ No requirements.txt provided — skipping dependency installation."
fi

# Ensure debugpy is installed
pip install -q debugpy

echo "✅ Environment ready!"
echo "📂 Project: $PROJECT_DIR"
echo "🪄 Launching Neovim..."

# Launch nvim inside project directory
exec nvim .

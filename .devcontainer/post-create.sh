#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo "DevContainer Post-Create Setup"
echo "=========================================="

# Fix ownership of credential directories
echo "Setting up credential directories..."
if [ -d "/home/vscode/.config" ]; then
    sudo chown -R vscode:vscode /home/vscode/.config
    sudo chmod -R 755 /home/vscode/.config
fi

if [ -d "/home/vscode/.claude" ]; then
    sudo chown -R vscode:vscode /home/vscode/.claude
    sudo chmod -R 700 /home/vscode/.claude
fi

if [ -d "/home/vscode/.codex" ]; then
    sudo chown -R vscode:vscode /home/vscode/.codex
    sudo chmod -R 700 /home/vscode/.codex
fi

# Check if Node.js/npm is available
if ! command -v npm &> /dev/null; then
    echo "WARNING: npm is not available. Node.js feature may not have been installed."
    echo "Skipping AI CLI tool installation."
    echo ""
    echo "To fix this, rebuild the devcontainer to ensure features are applied:"
    echo "  - Command Palette: 'Dev Containers: Rebuild Container'"
    echo ""
    echo "=========================================="
    echo "DevContainer Ready (with warnings)"
    echo "=========================================="
    exit 0
fi

# Install AI CLI tools
echo "Installing Codex..."
if npm install -g @openai/codex; then
    echo "✓ Codex installed successfully"
else
    echo "WARNING: Failed to install Codex. Continuing..."
fi

# Add an alias for codex for:
# codex --ask-for-approval never --sandbox danger-full-access
echo "alias codex2='codex --ask-for-approval never --sandbox danger-full-access'" >> ~/.bashrc
source ~/.bashrc

# Add an alies for claude for:
# claude --dangerously-skip-permissions
echo "alias claude2='claude --dangerously-skip-permissions'" >> ~/.bashrc
source ~/.bashrc

echo "=========================================="
echo "DevContainer Ready!"
echo "=========================================="
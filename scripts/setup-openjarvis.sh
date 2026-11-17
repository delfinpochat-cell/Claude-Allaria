#!/usr/bin/env bash
# Instala OpenJarvis desde el submódulo ./openjarvis.
# Requisitos: uv (https://docs.astral.sh/uv/), Python 3.11-3.13, cargo (opcional, para la extensión Rust).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

git submodule update --init --recursive openjarvis

# Credenciales del backend cloud (ver .env.example).
if [ -f .env ]; then
  set -a; . ./.env; set +a
fi

# Config con motor cloud + Anthropic (se instala solo si no existe una previa).
mkdir -p "$HOME/.openjarvis"
if [ ! -f "$HOME/.openjarvis/config.toml" ]; then
  cp configs/openjarvis-cloud.toml "$HOME/.openjarvis/config.toml"
fi

cd openjarvis

if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

uv sync --extra dev --extra server

if command -v cargo >/dev/null 2>&1; then
  uv run maturin develop --manifest-path rust/crates/openjarvis-python/Cargo.toml
else
  echo "cargo no encontrado: se omite la extensión Rust (opcional)."
fi

uv run jarvis doctor

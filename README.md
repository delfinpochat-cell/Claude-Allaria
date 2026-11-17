# Claude-Allaria

## OpenJarvis

[OpenJarvis](https://github.com/open-jarvis/OpenJarvis) está incluido como submódulo git en `openjarvis/`, fijado al commit `6656b7f`.

### Instalación

```bash
git clone --recurse-submodules <url-de-este-repo>
./scripts/setup-openjarvis.sh
```

Si el repo ya está clonado sin submódulos:

```bash
git submodule update --init --recursive
./scripts/setup-openjarvis.sh
```

### Uso

```bash
cd openjarvis
uv run jarvis doctor
uv run jarvis --help
```

### Motor de inferencia

OpenJarvis necesita un motor de inferencia. Opciones:

- Local: instalar [Ollama](https://ollama.com) (`curl -fsSL https://ollama.com/install.sh | sh`).
- Cloud: `uv sync --extra inference-cloud` y configurar una API key en `config.toml`.

### Actualizar OpenJarvis

```bash
cd openjarvis && git fetch && git checkout <commit-o-tag>
cd .. && git add openjarvis && git commit -m "Actualiza OpenJarvis a <commit>"
```

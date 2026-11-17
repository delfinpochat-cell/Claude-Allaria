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

La configuración incluida (`configs/openjarvis-cloud.toml`) usa el motor `cloud` con Anthropic y el modelo `claude-opus-5-5`. El script de setup la copia a `~/.openjarvis/config.toml` si no existe una previa.

Credenciales:

```bash
cp .env.example .env
# editar .env y completar ANTHROPIC_API_KEY
./scripts/setup-openjarvis.sh
```

`.env` está en `.gitignore`; la key nunca se commitea. Para una sesión manual:

```bash
export ANTHROPIC_API_KEY=sk-ant-...
cd openjarvis && uv run jarvis ask "hola"
```

Alternativa local: instalar [Ollama](https://ollama.com) y setear `engine.default = "ollama"` en `~/.openjarvis/config.toml`.

### Actualizar OpenJarvis

```bash
cd openjarvis && git fetch && git checkout <commit-o-tag>
cd .. && git add openjarvis && git commit -m "Actualiza OpenJarvis a <commit>"
```

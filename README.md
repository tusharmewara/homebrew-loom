# homebrew-loom

Homebrew tap for [Loom] — the shared agentic ecosystem for AI tools.

[![Latest Release](https://img.shields.io/github/v/release/tusharmewara/loom?label=loom)](https://github.com/tusharmewara/loom/releases)

## Installation

```bash
brew tap tusharmewara/loom
brew install loom
```

The formula ships with pre-built bottles for **macOS** (ARM64 + x86_64) and **Linux** (x86_64).

## Usage

### Start the daemon

```bash
brew services start loom
```

This runs `loomd` as a background service with logs at:
- Standard log: `$(brew --prefix)/var/log/loomd.log`
- Error log: `$(brew --prefix)/var/log/loomd.err.log`

### Run commands

```bash
loom --help
loom init
loom skills list
loom mcp list
loom sessions list
```

### Stop the daemon

```bash
brew services stop loom
```

### Restart the daemon

```bash
brew services restart loom
```

## What is Loom?

Loom is a unified agentic ecosystem that enables seamless collaboration between multiple AI tools (jcode, crush, claude-code, opencode, goose, etc.) while sharing:

- **Skills** — write once, use everywhere
- **Sessions** — export from one tool, continue in another
- **MCP servers** — register once, share across tools
- **Credentials** — encrypted vault with ACLs
- **Hooks** — intercept and modify tool behavior
- **Knowledge Graph** — entities, relationships, and FTS5 search across sessions

For full documentation, visit the [main repo](https://github.com/tusharmewara/loom).

## Updating

When a new Loom release is published, bottles are uploaded as part of the release workflow. The formula is kept in sync via manual updates (see `release-bottle.sh` in the loom repo).

To update the formula checksums after a new release:

```bash
bash scripts/update_formula_checksums.sh <version>
```

## Formula

| File | Purpose |
|------|---------|
| `Formula/loom.rb` | Homebrew formula with bottle URLs for `arm64_tahoe`, `tahoe`, and `x86_64_linux` |
| `scripts/update_formula_checksums.sh` | Helper script to fetch bottles and update checksums |
| `.github/workflows/bottles.yml` | CI workflow to build and publish bottles on release |

## Binaries

This tap installs:

| Binary | Description |
|--------|-------------|
| `loom` | CLI with 20+ subcommands |
| `loomd` | Background daemon (auto-shutdown after 5 min idle) |

## Filesystem

Loom stores all data in `~/.loom/`:

```
~/.loom/
├── config.toml
├── config/
├── skills/
├── mcp/
├── sessions/
├── auth/
├── hooks/
├── knowledge/
└── tools/
```

## License

MIT

# homebrew-loom

Homebrew tap for [Loom] — the shared agentic ecosystem for AI tools.

## Installation

```bash
brew tap tusharmewara/loom
brew install --formula loom
```

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

you may request for full documentation.

## Updating

When a new Loom release is published, the [Update Formula Checksums](.github/workflows/update_checksums.yml) workflow automatically downloads the new bottles, computes SHA256 checksums, and updates `Formula/loom.rb`.

You can also trigger it manually:

```bash
bash scripts/update_formula_checksums.sh <version>
```

## Formula

| File | Purpose |
|------|---------|
| `Formula/loom.rb` | Homebrew formula with bottle URLs for arm64_sonoma and monterey |
| `scripts/update_formula_checksums.sh` | Helper script to fetch bottles and update checksums |
| `.github/workflows/update_checksums.yml` | GitHub Actions workflow for automatic checksum updates on release |

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
└── tools/
```

## License

MIT

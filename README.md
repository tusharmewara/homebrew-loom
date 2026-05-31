# homebrew-loom

Homebrew formula for [Loom](https://github.com/tusharmewara/loom) — the shared
ecosystem for AI coding tools.

[![Latest Release](https://img.shields.io/github/v/release/tusharmewara/loom?label=loom)](https://github.com/tusharmewara/loom/releases)

---

## The Problem

If you use multiple AI coding tools (Claude Code, jcode, Cursor, Goose, opencode,
crush...), you've probably noticed they don't share anything. Skills you install
in one are invisible to the rest. MCP servers need to be configured separately
each time. Sessions are locked inside whichever tool created them.

Loom is the **shared layer** between all of them.

## Quick Start

```bash
# Install
brew tap tusharmewara/loom
brew install loom

# Initialize the ecosystem (creates ~/.loom/)
loom init

# Optional-but-recommended: start the background daemon
brew services start loom
```

That's it. Run `loom status` to confirm everything is set up.

## First Steps

Once Loom is installed, these are the first things to try:

```bash
# See what Loom knows about — tools, skills, MCP servers
loom scan

# Check the health of your setup
loom doctor

# List installable MCP servers from the registry
loom mcp list-known

# Install one (e.g., Playwright for browser automation)
loom mcp install playwright

# List registered skills
loom skills list
```

Everything you add (MCP servers, skills, tools) becomes available to **every**
tool in your ecosystem — no per-tool configuration needed.

## Real-World Scenarios

### Share an MCP server across tools

```bash
# Install once
loom mcp install filesystem

# Use from any tool — Claude Code, jcode, Goose, etc. — all share it
# without needing separate configs
```

### Export a session and continue elsewhere

```bash
# After a session in any tool, export it to Loom's shared storage
loom sessions list
loom sessions export <session-id> --output session.jsonl

# Resume it in a different tool with full history
loom sessions resume <session-id> --provider anthropic --model claude-sonnet-4

# With knowledge injection, Loom enriches the resumed session with
# relevant context from past sessions
loom sessions resume <session-id> --inject-knowledge
```

### Route tasks to the right model automatically

```bash
# Loom scores complexity and picks the right tier
#   simple fixes → Slm (fast/cheap)
#   complex architecture → Flagship (slow/expensive)
loom routing evaluate "Write a Python script to parse this CSV"

# Override for a specific task when needed
loom routing override <task-id> --tier flagship --reason "needs deep reasoning"
```

## Daemon

The daemon (`loomd`) is a background service that keeps the ecosystem hot —
shared MCP connections, session indexing, event bus, knowledge graph — so CLI
commands start instantly. It auto-shuts down after 5 minutes idle.

```bash
brew services start loom     # Start
brew services stop loom      # Stop
brew services restart loom   # Restart
```

Without the daemon, `loom` still works — it just initializes subsystems on
demand, which is slightly slower.

## What Loom Provides

| Feature | What it does |
|---------|-------------|
| **Skills** | Write a skill once, use it from any tool. Skills are portable YAML files with structured prompts, auto-loaded by all tools. |
| **Sessions** | Export from one tool, resume in another. Full history + compression + compression for long sessions. |
| **MCP Servers** | Register once, share across every tool. Pooled connections with health checking. |
| **Auth & Credentials** | Encrypted credential vault with role-based ACLs and audit logging. |
| **Hooks** | Intercept tool actions (pre/post task, session events) with executable scripts. Signed for integrity. |
| **Knowledge Graph** | Entities and relationships extracted from session history. Powers search, recommendation, and context injection. |
| **Model Routing** | Automatic complexity scoring routes tasks to the right model tier (Slm / Mid / Flagship). |
| **Workflows** | Multi-phase task orchestration with phase transitions and manual overrides. |

## Command Reference

### Core
```
loom init                          Create ~/.loom/ tree
loom scan                          Display resource summary
loom status                        Show ecosystem state
loom doctor                        Deep diagnostics
loom exec <tools...> [-- args...]  Execute tools with ecosystem
loom tui                           Launch terminal UI
```

### MCP
```
loom mcp list                      List registered MCP servers
loom mcp show <id>                 Show MCP server config
loom mcp add <name>                Add MCP server stub
loom mcp install <name>            Install a known MCP server
loom mcp list-known                List installable MCP servers
```

### Skills
```
loom skills list                   List skills
loom skills show <name>            Show skill details
loom skills install <path>         Install skill from file
```

### Sessions
```
loom sessions list                 List sessions
loom sessions show <id>            Show session details
loom sessions export <id>          Export session
loom sessions resume <id>          Resume session
```

### Routing
```
loom routing evaluate <prompt>     Score prompt complexity
loom routing show                  Show routing config
```

### Knowledge
```
loom knowledge build               Build knowledge graph from sessions
loom knowledge query <entity>      Query subgraph around entity
loom knowledge search <query>      Search entities
```

### Daemon
```
loom daemon start                  Start loomd
loom daemon stop                   Stop loomd
loom daemon status                 Show daemon status
```

## Formula

| File | Purpose |
|------|---------|
| `Formula/loom.rb` | Homebrew formula with bottles for `arm64_tahoe`, `tahoe`, `x86_64_linux` |
| `scripts/update_formula_checksums.sh` | Fetch bottles and update checksums after a release |
| `.github/workflows/bottles.yml` | CI: build and publish bottles on release |

## Filesystem

```
~/.loom/
├── config.toml          # Main config
├── config/              # Layer overlays (routing, mcp, hooks, acp)
├── skills/              # Shared skills database
├── mcp/                 # MCP server configs
├── sessions/            # Session exports
├── auth/                # Encrypted vault + audit logs
├── hooks/               # Hook TOML configs and scripts
├── knowledge/           # Knowledge graph (SQLite + FTS5)
└── tools/               # Tool registration files
```

## License

MIT

#!/bin/bash
# KDP Author Engine — Quickstart
# Full setup for first-time and existing OpenClaw users.
# Installs OpenClaw if not present, configures it, then installs KDP Author Engine.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCLAW_STATE="$HOME/.openclaw"
DISCORD_INVITE="https://discord.gg/yGyXDwdHU9"

# ── Colours ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

banner() {
  echo ""
  echo -e "${CYAN}${BOLD}============================================${RESET}"
  echo -e "${CYAN}${BOLD}  KDP Author Engine — Quickstart${RESET}"
  echo -e "${CYAN}${BOLD}  6-Agent Book Pipeline for OpenClaw${RESET}"
  echo -e "${CYAN}${BOLD}============================================${RESET}"
  echo ""
}

step() { echo -e "\n${BOLD}▶ $1${RESET}"; }
ok()   { echo -e "  ${GREEN}✓${RESET} $1"; }
warn() { echo -e "  ${YELLOW}⚠${RESET}  $1"; }
err()  { echo -e "  ${RED}✗${RESET}  $1"; }
info() { echo -e "  ${CYAN}→${RESET} $1"; }

banner

# ── OS Detection ──────────────────────────────────────────────────────────────
OS="$(uname -s)"
if [[ "$OS" == "Darwin" ]]; then
  PKG_MANAGER="brew"
elif [[ "$OS" == "Linux" ]]; then
  if command -v apt &>/dev/null; then PKG_MANAGER="apt"
  elif command -v dnf &>/dev/null; then PKG_MANAGER="dnf"
  else PKG_MANAGER="unknown"; fi
else
  err "Unsupported OS: $OS. Use macOS, Linux, or Windows with WSL."
  exit 1
fi

# ── Step 1: Node.js ───────────────────────────────────────────────────────────
step "Checking Node.js"
if command -v node &>/dev/null; then
  NODE_VER=$(node --version)
  ok "Node.js found: $NODE_VER"
else
  warn "Node.js not found — installing..."
  if [[ "$PKG_MANAGER" == "brew" ]]; then
    brew install node
  elif [[ "$PKG_MANAGER" == "apt" ]]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    err "Could not auto-install Node.js. Visit https://nodejs.org and install it, then re-run this script."
    exit 1
  fi
  ok "Node.js installed: $(node --version)"
fi

# ── Step 2: jq ────────────────────────────────────────────────────────────────
step "Checking jq"
if command -v jq &>/dev/null; then
  ok "jq found: $(jq --version)"
else
  warn "jq not found — installing..."
  if [[ "$PKG_MANAGER" == "brew" ]]; then brew install jq
  elif [[ "$PKG_MANAGER" == "apt" ]]; then sudo apt-get install -y jq
  elif [[ "$PKG_MANAGER" == "dnf" ]]; then sudo dnf install -y jq
  else err "Install jq manually from https://jqlang.github.io/jq/ and re-run."; exit 1; fi
  ok "jq installed"
fi

# ── Step 3: pandoc ────────────────────────────────────────────────────────────
step "Checking pandoc"
if command -v pandoc &>/dev/null; then
  ok "pandoc found: $(pandoc --version | head -1)"
else
  warn "pandoc not found — installing (required for .docx export)..."
  if [[ "$PKG_MANAGER" == "brew" ]]; then brew install pandoc
  elif [[ "$PKG_MANAGER" == "apt" ]]; then sudo apt-get install -y pandoc
  elif [[ "$PKG_MANAGER" == "dnf" ]]; then sudo dnf install -y pandoc
  else warn "Install pandoc manually from https://pandoc.org/installing.html"; fi
  command -v pandoc &>/dev/null && ok "pandoc installed" || warn "pandoc install may have failed — install manually if .docx export fails"
fi

# ── Step 4: OpenClaw ──────────────────────────────────────────────────────────
step "Checking OpenClaw"
if command -v openclaw &>/dev/null; then
  OC_VER=$(openclaw --version 2>/dev/null || echo "installed")
  ok "OpenClaw found: $OC_VER"
  OPENCLAW_IS_NEW=false
else
  warn "OpenClaw not found — installing..."
  npm install -g openclaw
  ok "OpenClaw installed: $(openclaw --version 2>/dev/null || echo 'OK')"
  OPENCLAW_IS_NEW=true
fi

# ── Step 5: OpenClaw Configure (first-time users) ─────────────────────────────
step "OpenClaw Configuration"
if [[ "$OPENCLAW_IS_NEW" == true ]] || [ ! -f "$OPENCLAW_STATE/openclaw.json" ]; then
  echo ""
  echo -e "  ${BOLD}OpenClaw needs to be configured before we can continue.${RESET}"
  echo ""
  echo "  You'll need:"
  echo "   • Your Discord Bot Token"
  echo "     → discord.com/developers → Your App → Bot → Reset Token"
  echo "   • Your Discord Server (Guild) ID"
  echo "     → Right-click your server name → Copy Server ID"
  echo "     (Enable Developer Mode: User Settings → Advanced → Developer Mode)"
  echo ""
  echo "  The interactive setup will open now. Follow the prompts."
  echo "  When complete, this script will automatically continue."
  echo ""
  read -rp "  Press Enter to start OpenClaw configuration..." _
  openclaw configure
  ok "OpenClaw configured"
else
  ok "OpenClaw already configured — skipping"
fi

# ── Step 6: bookforge.config.json ─────────────────────────────────────────────
step "Checking KDP Author Engine configuration"
CONFIG="$SCRIPT_DIR/bookforge.config.json"

if [ ! -f "$CONFIG" ]; then
  err "bookforge.config.json not found in $SCRIPT_DIR"
  exit 1
fi

AUTHOR_NAME=$(jq -r '.author.name' "$CONFIG")
if [[ "$AUTHOR_NAME" == "Your Name" || "$AUTHOR_NAME" == "null" || -z "$AUTHOR_NAME" ]]; then
  echo ""
  echo -e "  ${YELLOW}bookforge.config.json has not been filled in yet.${RESET}"
  echo ""
  echo "  Open the file and fill in:"
  echo "   1. author.name, author.penName, author.bio"
  echo "   2. discord.guildId + all 6 channel IDs"
  echo "   3. Your model preferences (defaults are good to start)"
  echo "   4. Your book niches"
  echo ""
  echo "  How to get channel IDs:"
  echo "   Right-click each channel in Discord → Copy Channel ID"
  echo "   (Developer Mode must be on)"
  echo ""
  info "Edit: $CONFIG"
  echo ""
  read -rp "  Press Enter once you have filled in bookforge.config.json..." _

  # Re-check
  AUTHOR_NAME=$(jq -r '.author.name' "$CONFIG")
  if [[ "$AUTHOR_NAME" == "Your Name" || "$AUTHOR_NAME" == "null" || -z "$AUTHOR_NAME" ]]; then
    err "bookforge.config.json still has placeholder values. Fill it in and re-run this script."
    exit 1
  fi
fi

ok "Configuration looks good — Author: $AUTHOR_NAME"

# ── Step 7: Run setup.sh ──────────────────────────────────────────────────────
step "Configuring agent files (setup.sh)"
chmod +x "$SCRIPT_DIR/setup.sh"
"$SCRIPT_DIR/setup.sh"
ok "Agent files configured"

# ── Step 8: Install agent workspaces ─────────────────────────────────────────
step "Installing agent workspaces into OpenClaw"

AGENTS=(bookfinder author bookwriter editor publisher marketer)
for AGENT in "${AGENTS[@]}"; do
  SRC="$SCRIPT_DIR/agents/$AGENT"
  DEST="$OPENCLAW_STATE/agents-workspaces/$AGENT"
  if [ -d "$SRC" ]; then
    mkdir -p "$DEST"
    cp -r "$SRC/." "$DEST/"
    ok "$AGENT workspace installed"
  else
    warn "$AGENT workspace not found at $SRC — skipping"
  fi
done

# ── Step 9: Install skill bundle ──────────────────────────────────────────────
step "Installing book-author skill"
SKILL_SRC="$SCRIPT_DIR/skills/book-author"
SKILL_DEST="$OPENCLAW_STATE/skills/book-author"
if [ -d "$SKILL_SRC" ]; then
  mkdir -p "$SKILL_DEST"
  cp -r "$SKILL_SRC/." "$SKILL_DEST/"
  ok "book-author skill installed"
else
  warn "Skill directory not found — skipping"
fi

# ── Step 10: Install workflow files ───────────────────────────────────────────
step "Installing pipeline workflow files"
WORKFLOW_DEST="$OPENCLAW_STATE/agents-workspaces/author"
mkdir -p "$WORKFLOW_DEST"
cp "$SCRIPT_DIR/workflow/BOOK_PIPELINE_WORKFLOW.md" "$WORKFLOW_DEST/"
cp "$SCRIPT_DIR/workflow/BOOK-PIPELINE-TEMPLATE.md" "$WORKFLOW_DEST/BOOK-PIPELINE.md"
ok "Workflow files installed"

# ── Step 11: Register agents in openclaw.json ─────────────────────────────────
step "Registering agents in openclaw.json"

OC_CONFIG="$OPENCLAW_STATE/openclaw.json"

if [ ! -f "$OC_CONFIG" ]; then
  warn "openclaw.json not found — run 'openclaw configure' first, then re-run this script"
else
  # Read channel IDs and model config from bookforge.config.json
  CH_BOOKFINDER=$(jq -r '.discord.channels.bookfinder' "$CONFIG")
  CH_AUTHOR=$(jq -r '.discord.channels.author' "$CONFIG")
  CH_BOOKWRITER=$(jq -r '.discord.channels.bookwriter' "$CONFIG")
  CH_EDITOR=$(jq -r '.discord.channels.editor' "$CONFIG")
  CH_PUBLISHER=$(jq -r '.discord.channels.publisher' "$CONFIG")
  CH_MARKETER=$(jq -r '.discord.channels.marketer' "$CONFIG")
  GUILD_ID=$(jq -r '.discord.guildId' "$CONFIG")
  OWNER_ID=$(jq -r '.discord.ownerId' "$CONFIG")

  MODEL_RESEARCH=$(jq -r '.models.researcher.primary' "$CONFIG")
  MODEL_ORCH=$(jq -r '.models.orchestrator.primary' "$CONFIG")
  MODEL_WRITER=$(jq -r '.models.writer.primary' "$CONFIG")
  MODEL_EDITOR=$(jq -r '.models.editor.primary' "$CONFIG")
  MODEL_PUB=$(jq -r '.models.publisher.primary' "$CONFIG")
  MODEL_MARKET=$(jq -r '.models.marketer.primary' "$CONFIG")

  # Build the 6 agent entries as a jq expression
  NEW_AGENTS=$(jq -n \
    --arg bf_id "bookfinder" --arg bf_model "$MODEL_RESEARCH" \
    --arg au_id "author"     --arg au_model "$MODEL_ORCH" \
    --arg bw_id "bookwriter" --arg bw_model "$MODEL_WRITER" \
    --arg ed_id "editor"     --arg ed_model "$MODEL_EDITOR" \
    --arg pb_id "publisher"  --arg pb_model "$MODEL_PUB" \
    --arg mk_id "marketer"   --arg mk_model "$MODEL_MARKET" \
    --arg state "$OPENCLAW_STATE" \
    '[
      {"id":$bf_id,"name":"Bookfinder","workspace":($state+"/agents-workspaces/bookfinder"),"agentDir":($state+"/agents/bookfinder/agent"),"model":{"primary":$bf_model},"identity":{"name":"Bookfinder","theme":"Book Market Research","emoji":"🔎"}},
      {"id":$au_id,"name":"Author","workspace":($state+"/agents-workspaces/author"),"agentDir":($state+"/agents/author/agent"),"model":{"primary":$au_model},"identity":{"name":"Author","theme":"Pipeline Orchestrator","emoji":"📖"}},
      {"id":$bw_id,"name":"Bookwriter","workspace":($state+"/agents-workspaces/bookwriter"),"agentDir":($state+"/agents/bookwriter/agent"),"model":{"primary":$bw_model},"identity":{"name":"Bookwriter","theme":"Chapter Drafting","emoji":"✍️"}},
      {"id":$ed_id,"name":"Editor","workspace":($state+"/agents-workspaces/editor"),"agentDir":($state+"/agents/editor/agent"),"model":{"primary":$ed_model},"identity":{"name":"Editor","theme":"Quality Review","emoji":"✏️"}},
      {"id":$pb_id,"name":"Publisher","workspace":($state+"/agents-workspaces/publisher"),"agentDir":($state+"/agents/publisher/agent"),"model":{"primary":$pb_model},"identity":{"name":"Publisher","theme":"KDP Publishing","emoji":"🚀"}},
      {"id":$mk_id,"name":"Marketer","workspace":($state+"/agents-workspaces/marketer"),"agentDir":($state+"/agents/marketer/agent"),"model":{"primary":$mk_model},"identity":{"name":"Marketer","theme":"Launch & Marketing","emoji":"📣"}}
    ]')

  # Build Discord bindings for all 6 agents
  NEW_BINDINGS=$(jq -n \
    --arg bf "$CH_BOOKFINDER" --arg au "$CH_AUTHOR" --arg bw "$CH_BOOKWRITER" \
    --arg ed "$CH_EDITOR" --arg pb "$CH_PUBLISHER" --arg mk "$CH_MARKETER" \
    '[
      {"agentId":"bookfinder","match":{"channel":"discord","peer":{"kind":"channel","id":$bf}}},
      {"agentId":"author","match":{"channel":"discord","peer":{"kind":"channel","id":$au}}},
      {"agentId":"bookwriter","match":{"channel":"discord","peer":{"kind":"channel","id":$bw}}},
      {"agentId":"editor","match":{"channel":"discord","peer":{"kind":"channel","id":$ed}}},
      {"agentId":"publisher","match":{"channel":"discord","peer":{"kind":"channel","id":$pb}}},
      {"agentId":"marketer","match":{"channel":"discord","peer":{"kind":"channel","id":$mk}}}
    ]')

  # Merge into openclaw.json
  TEMP_CONFIG=$(mktemp)
  jq \
    --argjson newAgents "$NEW_AGENTS" \
    --argjson newBindings "$NEW_BINDINGS" \
    --arg guild "$GUILD_ID" \
    --arg bf "$CH_BOOKFINDER" --arg au "$CH_AUTHOR" --arg bw "$CH_BOOKWRITER" \
    --arg ed "$CH_EDITOR" --arg pb "$CH_PUBLISHER" --arg mk "$CH_MARKETER" \
    '
    # Add agents (skip if id already exists)
    .agents.list = (
      (.agents.list // []) +
      ($newAgents | map(select(.id as $id | ((.agents.list // []) | map(.id) | index($id)) == null)))
    ) |
    # Add bindings (skip if agentId already bound)
    .agents.bindings = (
      (.agents.bindings // []) +
      ($newBindings | map(select(.agentId as $aid | ((.agents.bindings // []) | map(.agentId) | index($aid)) == null)))
    ) |
    # Enable guild channels
    .channels.discord.guilds[$guild].channels[$bf].enabled = true |
    .channels.discord.guilds[$guild].channels[$au].enabled = true |
    .channels.discord.guilds[$guild].channels[$bw].enabled = true |
    .channels.discord.guilds[$guild].channels[$ed].enabled = true |
    .channels.discord.guilds[$guild].channels[$pb].enabled = true |
    .channels.discord.guilds[$guild].channels[$mk].enabled = true
    ' "$OC_CONFIG" > "$TEMP_CONFIG"

  if jq empty "$TEMP_CONFIG" 2>/dev/null; then
    cp "$TEMP_CONFIG" "$OC_CONFIG"
    ok "All 6 agents registered in openclaw.json"
    ok "Discord channel bindings added"
    ok "Guild channels enabled"
  else
    warn "openclaw.json update failed — JSON validation error. Check the config manually."
    rm -f "$TEMP_CONFIG"
  fi
  rm -f "$TEMP_CONFIG"
fi

# ── Step 12: Create agent directories ─────────────────────────────────────────
step "Creating agent runtime directories"
for AGENT in bookfinder author bookwriter editor publisher marketer; do
  mkdir -p "$OPENCLAW_STATE/agents/$AGENT/agent"
  ok "$AGENT runtime directory ready"
done

# ── Step 13: Import cron job ──────────────────────────────────────────────────
step "Setting up weekly Bookfinder scan"
CRON_FILE="$SCRIPT_DIR/cron/bookfinder-weekly-scan.json"
if [ -f "$CRON_FILE" ]; then
  openclaw cron import "$CRON_FILE" 2>/dev/null && ok "Weekly scan cron job imported" || warn "Cron import failed — run manually: openclaw cron import cron/bookfinder-weekly-scan.json"
else
  warn "Cron file not found — skipping"
fi

# ── Step 14: Restart OpenClaw ─────────────────────────────────────────────────
step "Restarting OpenClaw"
openclaw restart 2>/dev/null && ok "OpenClaw restarted" || warn "Could not restart automatically — run: openclaw restart"

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}============================================${RESET}"
echo -e "${GREEN}${BOLD}  ✓ KDP Author Engine is LIVE              ${RESET}"
echo -e "${GREEN}${BOLD}============================================${RESET}"
echo ""
echo -e "  ${BOLD}Your 6 agents are running:${RESET}"
echo "   🔎 Bookfinder  — market research, weekly scans"
echo "   📖 Author      — pipeline orchestrator"
echo "   ✍️  Bookwriter  — chapter drafting"
echo "   ✏️  Editor      — 6-dimension quality scoring"
echo "   🚀 Publisher   — KDP formatting & metadata"
echo "   📣 Marketer    — launch, ads, performance"
echo ""
echo -e "  ${BOLD}Your first action:${RESET}"
echo "   Message #bookfinder in Discord:"
echo '   "Run your first weekly market scan."'
echo ""
echo -e "  ${BOLD}Join the community:${RESET}"
echo "   The Integrative Builder Discord — support, tips, wins"
echo "   $DISCORD_INVITE"
echo ""
echo -e "  ${BOLD}Setup guide + FAQ:${RESET}"
echo "   #kdp-setup-help in The Integrative Builder"
echo ""
echo "  Happy publishing! 📖"
echo ""

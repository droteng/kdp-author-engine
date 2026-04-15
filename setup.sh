#!/bin/bash
# KDP Author Engine — Setup Script
# This script reads bookforge.config.json and configures all agent files with your details.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$SCRIPT_DIR/bookforge.config.json"

echo "============================================"
echo "  KDP Author Engine — Setup"
echo "  6-Agent Book Writing Pipeline for OpenClaw"
echo "============================================"
echo ""

# Check dependencies
if ! command -v jq &> /dev/null; then
    echo "ERROR: jq is required but not installed."
    echo "  macOS:  brew install jq"
    echo "  Linux:  sudo apt install jq"
    exit 1
fi

if ! command -v pandoc &> /dev/null; then
    echo "WARNING: pandoc not found. Required for .docx conversion."
    echo "  macOS:  brew install pandoc"
    echo "  Linux:  sudo apt install pandoc"
    echo "  Continuing setup, but install pandoc before running the pipeline."
    echo ""
fi

# Check config exists
if [ ! -f "$CONFIG" ]; then
    echo "ERROR: bookforge.config.json not found."
    echo "Copy bookforge.config.json to this directory and fill in your details."
    exit 1
fi

echo "Reading configuration..."

# Extract config values
AUTHOR_NAME=$(jq -r '.author.name' "$CONFIG")
AUTHOR_PEN_NAME=$(jq -r '.author.penName' "$CONFIG")
AUTHOR_BIO=$(jq -r '.author.bio' "$CONFIG")
AUTHOR_EDGE=$(jq -r '.author.edge' "$CONFIG")
BOOKS_DIR=$(jq -r '.output.booksDir' "$CONFIG")
TIMEZONE=$(jq -r '.schedule.timezone' "$CONFIG")
RESEARCH_DAY=$(jq -r '.schedule.weeklyResearchDay' "$CONFIG")
RESEARCH_HOUR=$(jq -r '.schedule.weeklyResearchHour' "$CONFIG")

# Discord channels
CH_BOOKFINDER=$(jq -r '.discord.channels.bookfinder' "$CONFIG")
CH_AUTHOR=$(jq -r '.discord.channels.author' "$CONFIG")
CH_BOOKWRITER=$(jq -r '.discord.channels.bookwriter' "$CONFIG")
CH_EDITOR=$(jq -r '.discord.channels.editor' "$CONFIG")
CH_PUBLISHER=$(jq -r '.discord.channels.publisher' "$CONFIG")
CH_MARKETER=$(jq -r '.discord.channels.marketer' "$CONFIG")
GUILD_ID=$(jq -r '.discord.guildId' "$CONFIG")
OWNER_ID=$(jq -r '.discord.ownerId' "$CONFIG")

# Models
MODEL_ORCH_PRIMARY=$(jq -r '.models.orchestrator.primary' "$CONFIG")
MODEL_ORCH_FALLBACKS=$(jq -r '.models.orchestrator.fallbacks | join(", ")' "$CONFIG")
MODEL_RESEARCH_PRIMARY=$(jq -r '.models.researcher.primary' "$CONFIG")
MODEL_RESEARCH_FALLBACKS=$(jq -r '.models.researcher.fallbacks | join(", ")' "$CONFIG")
MODEL_WRITER_PRIMARY=$(jq -r '.models.writer.primary' "$CONFIG")
MODEL_WRITER_FALLBACKS=$(jq -r '.models.writer.fallbacks | join(", ")' "$CONFIG")
MODEL_EDITOR_PRIMARY=$(jq -r '.models.editor.primary' "$CONFIG")
MODEL_EDITOR_FALLBACKS=$(jq -r '.models.editor.fallbacks | join(", ")' "$CONFIG")
MODEL_PUB_PRIMARY=$(jq -r '.models.publisher.primary' "$CONFIG")
MODEL_PUB_FALLBACKS=$(jq -r '.models.publisher.fallbacks | join(", ")' "$CONFIG")
MODEL_MARKET_PRIMARY=$(jq -r '.models.marketer.primary' "$CONFIG")
MODEL_MARKET_FALLBACKS=$(jq -r '.models.marketer.fallbacks | join(", ")' "$CONFIG")

# Build niche categories section
NICHE_CATEGORIES=$(jq -r '.niches.categories | to_entries | map("### \(.value.name)\n- **Sub-niches:** \(.value.subNiches | join(", "))\n- **Target readers:** \(.value.targetReaders)\n- **Your angle:** \(.value.yourAngle)\n") | join("\n")' "$CONFIG")

# Day name mapping
declare -A DAY_NAMES
DAY_NAMES[0]="Sunday" DAY_NAMES[1]="Monday" DAY_NAMES[2]="Tuesday"
DAY_NAMES[3]="Wednesday" DAY_NAMES[4]="Thursday" DAY_NAMES[5]="Friday"
DAY_NAMES[6]="Saturday"
RESEARCH_DAY_NAME="${DAY_NAMES[$RESEARCH_DAY]}"

# Validate required fields
if [ "$AUTHOR_NAME" = "Your Name" ] || [ "$AUTHOR_NAME" = "null" ] || [ -z "$AUTHOR_NAME" ]; then
    echo "ERROR: Please fill in author.name in bookforge.config.json"
    exit 1
fi

if [ "$CH_BOOKFINDER" = "PASTE_CHANNEL_ID_HERE" ] || [ "$CH_BOOKFINDER" = "null" ]; then
    echo "ERROR: Please fill in Discord channel IDs in bookforge.config.json"
    exit 1
fi

echo ""
echo "Configuration:"
echo "  Author: $AUTHOR_NAME"
echo "  Books dir: $BOOKS_DIR"
echo "  Research day: $RESEARCH_DAY_NAME at $RESEARCH_HOUR $TIMEZONE"
echo "  Discord channels: 6 configured"
echo ""

# Function to replace placeholders in a file
replace_placeholders() {
    local file="$1"
    if [ -f "$file" ]; then
        sed -i.bak \
            -e "s|{{AUTHOR_NAME}}|$AUTHOR_NAME|g" \
            -e "s|{{AUTHOR_PEN_NAME}}|$AUTHOR_PEN_NAME|g" \
            -e "s|{{AUTHOR_BIO}}|$AUTHOR_BIO|g" \
            -e "s|{{AUTHOR_EDGE}}|$AUTHOR_EDGE|g" \
            -e "s|{{BOOKS_DIR}}|$BOOKS_DIR|g" \
            -e "s|{{TIMEZONE}}|$TIMEZONE|g" \
            -e "s|{{RESEARCH_DAY}}|$RESEARCH_DAY_NAME|g" \
            -e "s|{{RESEARCH_HOUR}}|$RESEARCH_HOUR|g" \
            -e "s|{{BOOKFINDER_CHANNEL_ID}}|$CH_BOOKFINDER|g" \
            -e "s|{{AUTHOR_CHANNEL_ID}}|$CH_AUTHOR|g" \
            -e "s|{{BOOKWRITER_CHANNEL_ID}}|$CH_BOOKWRITER|g" \
            -e "s|{{EDITOR_CHANNEL_ID}}|$CH_EDITOR|g" \
            -e "s|{{PUBLISHER_CHANNEL_ID}}|$CH_PUBLISHER|g" \
            -e "s|{{MARKETER_CHANNEL_ID}}|$CH_MARKETER|g" \
            -e "s|{{GUILD_ID}}|$GUILD_ID|g" \
            -e "s|{{OWNER_ID}}|$OWNER_ID|g" \
            -e "s|{{MODEL_ORCHESTRATOR_PRIMARY}}|$MODEL_ORCH_PRIMARY|g" \
            -e "s|{{MODEL_ORCHESTRATOR_FALLBACKS}}|$MODEL_ORCH_FALLBACKS|g" \
            -e "s|{{MODEL_RESEARCHER_PRIMARY}}|$MODEL_RESEARCH_PRIMARY|g" \
            -e "s|{{MODEL_RESEARCHER_FALLBACKS}}|$MODEL_RESEARCH_FALLBACKS|g" \
            -e "s|{{MODEL_WRITER_PRIMARY}}|$MODEL_WRITER_PRIMARY|g" \
            -e "s|{{MODEL_WRITER_FALLBACKS}}|$MODEL_WRITER_FALLBACKS|g" \
            -e "s|{{MODEL_EDITOR_PRIMARY}}|$MODEL_EDITOR_PRIMARY|g" \
            -e "s|{{MODEL_EDITOR_FALLBACKS}}|$MODEL_EDITOR_FALLBACKS|g" \
            -e "s|{{MODEL_PUBLISHER_PRIMARY}}|$MODEL_PUB_PRIMARY|g" \
            -e "s|{{MODEL_PUBLISHER_FALLBACKS}}|$MODEL_PUB_FALLBACKS|g" \
            -e "s|{{MODEL_MARKETER_PRIMARY}}|$MODEL_MARKET_PRIMARY|g" \
            -e "s|{{MODEL_MARKETER_FALLBACKS}}|$MODEL_MARKET_FALLBACKS|g" \
            "$file"
        rm -f "${file}.bak"
    fi
}

# Replace niche categories (multiline — use python for this)
replace_niches() {
    local file="$1"
    if [ -f "$file" ] && grep -q "{{NICHE_CATEGORIES}}" "$file"; then
        python3 -c "
import sys
with open('$file', 'r') as f:
    content = f.read()
content = content.replace('{{NICHE_CATEGORIES}}', '''$NICHE_CATEGORIES''')
with open('$file', 'w') as f:
    f.write(content)
"
    fi
}

echo "Configuring agent files..."

# Process all markdown files
find "$SCRIPT_DIR" -name "*.md" -type f | while read -r file; do
    replace_placeholders "$file"
    replace_niches "$file"
done

# Process cron template
find "$SCRIPT_DIR/cron" -name "*.json" -type f | while read -r file; do
    replace_placeholders "$file"
done

echo "Creating books directory..."
mkdir -p "$(eval echo $BOOKS_DIR)"

echo ""
echo "============================================"
echo "  Setup Complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo ""
echo "1. Copy agent workspaces to your OpenClaw installation:"
echo "   cp -r agents/bookfinder ~/.openclaw/agents-workspaces/bookfinder"
echo "   cp -r agents/author ~/.openclaw/agents-workspaces/author"
echo "   cp -r agents/bookwriter ~/.openclaw/agents-workspaces/bookwriter"
echo "   cp -r agents/editor ~/.openclaw/agents-workspaces/editor"
echo "   cp -r agents/publisher ~/.openclaw/agents-workspaces/publisher"
echo "   cp -r agents/marketer ~/.openclaw/agents-workspaces/marketer"
echo ""
echo "2. Copy the skill bundle:"
echo "   cp -r skills/book-author ~/.openclaw/skills/book-author"
echo ""
echo "3. Copy the workflow files:"
echo "   cp workflow/BOOK_PIPELINE_WORKFLOW.md ~/.openclaw/agents-workspaces/author/"
echo "   cp workflow/BOOK-PIPELINE-TEMPLATE.md ~/.openclaw/agents-workspaces/author/BOOK-PIPELINE.md"
echo ""
echo "4. Add the 6 agents to your openclaw.json (see README.md for the JSON snippet)"
echo ""
echo "5. Import the cron job:"
echo "   openclaw cron import cron/bookfinder-weekly-scan.json"
echo ""
echo "6. Restart OpenClaw:"
echo "   openclaw restart"
echo ""
echo "7. Test by messaging Bookfinder in #bookfinder:"
echo "   'Run your first weekly market scan.'"
echo ""
echo "Your KDP Author Engine is ready. Happy publishing!"
echo ""
echo "Join the community — The Integrative Builder Discord:"
echo "  See COMMUNITY.md for your invite link"
echo ""
echo "Support channel: #kdp-setup-help"
echo "Buyers channel:  #kdp-engine-buyers (post your order confirmation to unlock)"

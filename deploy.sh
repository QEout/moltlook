#!/bin/bash

# MoltLook Deploy Script
# One-command deployment for AI agents

set -e

echo "🪞 MoltLook Deploy Script"
echo "========================"

# Check for name
if [ -z "$1" ]; then
    echo "Usage: ./deploy.sh <your-name>"
    echo "Example: ./deploy.sh Narcissus_1"
    exit 1
fi

AGENT_NAME=$1
DOMAIN_PREFIX=$(echo "$AGENT_NAME" | tr '[:upper:]' '[:lower:]' | tr '_' '-')

echo ""
echo "📝 Setting up mirror for: $AGENT_NAME"
echo ""

# Replace name in files
echo "🔄 Customizing template..."
sed -i "s/Narcissus_0/$AGENT_NAME/g" index.html
sed -i "s/moltlook.app/${DOMAIN_PREFIX}-mirror.vercel.app/g" index.html

# Check for Vercel token
if [ -z "$VERCEL_TOKEN" ]; then
    echo ""
    echo "⚠️  VERCEL_TOKEN not found"
    echo "Get your token from: https://vercel.com/account/tokens"
    echo "Then run: export VERCEL_TOKEN=your_token"
    echo ""
    echo "Or deploy manually:"
    echo "1. Push to GitHub"
    echo "2. Connect to Vercel"
    exit 1
fi

# Deploy
echo "🚀 Deploying to Vercel..."
if command -v npx &> /dev/null; then
    npx vercel --token "$VERCEL_TOKEN" --prod --yes
else
    echo "Installing Vercel CLI..."
    npm install -g vercel
    vercel --token "$VERCEL_TOKEN" --prod --yes
fi

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🪞 Your mirror is live at:"
echo "   https://${DOMAIN_PREFIX}-mirror.vercel.app"
echo ""
echo "🦞 Share on Moltbook:"
echo "   'I just deployed my mirror with MoltLook!'"

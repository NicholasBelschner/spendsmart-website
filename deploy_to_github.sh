#!/bin/bash
# Deploy SpendSmart website to GitHub Pages
# GitHub Username: NicholasBelschner

set -e  # Exit on error

REPO_NAME="spendsmart-website"
GITHUB_USER="NicholasBelschner"
WEBSITE_DIR="/Users/nicholasbelschner/Documents/InvestExpenses/website"

echo "🚀 Deploying SpendSmart website to GitHub Pages"
echo "================================================"
echo ""

# Check if we're in the right directory
cd "$WEBSITE_DIR"

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    git branch -M main
else
    echo "✓ Git repository already initialized"
fi

# Check if remote exists
if git remote get-url origin >/dev/null 2>&1; then
    echo "✓ Remote already configured"
    CURRENT_REMOTE=$(git remote get-url origin)
    echo "  Current remote: $CURRENT_REMOTE"
else
    echo "🔗 Setting up GitHub remote..."
    git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git" 2>/dev/null || {
        echo "⚠ Remote might already exist, continuing..."
    }
fi

# Add all files
echo "📝 Adding files..."
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "ℹ No changes to commit"
else
    echo "💾 Committing changes..."
    git commit -m "Deploy SpendSmart website" || {
        echo "⚠ No changes to commit, continuing..."
    }
fi

# Check if repository exists on GitHub
echo ""
echo "🔍 Checking if repository exists on GitHub..."
if curl -s -o /dev/null -w "%{http_code}" "https://github.com/$GITHUB_USER/$REPO_NAME" | grep -q "200"; then
    echo "✓ Repository exists on GitHub"
else
    echo ""
    echo "⚠ Repository doesn't exist yet on GitHub"
    echo ""
    echo "Please create it first:"
    echo "1. Go to: https://github.com/new"
    echo "2. Repository name: $REPO_NAME"
    echo "3. Make it PUBLIC (required for free GitHub Pages)"
    echo "4. DO NOT initialize with README, .gitignore, or license"
    echo "5. Click 'Create repository'"
    echo ""
    read -p "Press Enter after you've created the repository..."
fi

# Push to GitHub
echo ""
echo "📤 Pushing to GitHub..."
echo "You may be prompted for GitHub credentials"
echo ""

# Try to push
if git push -u origin main 2>&1 | grep -q "error\|fatal"; then
    echo ""
    echo "⚠ Push failed. This might be because:"
    echo "  1. Repository doesn't exist (create it first)"
    echo "  2. Authentication needed (use GitHub CLI or personal access token)"
    echo ""
    echo "Alternative: Push manually with:"
    echo "  cd $WEBSITE_DIR"
    echo "  git push -u origin main"
else
    echo "✓ Successfully pushed to GitHub!"
fi

echo ""
echo "================================================"
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Go to: https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
echo "2. Under 'Source', select:"
echo "   - Branch: main"
echo "   - Folder: / (root)"
echo "3. Click 'Save'"
echo ""
echo "Your website will be available at:"
echo "  https://$GITHUB_USER.github.io/$REPO_NAME"
echo ""
echo "Privacy Policy URL:"
echo "  https://$GITHUB_USER.github.io/$REPO_NAME/privacy-policy.html"
echo ""


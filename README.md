# SpendSmart Website

Simple static website for the SpendSmart iOS app.

## Quick Deploy to GitHub Pages

Run the deployment script:

```bash
./deploy_to_github.sh
```

Or manually:

```bash
git init
git add .
git commit -m "Initial website"
git branch -M main
git remote add origin https://github.com/NicholasBelschner/spendsmart-website.git
git push -u origin main
```

Then enable GitHub Pages:
1. Go to: https://github.com/NicholasBelschner/spendsmart-website/settings/pages
2. Source: `main` branch, `/ (root)` folder
3. Save

Your site will be at: `https://nicholasbelschner.github.io/spendsmart-website`

## Files

- `index.html` - Homepage
- `privacy-policy.html` - Privacy policy page
- `DEPLOY_INSTRUCTIONS.md` - Detailed deployment guide

## Customization

Before deploying, update:
- Email address in `privacy-policy.html`
- App Store badge/link in `index.html` (when available)
- Contact information


# GitHub Pages Setup Instructions

To enable GitHub Pages for this repository and make the game playable online, follow these steps:

## Prerequisites
- You must have admin access to the repository
- The repository must be public (or you must have GitHub Pro/Team for private repos with Pages)

## Setup Steps

1. **Go to Repository Settings**
   - Navigate to your repository on GitHub
   - Click on "Settings" tab

2. **Enable GitHub Pages**
   - In the left sidebar, click on "Pages"
   - Under "Build and deployment":
     - Source: Select "GitHub Actions"
   - Click "Save"

3. **Verify Workflow Permissions**
   - In Settings, go to "Actions" → "General"
   - Scroll to "Workflow permissions"
   - Ensure "Read and write permissions" is selected
   - Check "Allow GitHub Actions to create and approve pull requests"
   - Click "Save"

4. **Trigger the Build**
   - The workflow will automatically run when you push to the `main` branch
   - Or you can manually trigger it:
     - Go to "Actions" tab
     - Select "Build and Deploy to GitHub Pages"
     - Click "Run workflow"
     - Select the `main` branch
     - Click "Run workflow"

5. **Access Your Game**
   - Once the workflow completes successfully
   - Your game will be available at: `https://<username>.github.io/<repository-name>/`
   - For this repository: `https://kabuumu.github.io/godot-platformer/`

## Troubleshooting

### Workflow fails with "403" or permission errors
- Check that GitHub Pages is enabled in Settings → Pages
- Verify workflow permissions in Settings → Actions → General

### Game doesn't load or shows errors
- Check the browser console for error messages
- Ensure all assets loaded correctly
- Verify the export_presets.cfg is properly configured

### Need to rebuild
- Go to Actions tab
- Select the most recent workflow run
- Click "Re-run all jobs"

## Notes

- The first deployment may take a few minutes to become available
- Changes pushed to `main` branch will automatically trigger a new build and deployment
- The game will always reflect the latest version from the `main` branch

#!/bin/bash

# Stop execution if any command fails
set -e

# Clean the Hexo generated files
echo "Cleaning Hexo generated files..."
hexo clean

# Generate and deploy the Hexo static files
echo "Generating and deploying Hexo files..."
hexo deploy --generate

# Stage all changes in Git
echo "Staging all changes for Git..."
git add .

# Commit changes with a default message
echo "Committing changes..."
git commit -m "Blog source update"

# Push changes to the remote repository
echo "Pushing changes to Git..."
git push

# Success message
echo "Deployment complete!"

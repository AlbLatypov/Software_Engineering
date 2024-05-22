# GIT HOOKS

### Решение 1


### Решение 2

Here's how to create and test a post-update Git hook for automatic release tagging:

1. Create the Post-Update Hook

 - Navigate to your Git repository's .git/hooks directory:

Create a new file named post-update (no file extension):

- touch post-update

Open the post-update file with your favorite text editor and add the following script:
```bash
#!/bin/bash

# Check if the push was to the 'master' branch
if [[ "$1" == "refs/heads/master" ]]; then
    # Get the current date in YYYY-MM-DD format
    release_date=$(date +%Y-%m-%d)

    # Construct the release tag name
    tag_name="release-${release_date}"

    # Create the annotated tag with a message
    git tag -a "$tag_name" -m "Automated release for ${release_date}"

    # Push the tag to the remote repository
    git push origin "$tag_name"

    echo "Created and pushed release tag: $tag_name"
fi
```
2. Make the Hook Executable

    Set the execute permissions for the post-update script:

    `chmod +x post-update`

3. Test the Hook

    Make a Change: Commit a small change to your repository (e.g., update the README or a comment in your code).

    Push to Master: Push your changes to the master branch:

`git push origin master`

Verify the Tag: Check your Git repository's tags (locally and on the remote) to confirm that the release tag was created with the correct date:

`git tag`

(Verify on remote if needed)

`git fetch --tags 

Explanation

post-update Hook: This hook is triggered after a successful push to the repository.
Branch Check: The if [[ "$1" == "refs/heads/master" ]] line ensures the tag creation only happens for pushes to the master branch.
Date Formatting: The date +%Y-%m-%d command gets the current date in the desired format.
Tag Creation: The git tag command creates an annotated tag (with -a) for better tracking.
Pushing the Tag: The git push origin "$tag_name" command pushes the newly created tag to the remote repository.

Important Note: This script assumes you are pushing directly to the master branch. If you use a different workflow (e.g., pull requests, feature branches), you'll need to adapt the if condition to trigger the tag creation at the appropriate point in your workflow.

# Решение 2

To create a post-update hook in a Git repository that automatically tags a release with the current date whenever changes are pushed to the master branch, you can follow these steps:

1. Go to your Git repository

Open a terminal and navigate to your Git repository:

cd /path/to/your/repository

2. Create the post-update

Git hooks are located in the hooks subdirectory of the .git directory. You need to create a script named post-update:
```bash
cd .git/hooks
touch post-update
chmod +x post-update
```
This makes the post-update file executable.
3. Edit the post-update hook

Add the following script to the file:
```bash
#!/bin/sh

# Identify the branch being pushed
while read oldrev newrev refname
do
    branch=$(git rev-parse --symbolic --abbrev-ref $refname)
    if [ "master" = "$branch" ]; then
        # Create a tag with the current date
        DATE=$(date +%Y-%m-%d)
        TAG_NAME="release-$DATE"
        git tag -a $TAG_NAME $newrev -m "Release on $DATE"
        echo "Tagged release: $TAG_NAME"
    fi
done
```
4. Save and close the editor

5. Test the hook

To test the hook, first, make a change in your repository on the master branch, commit it, and then push it to the repository.

__Make sure you're on the master branch__

`git checkout master`

__Make a change__

`echo "Update on $(date)" >> testfile.txt`
`git add testfile.txt`
`git commit -m "Test post-update hook"`

__Push the change__

`git push origin master`

After pushing, you should see the output indicating that a tag has been created with today's date.

6. Verify the tag creation

Check if the tag has been created by listing the tags:

`git tag`

You should see the tag named release-YYYY-MM-DD with today's date.
Notes:

    Ensure the server where the repository is hosted supports hooks.
    This hook script assumes you are using a Unix-like environment for the date command.
    Make sure the git command is available and that the user who pushes the code has enough permissions to create tags in the repository.
    If you are using a centralized repository host like GitHub or GitLab, you might need to use a different approach to trigger actions like this, such as using webhooks and CI/CD pipelines, since custom Git hooks won't run on these platforms.

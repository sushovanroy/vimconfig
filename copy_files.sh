#!/bin/bash

# Config
SRC_VIM="$HOME/.vim"
SRC_VIMRC="$HOME/.vimrc"
DEST="/home/sushovan/work/sushovan_git_depot/vim/VimFiles"
DEST_VIM="$DEST/.vim"
DEST_VIMRC="$DEST/.vimrc"
DRY_RUN=true  # Set to true to simulate only


echo "***************************"
echo "Source folder       $SRC_VIM"
echo "***************************"
echo "Source .vimrc       $SRC_VIMRC"
echo "***************************"
echo "Destination folder  $DEST_VIM"
echo "***************************"
echo "Destination .vimrc  $DEST_VIMRC"
echo "***************************"

if [ "$DRY_RUN" = true ]; then
    echo "ℹ️ Note: Dry-run flag is enabled. No actual Copy is performed."
    exit 0
fi


# Check if destination exists
if [ ! -d "$DEST" ]; then
    echo "❌ Error: Destination directory $DEST does not exist."
    exit 1
fi

# Check if source .vim exists and is non-empty
if [ ! -d "$SRC_VIM" ] || [ -z "$(ls -A "$SRC_VIM")" ]; then
    echo "⚠️ Warning: Source ~/.vim is missing or empty. Aborting to prevent destructive sync."
    exit 1
fi

# Determine rsync flags
if [ "$DRY_RUN" = true ]; then
    echo "🔍 Running in DRY RUN mode (no actual changes will be made)"
    RSYNC_FLAGS="-av --delete --dry-run"
else
    RSYNC_FLAGS="-av --delete"
fi

# Sync .vim directory safely
echo "🔁 Syncing $SRC_VIM -> $DEST_VIM ..."
mkdir -p "$DEST_VIM"
rsync $RSYNC_FLAGS "$SRC_VIM/" "$DEST_VIM/"

# Exit after dry run
if [ "$DRY_RUN" = true ]; then
    echo "ℹ️ Dry run completed. No files were changed.  Exit !!!!!!!!!!!!!!!!"
    exit 0
fi



# Sync .vimrc only if not in dry run mode
if [ "$DRY_RUN" = false ]; then
    if [ -f "$SRC_VIMRC" ]; then
        if [ ! -f "$DEST/.vimrc" ] || ! cmp -s "$SRC_VIMRC" "$DEST/.vimrc"; then
            echo "📄 Copying updated .vimrc"
            cp "$SRC_VIMRC" "$DEST/.vimrc"
        fi
    else
        if [ -f "$DEST/.vimrc" ]; then
            echo "🗑️ Deleting .vimrc (no longer exists in source)"
            rm "$DEST/.vimrc"
        fi
    fi
fi

echo "✅ Sync complete."







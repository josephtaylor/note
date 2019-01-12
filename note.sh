function mdless() {
    pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

# open a note in vim
function _note_edit() {
    if [ $# -eq 0 ]; then
        echo "Please provide a filename argument"
        return 1
    fi
    mkdir -p ~/.notes;
    vim ~/.notes/"$1.md";
}

# open a note in vs code
function _note_code() {
    if [ $# -eq 0 ]; then
        echo "Please provide a filename argument"
        return  1
    fi
	mkdir -p ~/.notes;
	code ~/.notes/"$1.md";
}

function _note_ls() {
    ls -1 ~/.notes/*.md
}

function _note_rm() {
    read -r -p "Are you sure? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            rm ~/.notes/"$1.md"
            echo "removed note: $1"
        ;;
    esac
}

function note() {
    if [ $# -eq 0 ]; then
        echo "Please provide a command or filename"
        return 1
    fi
    case $1 in
        "code")
            _note_code $2
        ;;
        "ls")
            _note_ls
        ;;
        "rm")
            _note_rm $2
        ;;
        "edit")
            _note_edit $2
        ;;
        *)
            mdless ~/.notes/"$1.md";
        ;;
    esac
}
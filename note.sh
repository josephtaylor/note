function mdless() {
    pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

function _noteedit() {
    if [ $# -eq 0 ]; then
        echo "Please provide a filename argument"
        return 1
    fi
    mkdir -p ~/.notes;
    vim ~/.notes/"$1.md";
}

function _notecode() {
    # TODO: Refactor this ish to a function
    if [ $# -eq 0 ]; then
        echo "Please provide a filename argument"
        return  1
    fi
	mkdir -p ~/.notes;
	code ~/.notes/"$1.md";
}

function _notels() {
    ls -1 ~/.notes/*.md
}

function note() {
    if [ $# -eq 0 ]; then
        # TODO: Usage function
        echo "Please provide a command or filename"
        return 1
    fi
    case $1 in
        "code")
            _notecode $2
        ;;
        "ls")
            _notels
        ;;
        "edit")
            _noteedit $2
        ;;
        *)
            mdless ~/.notes/"$1.md";
        ;;
    esac
}
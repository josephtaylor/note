#!/usr/bin/env bash

# local variabtles
note_bash_profile="${HOME}/.bash_profile"
note_bashrc="${HOME}/.bashrc"
note_home="${HOME}/.notes"
note_script_uri=https://raw.githubusercontent.com/josephtaylor/note/master/note.sh

note_init_snippet=$( cat << EOF
# enables note functions
[[ -s "${HOME}/.notes/note.sh" ]] && source "${HOME}/.notes/note.sh"
EOF
)

darwin=false;
case $(uname) in 
  Darwin*)
    darwin=true;  
  ;;
esac

echo "Creating directory..."
mkdir -p "${note_home}"
echo "Downloading script..."
curl -sSL --progress-bar -o "${note_home}/note.sh" "${note_script_uri}"

if [[ $darwin == true ]]; then
  touch "$note_bash_profile"
  echo "Attempting update of login bash profile on OSX..."
  if [[ -z $(grep 'note.sh' "$note_bash_profile") ]]; then
    echo -e "\n$note_init_snippet" >> "$note_bash_profile"
    echo "Added note snippet to $note_bash_profile"
  fi
else
  echo "Attempting update of interactive bash profile on regular UNIX..."
  touch "${note_bashrc}"
  if [[ -z $(grep 'note.sh' "$note_bashrc") ]]; then
      echo -e "\n$note_init_snippet" >> "$note_bashrc"
      echo "Added note snippet to $note_bashrc"
  fi
fi

echo -e "\nAll done!\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${HOME}/.notes/note.sh\""
echo ""
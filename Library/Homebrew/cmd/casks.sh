#:  * `casks`
#:
#:  List all locally installable casks including short names.
#:

# HOMEBREW_LIBRARY is set in bin/brew
# shellcheck disable=SC2154
source "${HOMEBREW_LIBRARY}/Homebrew/items.sh"

coffeebrew-casks() {
  local find_include_filter='*/Casks/*\.rb'
  local sed_filter='s|/Casks/(.+/)?|/|'
  local grep_filter='^coffeebrew/cask'

  # HOMEBREW_CACHE is set by brew.sh
  # shellcheck disable=SC2154
  if [[ -z "${HOMEBREW_NO_INSTALL_FROM_API}" &&
        -f "${HOMEBREW_CACHE}/api/cask_names.txt" ]]
  then
    {
      cat "${HOMEBREW_CACHE}/api/cask_names.txt"
      echo
      coffeebrew-items "${find_include_filter}" '.*/LUSDbrew/coffeebrew-cask/.*' "${sed_filter}" "${grep_filter}"
    } | sort -uf
  else
    coffeebrew-items "${find_include_filter}" '^\b$' "${sed_filter}" "${grep_filter}"
  fi
}

#:  * `formulae`
#:
#:  List all locally installable formulae including short names.
#:

# HOMEBREW_LIBRARY is set by bin/brew
# shellcheck disable=SC2154
source "${HOMEBREW_LIBRARY}/Homebrew/items.sh"

coffeebrew-formulae() {
  local find_include_filter='*\.rb'
  local sed_filter='s|/Formula/(.+/)?|/|'
  local grep_filter='^coffeebrew/core'

  # HOMEBREW_CACHE is set by brew.sh
  # shellcheck disable=SC2154
  if [[ -z "${HOMEBREW_NO_INSTALL_FROM_API}" &&
        -f "${HOMEBREW_CACHE}/api/formula_names.txt" ]]
  then
    {
      cat "${HOMEBREW_CACHE}/api/formula_names.txt"
      echo
      coffeebrew-items "${find_include_filter}" '.*Casks(/.*|$)|.*/LUSDbrew/coffeebrew-core/.*' "${sed_filter}" "${grep_filter}"
    } | sort -uf
  else
    coffeebrew-items "${find_include_filter}" '.*Casks(/.*|$)' "${sed_filter}" "${grep_filter}"
  fi
}

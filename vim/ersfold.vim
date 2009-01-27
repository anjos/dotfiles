"Function to fold ERS debug macros that extend more than 1 line
function! FoldErs()
  if getline(v:lnum) =~  '\s*ERS_DEBUG(.*[^;\s*]$'
    return 'a1'
  endif
  if getline(v:lnum) =~ '.*);\s*'
    return 's1'
  endif
  return '='
endfunction

"This activates the above function on and off
:command! ErsHide :set foldmethod=expr|:set foldexpr=FoldErs()|:set foldlevel=0
:command! ErsShow :set foldmethod=manual|:set foldexpr=''|:set foldlevel=1


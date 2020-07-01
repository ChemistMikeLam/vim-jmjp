" syntax/jmjp.vim 

" Check that no existing syntax has been set 
if exists("b:current_syntax") 
	finish 
endif 

" Check if the highlighting is turned off by user 
if get(g:, "jmjpSynHlOff", 0) 
	finish 
endif 

" Set the syntax keyword characters
syntax iskeyword @,---,_,48-57,192-255  

" Match bracketed regions 
syntax region jmjpBracket keepend extend contains=ALLBUT,jmjpKwdFt matchgroup=jmjpDelim start="\[" end="\]" 
syntax region jmjpParen keepend extend contains=ALLBUT,jmjpKwdFt matchgroup=jmjpDelim start="(" end=")" 

" Filetype magic word line 
syntax match jmjpFt nextgroup=jmjpParen skipwhite skipnl "jmjp\[[0-9]\+.[0-9]\+\]"

" Match keywords inside a mahjong match record 
syntax keyword jmjpKwd contained nextgroup=jmjpBracket skipwhite skipnl 

"" strLit, Sec 2.3.1 
syntax keyword jmjpKwd snt srm 

"" hand, Sec 2.3.7 
syntax keyword jmjpKwd hnd chi pon dmk kkn ank 

"" pre-match info, Sec 4.1 
syntax keyword jmjpKwd tnm mtp rec ply ptr 

"" frame excl frame flow, Sec 4.2.1 & 4.2.3
syntax keyword jmjpKwd frm pfs pfe 

"" post-match info, Sec 4.3
syntax keyword jmjpKwd pme ptn 

"" frame flow, Sec 4,2.2 
syntax keyword jmjpKwd ch pn dk kk ak rs rc 

" Match constants 

"" frameId
syntax match jmjpFrameId contained containedin=jmjpBracket "[ESWN][1-4]-[0-9]\+" 
syntax cluster jmjpConst add=jmjpFrameId 

"" Shorthand tokens 
syntax keyword jmjpSHT contained 
syntax cluster jmjpConst add=jmjpSHT 

""" tourName 
syntax keyword jmjpSHT mlg

""" tourStage 
syntax keyword jmjpSHT 1rd 2nd qtf smf fin mlg-reg mlg-sfs mlg-fns 

""" matchPlace 
syntax keyword jmjpSHT mlg-std 

""" plyerTeam 
syntax keyword jmjpSHT mlg-drn mlg-exf mlg-skn mlg-mfc mlg-abm mlg-phx mlg-rdn mlg-prt 

""" plyerAffil 
syntax keyword jmjpSHT none saikouisen prokyoukai prorenmei rmu rengoumu 101 kishikai zennihon 

"" Tiles 
syntax keyword jmjpTile contained 
syntax cluster jmjpConst add=jmjpTile 

""" Number tiles 
syntax match jmjpTile "[0-9][psm]" 

""" Wind tiles 
syntax match jmjpTile "[eswn]w" 

""" Honor tiles 
syntax match jmjpTile "[wgr]d" 

""" Unknown tiles 
syntax match jmjpTile "uk" 

""" Action tiles 
syntax match jmjpTile "rn" 
syntax match jmjpTile "oy" 
syntax match jmjpTile "tg" 
syntax match jmjpTile "kg" 
syntax match jmjpTile "tm"

"" tileFrom in tileFuro of hands
syntax match jmjpTileFrom contained "\(,\_s*\(\(//.*$\)\_s*\)*\)\@<=[stk]\(\_s*\(\(//.*$\)\_s*\)*[\]]\)\@=" 
syntax cluster jmjpConst add=jmjpTileFrom 

"" Seats 
syntax match jmjpSeat contained "\((\_s*\(\(//.*$\)\_s*\)*\)\@<=[eswn]\(\_s*\(\(//.*$\)\_s*\)*,\)\@=" 
syntax cluster jmjpConst add=jmjpSeat 

"" Integers 
syntax match jmjpInt contained "\d\+\(\_s*\(\(//.*$\)\_s*\)*[,\]]\)\@=" 
syntax cluster jmjpConst add=jmjpInt 

"" All frames for recorder 
syntax match jmjpAllFrm contained "\(,\_s*\(\(//.*$\)\_s*\)*\)\@<=all\(\_s*\(\(//.*$\)\_s*\)*[\]]\)\@="
syntax cluster jmjpConst add=jmjpAllFrm 

"" Weekdays 
syntax keyword jmjpWkdy contained 
syntax cluster jmjpConst add=jmjpWkdy 
syntax keyword jmjpWkdy mon tue wed thu fri sat sun 

" Match points 
syntax match jmjpPt contained "-\=[0-9]\+[.][0-9]" 

" Match string literals 
syntax region jmjpString keepend extend contains=NONE start=/"/ skip=/\\"/ end=/"/ 

" Match comments 
syntax match jmjpComment excludenl keepend contains=NONE "//.*$" 

" Higlight the classes 

"" Delimiters 
highlight default link jmjpDelim Delimiter 

"" Filetype line
highlight default link jmjpFt PreProc 

"" Keywords 
highlight default link jmjpKwd Label 

"" Constants
highlight default link jmjpFrameId Constant 
highlight default link jmjpSHT Constant 
highlight default link jmjpTile Constant 
highlight default link jmjpTileFrom Constant 
highlight default link jmjpSeat Constant 
highlight default link jmjpInt Number 
highlight default link jmjpAllFrm Constant 
highlight default link jmjpWkdy Constant 

"" Points 
highlight default link jmjpPt Float 

"" String literals 
highlight default link jmjpString String 

"" Comments 
highlight default link jmjpComment Comment 

" Set b:current_syntax 
let b:current_syntax = "jmjp" 


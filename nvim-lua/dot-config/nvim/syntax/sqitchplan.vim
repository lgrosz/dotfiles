" Vim syntax file for .plan logs
" Save as plan.vim and use with :set syntax=plan

" Define default syntax settings
syntax case ignore

" Highlight the syntax version, project, and URI declarations (lines starting with %)
syn match planDirective "^%syntax-version=\S\+" contained
syn match planDirective "^%project=\S\+" contained
syn match planDirective "^%uri=\S\+" contained

highlight def link planDirective PreProc

" Match first word (typically a table or feature name) and any dependency list in square brackets
syn match planEntry "^[a-zA-Z0-9_-]\+" contained
syn match planDependencies "\[.*\]" contained

highlight def link planEntry Identifier
highlight def link planDependencies Special

" Highlight timestamps in ISO 8601 format
syn match planTimestamp "\d\{4}-\d\{2}-\d\{2}T\d\{2}:\d\{2}:\d\{2}Z" contained

highlight def link planTimestamp Constant

" Highlight author name and email
syn match planAuthor "\<[A-Za-z ]\+\>"
syn match planEmail "<[^>]\+@[^>]\+>"

highlight def link planAuthor Identifier
highlight def link planEmail String

" Highlight the comment text after the tag
syn match planComment "# .*" contains=planTag

highlight def link planComment Comment

" Define the contained group for each line to apply these patterns
syn region planLine start="^" end="$" contains=planEntry,planDependencies,planTimestamp,planAuthor,planEmail,planComment

" Apply planLine to lines that do not start with %
syn region planLineRegion start="^[^%]" end="$" contains=planLine

" Apply the syntax settings for the directive lines
syn region planDirectiveLine start="^%" end="$" contains=planDirective

" Set the default highlighting for unmatched text
highlight def link planLine Normal


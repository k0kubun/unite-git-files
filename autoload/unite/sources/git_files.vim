let s:source = { 'name': 'git_files', 'hooks': {} }

function! s:source.gather_candidates(args, context)
  let result = unite#util#system('git ls-files')
  if unite#util#get_last_status() != 0 || strlen(result) == 0
    let result = unite#util#system('find . -type f')
  endif
  return unite#sources#git_files#gather_vim(result)
endfunction

function! unite#sources#git_files#gather_vim(result)
  let candidates = []
  let paths = split(a:result, '\r\n\|\r\|\n')
  for path in paths
    let dict = { 'word': path, 'kind': 'file', 'action__path': path }
    call add(candidates, dict)
  endfor
  return candidates
endfunction

function! unite#sources#git_files#define()
  return s:source
endfunction

function ohio --wraps='grep -i' --description 'search for packages in ohio'
  paru -Qs | grep -i $argv
end

browser_open () {
  if [ !-s $1 ];then
    echo "Must contain atleast one file"
  fi

  for i in $@; do
    firefox "$i"
  done
}

# Week 2

```
demo06
```

```shell
${0} # special variable that indicates the first parameter of the function
which head # which command indicates which path is used for the head function
basename # strip off the directory to keep the filename
${#} # the number of parameters
./luser-demo06.sh one "b c" d  # "b c" is treated as one part
./luser-demo06.sh one 'ab cd'

"${@}" # give a list of all the parameters, it is often used in the for loop
```

`shift` command shifts/decrement the postion of the parameter

```
date +%s%N | sha256sum | head -c48
```

pipe the date with nano second to shasum and then get the first 48 bytes.
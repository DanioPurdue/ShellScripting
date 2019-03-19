```shell
echo -n1 /etc/passwd > filename # Redirect the output of the command

id -un > id
echo "${UID}" > /uid # you can get a permission denied

# Redirect the standard input
read LINE < %{FILE}
sudo passwd --stdin einstein < passord_file
```

Every open process is associated with three file descriptors

1. stdin ： 0
2. stdout ： 1
3. stderr ： 2

```shell
head -n1 file1 file2
# Redirect the output
head -n1 /etc/passwd /etc/hosts fakefile > head.out #standard error is not redirected

head -n1 /etc/passwd /etc/hosts /fakefile 2> head.err #the standard error goes to the file
head -n1 /fakefile >>head.out 2>>head.err

head -n1 /etc/passwd /fakefile > head.both 2>&1 #file descriptor is referenced with & sign.

head -n1 /etc/passwd &> head.both
```

The standard error does not flow through the pipe to solve this 

```shell
head -n1 /etc/passwd /etc/hosts /fakefile 2>&1 | cat -n
head -n1 /etc/passwd /etc/hosts |& cat -n
```




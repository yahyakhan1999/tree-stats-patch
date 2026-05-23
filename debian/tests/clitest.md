Basic command line testing of the `tree` command
================================================

Standard invocation without any parameters:

```
$ tree debian
debian
|-- changelog
|-- control
|-- copyright
|-- docs
|-- patches
|   |-- 0001-tree-list-call-printinfo-on-error-cases-too.patch
|   |-- introduce-a-test-framework
|   |-- manpage
|   `-- series
|-- rules
|-- salsa-ci.yml
|-- source
|   `-- format
|-- tests
|   |-- clitest.md
|   `-- control
`-- watch

4 directories, 14 files
$
```

List directories only:

```
$ tree -d debian
debian
|-- patches
|-- source
`-- tests

4 directories
$
```

Descend only 1 directory deep:

```
$ tree -L 1 debian
debian
|-- changelog
|-- control
|-- copyright
|-- docs
|-- patches
|-- rules
|-- salsa-ci.yml
|-- source
|-- tests
`-- watch

4 directories, 7 files
$
```

All files are listed, and do not list files that match the given pattern:

```
$ tree -a -I '*.swp' -I '*.md' debian/tests
debian/tests
|-- .hidden
|-- .info
`-- control

1 directory, 3 files
$
```

List only those files that match the pattern given:

```
$ tree -P '*.md' debian
debian
|-- patches
|-- source
`-- tests
    `-- clitest.md

4 directories, 1 file
$
```

List only those files that match the pattern given, and ignore case when pattern matching:

```
$ tree -P '*.MD' --ignore-case debian
debian
|-- patches
|-- source
`-- tests
    `-- clitest.md

4 directories, 1 file
$
```

List only those files that match the pattern given, and include directory names in -P pattern matching:

```
$ tree -P '*t*' --matchdirs debian
debian
|-- control
|-- copyright
|-- patches
|   |-- 0001-tree-list-call-printinfo-on-error-cases-too.patch
|   |-- introduce-a-test-framework
|   |-- manpage
|   `-- series
|-- source
|   `-- format
|-- tests
|   |-- clitest.md
|   `-- control
`-- watch

4 directories, 10 files
$
```

All files are listed, and do not list files that match the given pattern, and print information about files found in .info files:

```
$ tree -a -I '*.swp' --info debian/tests
debian/tests
|-- .hidden
|    [ This file is used for testing tree's -a parameter
|-- .info
|    [ This file is used for testing tree's --info parameter
|-- clitest.md
|    [ This file contains the clitest tests.
`-- control
     [ This is the standard autopkgtest control file

1 directory, 4 files
$
```

List directories only, and turn off file/directory count at end of tree listing:

```
$ tree -d --noreport debian
debian
|-- patches
|-- source
`-- tests
$
```

Do not descend dirs with more than # files in them:

```
$ tree --filelimit 1 debian
debian  [10 entries exceeds filelimit, not opening dir]

1 directory, 0 files
$
```

Quote filenames with double quotes:

```
$ tree -Q debian/tests
"debian/tests"
|-- "clitest.md"
`-- "control"

1 directory, 2 files
$
```

Print the size in a more human readable way, and compute size of directories by their contents:
disabled due to sizes varying greatly

```
# XXX $ tree -h --du debian/tests
[2.7K]  debian/tests
|-- [2.6K]  clitest.md
`-- [  94]  control

 2.6K used in 1 directory, 2 files
$
```

Appends '/', '=', '\*', '@', '|' or '>' as per ls -F, and list only those files that match the pattern given:

```
$ tree -F -P 'rules' debian
debian/
|-- patches/
|-- rules*
|-- source/
`-- tests/

4 directories, 1 file
$
```

Sort files by last modification time, and turn off file/directory count at end of tree listing:
disabled due to times varying greatly

```
# XXX $ tree -t --noreport debian/tests
debian/tests
|-- control
`-- clitest.md
$
```

List directories before files:

```
$ tree --filesfirst debian
debian
|-- changelog
|-- control
|-- copyright
|-- docs
|-- rules
|-- salsa-ci.yml
|-- watch
|-- patches
|   |-- 0001-tree-list-call-printinfo-on-error-cases-too.patch
|   |-- introduce-a-test-framework
|   |-- manpage
|   `-- series
|-- source
|   `-- format
`-- tests
    |-- clitest.md
    `-- control

4 directories, 14 files
$
```

List files before directories:

```
$ tree --dirsfirst debian
debian
|-- patches
|   |-- 0001-tree-list-call-printinfo-on-error-cases-too.patch
|   |-- introduce-a-test-framework
|   |-- manpage
|   `-- series
|-- source
|   `-- format
|-- tests
|   |-- clitest.md
|   `-- control
|-- changelog
|-- control
|-- copyright
|-- docs
|-- rules
|-- salsa-ci.yml
`-- watch

4 directories, 14 files
$
```

Select sort: size:

```
$ tree --sort size debian/tests 
debian/tests
|-- clitest.md
`-- control

1 directory, 2 files
$
```

Don't print indentation lines:

```
$ tree -i debian/tests
debian/tests
clitest.md
control

1 directory, 2 files
$
```

Prints out an XML representation of the tree:

```
$ tree -X debian/tests
<?xml version="1.0"?>
<tree>
  <directory name="debian/tests">
    <file name="clitest.md"></file>
    <file name="control"></file>
  </directory>
  <report>
    <directories>1</directories>
    <files>2</files>
  </report>
</tree>
$
```

Prints out an JSON representation of the tree:

```
$ tree -J debian/tests
[
  {"type":"directory","name":"debian/tests","contents":[
    {"type":"file","name":"clitest.md"},
    {"type":"file","name":"control"}
  ]}
,
  {"type":"report","directories":1,"files":2}
]
$
```

Prints out HTML format with baseHREF as top directory, and replace the default HTML title and H1 header with string, and turn colorization on always:

```
$ tree -H debian/tests -T myteststring -C debian/tests | sed -e 's#tree v[0-9.]\+ (c) 1996 - [0-9]\+ by Steve Baker#tree vXYZ (c) YYYY - YYYY by Steve Baker#g'
<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 <meta name="Author" content="Made by 'tree'">
 <meta name="GENERATOR" content="tree vXYZ (c) YYYY - YYYY by Steve Baker, Thomas Moore, Francesc Rocher, Florian Sesser, Kyosuke Tokoro">
 <title>myteststring</title>
 <style type="text/css">
  BODY { font-family : monospace, sans-serif;  color: black;}
  P { font-family : monospace, sans-serif; color: black; margin:0px; padding: 0px;}
  A:visited { text-decoration : none; margin : 0px; padding : 0px;}
  A:link    { text-decoration : none; margin : 0px; padding : 0px;}
  A:hover   { text-decoration: underline; background-color : yellow; margin : 0px; padding : 0px;}
  A:active  { margin : 0px; padding : 0px;}
  .VERSION { font-size: small; font-family : arial, sans-serif; }
  .NORM  { color: black;  }
  .FIFO  { color: purple; }
  .CHAR  { color: yellow; }
  .DIR   { color: blue;   }
  .BLOCK { color: yellow; }
  .LINK  { color: aqua;   }
  .SOCK  { color: fuchsia;}
  .EXEC  { color: green;  }
 </style>
</head>
<body>
	<h1>myteststring</h1><p>
	<a class="DIR" href="debian/tests/">debian/tests</a><br>
	|-- <a class="NORM" href="debian/tests/clitest.md">clitest.md</a><br>
	`-- <a class="NORM" href="debian/tests/control">control</a><br>
<br><br><p>

1 directory, 2 files

</p>
	<hr>
	<p class="VERSION">
		 tree vXYZ (c) YYYY - YYYY by Steve Baker and Thomas Moore <br>
		 HTML output hacked and copyleft (c) 1998 by Francesc Rocher <br>
		 JSON output hacked and copyleft (c) 2014 by Florian Sesser <br>
		 Charsets / OS/2 support (c) 2001 by Kyosuke Tokoro
	</p>
</body>
</html>
$
```

Reads paths from files:

```
$ find debian/tests | tree --fromfile .
.
`-- debian
    `-- tests
        |-- clitest.md
        `-- control

3 directories, 2 files
$
```

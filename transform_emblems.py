SAXON_COMMAND = 'Transform.exe'

from subprocess import run

for i in range(1, 51):
    j = str(i).zfill(2) #zero-padded emblem number.
    args = [
        SAXON_COMMAND,
        "-s:english/emblem{}.xml".format(j),
        "-xsl:xsl/Eng-to-HTML.xsl",
        "-o:english-html/emblem{}.html".format(j),
    ]
    print(args[1])
    run(args)

    args = [
        SAXON_COMMAND,
        "-s:latin/emblem{}.xml".format(j),
        "-xsl:xsl/Lat-to-HTML.xsl",
        "-o:latin-html/emblem{}.html".format(j),
    ]
    print(args[1])
    run(args)
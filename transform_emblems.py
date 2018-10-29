SAXON_COMMAND = 'Transform.exe'

from subprocess import run
import sys
from pathlib import Path

THISDIR = Path(sys.argv[0]).parent
print(THISDIR)

for f in THISDIR.glob('english/*.xml'):
    args = [
        SAXON_COMMAND,
        "-s:{}/{}".format(THISDIR, f),
        "-xsl:{}/xsl/Eng-to-HTML.xsl".format(THISDIR),
        "-o:{}/english-html/{}".format(THISDIR, f.name.replace('.xml', '.html')),
    ]
    print(args[1])
    run(args)

for f in THISDIR.glob('latin/*.xml'):
    args = [
        SAXON_COMMAND,
        "-s:{}/{}".format(THISDIR, f),
        "-xsl:{}/xsl/Lat-to-HTML.xsl".format(THISDIR),
        "-o:{}/latin-html/{}".format(THISDIR, f.name.replace('.xml', '.html')),
    ]
    print(args[1])
    run(args)
from subprocess import run
import sys
from pathlib import Path
import yaml

with Path('../atalanta-src/furnace.project.yaml').open('r') as f:
    settings = yaml.load(f, Loader=yaml.FullLoader)

commands = settings['extracaminar-activities']['saxon-command-lines']

THISDIR = Path(sys.argv[0]).parent.resolve()
print(THISDIR)

for lang, templ in {"english": "xsl/Eng-to-HTML.xsl", "latin": "xsl/Lat-to-HTML.xsl"}.items():
    xsl =  str((THISDIR / templ).resolve())
    for f in THISDIR.glob('%s/*.xml' % lang):
        src = str(f.resolve())
        out = str(THISDIR / ('%s-html'%lang) / f.name.replace('.xml', '.html'))
        
        for command in commands:
            cmd = command % (src, xsl, out) 
            print(cmd)
            if run(cmd.split()).returncode == 0:
                break
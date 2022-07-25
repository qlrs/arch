# fc-list requires package 'fontconfig'
import subprocess
import re

def getFonts():
    """Returns a list of fonts with clean names"""

    # Get fonts in string
    fontProcess = subprocess.run(['fc-list'], stdout = subprocess.PIPE)
    rawfonts = fontProcess.stdout.decode('utf-8')

    # Get clean font names in a list
    selection = []
    for i in rawfonts.split('\n'):
        try:
            i = i.split(':')[1].lstrip()
            if i not in selection:
                selection.append(i)
            else:
                continue
        except IndexError:
            pass
    selection.sort()

    # Put fonts back into string for use as stdin
    fonts = ''
    for i in selection:
        fonts += f"{i}\n"
    return fonts

def newFont():
    """Returns the new font that you want"""

    fonts = getFonts()
    output = subprocess.run(['dmenu', '-l', '10', '-i'], input=fonts.encode(), capture_output=True)
    choice = output.stdout.decode().strip()
    return choice

def changeFont(file, font, regex):
    """Finds the old font in the config file and replaces with with new"""

    with open(file, 'r+') as f:
        file = f.read()
        file = re.sub(regex, f'family: {font}', file)
        f.seek(0)
        f.write(file)

fontRe = re.compile(r'family: [a-zA-Z0-9<]+')
font = newFont()
changeFont('sample.yml', font, fontRe)

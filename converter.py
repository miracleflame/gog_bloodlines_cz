import os
import shutil
import re
from unidecode import unidecode


# Recreate Temp folder with parameter(s) source='dest' renamed folders
def temp_recreate(**dirs):
    if os.path.exists('temp'):
        print('Removing temp files...')
        shutil.rmtree('temp')
    print('Copying source files to process in a temp folder...')
    os.mkdir('temp')
    for source, dest in dirs.items():
        shutil.copytree(source, 'temp/' + dest, dirs_exist_ok=True)
    return


# Creates a file-path list containing paths of all files under dirpath except excluded
def fpath_list(dirpath, dexclude=(), fexclude=()):
    fpathlist = []
    for path, dirs, files in os.walk(dirpath):
        dirs[:] = [d for d in dirs if d not in dexclude]
        for fname in files:
            if not (fname.lower().endswith(fexclude)):
                fpathlist += [os.path.join(path, fname)]
    return fpathlist


# Returns string contents of a file from fpath using selected encoding
def file_contents_get(fpath, encoding, lines=None):
    print('Processing', fpath)
    with open(fpath, mode='r', encoding=encoding) as fin:
        if lines:
            content = fin.readlines()
        else:
            content = fin.read()
    return content


# Saves a file in fpath containing content using selected encoding
def save_file_contents(fpath, content, encoding, bom=None):
    with open(fpath, mode='w', encoding=encoding) as fout:
        if bom:
            fout.write(u'\ufeff')
        fout.write(content)
        fout.close()
        print('*Processed*', fpath)
    return


# Character replacement in content of a file in fpath
def char_replace(fpath, content):
    # Removes diacritics from hackterminals files
    if 'hackterminals' in fpath:
        content = unidecode(content)
    # Removes diacritics from Hacking_Strings in strings.txt file
    if fpath.endswith('strings.txt'):
        hackstrings = re.search(r'Hacking((.|\n)*)Info', content).group(1)
        content = content.replace(hackstrings, unidecode(hackstrings))
    # Font-friendly characters replacement
    replacement = content.maketrans(
        'ŠšČčŤťŽžÝýÁáÍíÉéĚěŘřĎďŇňÖöÜüŮůÚú',
        'âÂçÇëËîÎÝýÁáÍíÉé§µäÄ°·÷×ÖöÜüôÔÚú'
    )
    content = content.translate(replacement)
    # Additional FF replacement for .lip files
    if fpath.endswith('.lip'):
        replacement = content.maketrans({
            'Â': '#', 'Ç': '$', 'Î': '&', 'ý': '*', 'é': '=',
            'µ': '@', 'Ä': ']', 'á': '[', 'í': '`', 'Ô': '^',
        })
        content = content.translate(replacement)
    return content


# Translation of .lip files to PHRASE line
def lip_translate(fpath):
    if fpath.endswith('.lip'):
        content = file_contents_get(fpath, 'utf8')
        if 'radio' in fpath or 'CITOSLOVCE' in content:
            print('-Skipping-', fpath)
            return
        text = re.search('".*"', content).group(0)
        phrase = re.search('PHRASE.*"', content).group(0)
        newphrase = f"PHRASE char {len(text)} {text}"
        content = content.replace(phrase, newphrase)
        save_file_contents(fpath, content, 'utf8')
    return


# Prepares cestina & UP_Plus files for compilation into installer
def convert():
    temp_recreate(UPbasicCZ='basic/Unofficial_patch',
                  UPplus='plus/Unofficial_patch',
                  UPplusCZ='plus/Unofficial_patch')
    shutil.move('temp/basic/Unofficial_patch/bin', 'temp/basic/')
    dexclude = ('bin', 'cl_dlls', 'particles', 'materials', 'models')
    fexclude = ('.mp3', '.vcd', '.wav')
    fpathlist = fpath_list('temp', dexclude, fexclude)
    for fpath in fpathlist:
        lip_translate(fpath)
        if fpath.endswith('gameui_english.txt'):
            content = file_contents_get(fpath, 'utf-16-LE')
            content = char_replace(fpath, content)
            save_file_contents(fpath, content, 'utf-16-LE', bom=True)
        else:
            content = file_contents_get(fpath, 'utf8')
            content = char_replace(fpath, content)
            save_file_contents(fpath, content, 'cp1250')
    return


convert()

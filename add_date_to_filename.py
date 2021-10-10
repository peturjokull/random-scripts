import os
from time import localtime,strftime

path = input(f"Paste your path in here: (C:\\example\\example) \n")
current_directory = os.getcwd()
if path == current_directory: pass
else : 
    os.chdir(path=path)
    current_directory = os.getcwd()

files_in_dir = os.listdir(current_directory)

for file in files_in_dir:
    creation_date = strftime("%Y-%m-%d",localtime(os.stat(file).st_birthtime))
    new_file_name = creation_date+'_'+file
    print(f'name of file was {file}')
    if file[:10] != creation_date:
        os.rename(file, new_file_name)
        print(f'name of file is now {new_file_name}')
    else : print('skipped renaming file cause it already has correct naming format')

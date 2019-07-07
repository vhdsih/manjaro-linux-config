import os
import sys
import subprocess
import logging
from config import *

def path_state(path):
    return os.path.exists(path)

def exec_cmd(cmd):
    logging.info('Run %s' % cmd)
    code = subprocess.call(cmd, shell=True)
    logging.info('Run %s state: %s' % (cmd, code == 0))
    return code == 0

def progress_bar(num_cur, total):
    sys.stdout.write('\r')
    ratio = float(num_cur) / total
    percentage = int(ratio * 100)
    r = '\r\n[%s%s]%d%%' % (">"*percentage, " "*(100-percentage), percentage )
    sys.stdout.write(r)
    sys.stdout.flush()

def edit_files(file):
    if len(EDITORS) == 0:
        return False
    for id, editor in enumerate(EDITORS):
        print('%d: %s' % (id, editor))
    logging.info('Which editor you want to use (0 - %d) ?' % (len(EDITORS) - 1))
    op = int(input())
    if op >= 0 and op < len(EDITORS):
        cmd = '%s %s' % (EDITORS[op], file)
        state = exec_cmd(cmd)
        if not state:
            logging.error('Can not find the editor %s, try another one please' % EDITORS[op])
            EDITORS.pop(op)
    else:
        state = False
        logging.error('The code is wrong')
    if not state:
        edit_files(file)
    return True

class Packages():
    def __init__(self):
        pass

    def _install_helper(self, permission, tool, args, app):
        cmd = '%s %s %s %s' % (permission, tool, ' '.join(args), app)
        state = exec_cmd(cmd)
        return state

    def _install(self, app):
        state = self._install_helper('sudo', TOOL, IARGS, app)
        if not state:
            state = self._install_helper('', AUR_TOOL, IARGS, app)
        return state
    
    def update(self):
        cmd = 'sudo %s %s' % (TOOL, ' '.join(UARGS))
        state = exec_cmd(cmd)
        return state
    
    def install_apps(self, apps):
        for app in apps:
            self._install(app)
    
    def install_from_files(self, files):
        applications = []
        logging.info('Applications to be installed are listed in follow files:')
        for file in files:
            logging.info('Install applications in file %s (Y/n)?' % file)
            op = input()
            if 'n' in op or 'N' in op:
                logging.info('Skip applications in file %s (Y/n)?' % file)
                continue
            logging.info('Edit applications in file %s (Y/n)?' % file)
            op = input()
            if 'n' in op or 'N' in op:
                pass
            else:
                edit_files(file)
            with open(file, 'r') as f:
                for app in f:
                    app = app.strip()
                    if len(app) > 0:
                        applications.append(app)
        self.install_apps(applications)
    


if __name__ == '__main__':
    import time
    import sys

    n = 100
    # 输出 ，0%  #######################
    sys.stdout.write("0%" + "#"*n)
    sys.stdout.flush()

    p = Packages()
    for i in range(1,n+1):
        p._install('tree')
        sys.stdout.write('\r')  # 光标回到头部
        msg =f"{i}%  " +"="*(i) # 输出内容
        sys.stdout.write(msg)   # 将i个=号写入到缓冲区
        sys.stdout.flush()      # 输出
        time.sleep(0.03)        # 停顿，不然看不出来效果
    sys.stdout.write('\n')
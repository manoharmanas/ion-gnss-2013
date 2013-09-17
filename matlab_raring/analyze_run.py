#!/usr/bin/env python
import sys, os
import scipy.io as sio
import numpy as np
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'lfviz_gui', 'cmdi'))
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'lfviz_gui', 'cfg'))
import settings as cfg
import util
from pprint import pprint as pp

var = cfg.MOOS_VARS
# default values
alog_in = open('/media/rgcofield/StorageDrive/alog_Files/LFviz/2013_03_29__solar_house_worked_live/solar house 2/MOOSLog_29_3_2013_____17_57_53.alog', 'r')
mat_out = '/media/rgcofield/StorageDrive/alog_Files/LFviz/2013_03_29__solar_house_worked_live/solar house 2/solar_house_2.mat'

lvel = []
ltime = []
fvel = []
ftime = []
path = [[],[]]
ptime = []
# times when len(path) == 1
single_point_times = []
dev = []
dst = []

mu_warn = 0.4
mu_crit = 0.7


def read_to_array():
    for l in alog_in:
        l = l[:-1]
        if '%' in l: continue
        data = l.split()
        time = float(data[0])
        varn = data[1]
        valu = data[3]

        if varn == var['lvel']:
            lvel.append(float(valu))
            ltime.append(time)
        if varn == var['fvel']:
            fvel.append(float(valu))
            ftime.append(time)
        if varn in var['path']:
            p = extract_path(valu)
            if len(p) == 0: continue
            path[var['path'].index(varn)].append(p)
            if time not in ptime:
                ptime.append(time)

def extract_path(s):
    return [float(x) for x in s.split(']')[1][1:-2].split(',')]


def unify_path(ugly):
    out = []
    if len(ugly[0]) != len(ugly[1]): raise Exception('number of E/N ugly lists do not match - trim in time')
    for t in range(len(ugly[0])): # time
        if len(ugly[0][t]) != len(ugly[1][t]): raise Exception('ugly point mismatch at time'%ptime[t])
        pth = []
        for pt in range(len(ugly[0][t])):
            pth.append([ugly[0][t][pt], ugly[1][t][pt]])
        if len(pth) == 1:
            single_point_times.append(ptime[t])
        out.append(pth)
    return out


def do_dev(path):
    out = []
    for pth in range(len(path)):
        if len(path[pth]) <= 1:
            single_point_times.append(ptime[pth])
            out.append(0.)
            continue
        behind = path[pth][-1]
        ahead = path[pth][-2]
        dv = util.calc_dev(behind, ahead)
        if not dv: pass
        out.append(dv)
    return out


def do_dst(path):
    out = []
    for pth in range(len(path)):
        if len(path[pth]) <= 1:
            out.append(0.)
            continue # already checked for in do_dev
        out.append(util.calc_dst(path[pth]))
    return out


def do_dst_tholds():
    out_warn = []
    out_crit = []
    for v in fvel:
        out_warn.append(util.calc_dst_thold(v, mu_warn))
        out_crit.append(util.calc_dst_thold(v, mu_crit))
    return out_warn, out_crit


def do_dst_states():
    pass


def make_mat(lvel, ltime, fvel, ftime, ptime, single_point_times, dev, dst, dst_thold_warn, dst_thold_crit):
    mat_path = []
    for t in path:
        mat_t = []
        for p in t:
            mat_t.append(np.array(p))
        mat_path.append(np.array(mat_t))
    mat_path = np.array(mat_path)

    mat_lvel = np.array(lvel)
    mat_ltime = np.array(ltime)
    mat_fvel = np.array(fvel)
    mat_ftime = np.array(ftime)
    mat_ptime = np.array(ptime)
    mat_single_point_times = np.array(single_point_times)
    mat_dev = np.array(dev)
    mat_dst = np.array(dst)
    mat_dst_thold_warn = np.array(dst_thold_warn)
    mat_dst_thold_crit = np.array(dst_thold_crit)

    sio.savemat(mat_out,
        {
            'lvel': mat_lvel,
            'ltime': mat_ltime,
            'fvel': mat_fvel,
            'ftime': mat_ftime,
            'path': mat_path,
            'ptime': mat_ptime,
            'single_point_times': mat_single_point_times,
            'dev': mat_dev,
            'dst': mat_dst,
            'dst_thold_warn': mat_dst_thold_warn,
            'dst_thold_crit': mat_dst_thold_crit
        })



read_to_array()
path = unify_path(path)
# pp(path)
dev = do_dev(path)
# pp(dev)
dst = do_dst(path)
dst_thold_warn, dst_thold_crit = do_dst_tholds()
# pp(dst)
# pp(single_point)
make_mat(lvel, ltime, fvel, ftime, ptime, single_point_times, dev, dst, dst_thold_warn, dst_thold_crit)

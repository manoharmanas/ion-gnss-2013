% script to analyze MOOSLog_7_4_2013_____17_16_07

clear all; close all; clc
% cd    /home/rgcofield/devel/lfviz_ws/matlab/mat/_7_4_2013__17_16_07
% data file from python parser
load('/home/rgcofield/devel/lfviz_ws/matlab/mat/2013_04_07___VD_testers__raw/MOOSLog_7_4_2013_____17_16_07.mat')


% % even up lengths
dev = dev(([22:113,116:155]));
dst = dst(([22:113,116:155]));
dst_thold_crit = dst_thold_crit(([22:113,116:155]));
dst_thold_warn = dst_thold_warn(([22:113,116:155]));
ftime = ftime(([22:113,116:155]));
fvel = fvel(([22:113,116:155]));
ltime = ltime(([22:113,116:155]));
lvel = lvel(([22:113,116:155]));
path = path(([22:113,116:155]));
ptime = ptime([21:112,115:154]);


save length_evened



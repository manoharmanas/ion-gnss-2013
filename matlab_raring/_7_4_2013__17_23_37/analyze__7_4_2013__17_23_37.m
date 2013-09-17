% 7_4_2013_____17_23_37
clear all; close all; clc

% data file from python parser
load('/home/rgcofield/devel/lfviz_ws/matlab/mat/2013_04_07___VD_testers__raw/MOOSLog_7_4_2013_____17_23_37.mat')


% % % even up lengths
keep = [15:55,58:77,80:124];
dev = dev(keep);
dst = dst(keep);
dst_thold_crit = dst_thold_crit(keep);
dst_thold_warn = dst_thold_warn(keep);
ftime = ftime(keep);
fvel = fvel(keep);
ltime = ltime(keep);
lvel = lvel(keep);
path = path(keep);
ptime = ptime(keep);


save length_evened







%%% clean up the files

load(strcat('./raw/',log_name{1},'.mat'))

% % take out times when path length is 1
[valid_ptime, valid_ptime_idx] = setdiff(ptime, single_point_times);

dev = dev(valid_ptime_idx);
dst = dst(valid_ptime_idx);
dst_thold_crit = dst_thold_crit(valid_ptime_idx);
dst_thold_warn = dst_thold_warn(valid_ptime_idx);
ftime = ftime(valid_ptime_idx);
fvel = fvel(valid_ptime_idx);
ltime = ltime(valid_ptime_idx);
lvel = lvel(valid_ptime_idx);
path = path(valid_ptime_idx);
ptime = ptime(valid_ptime_idx);

% % clip ends when not moving
for n=1:length(ftime)-2
    if fvel(n)>0.3 && fvel(n+1)>0.3 && fvel(n+2)>0.3
        begin_idx = n;
        break
    end;end
for n=length(ftime):-1:3   
    if fvel(n)>0.3 && fvel(n-1)>0.3 && fvel(n-2)>0.3
        end_idx = n;
        break
    end;end
moving_idx = begin_idx:end_idx;

dev = dev(moving_idx);
dst = dst(moving_idx);
dst_thold_crit = dst_thold_crit(moving_idx);
dst_thold_warn = dst_thold_warn(moving_idx);
ftime = ftime(moving_idx);
fvel = fvel(moving_idx);
ltime = ltime(moving_idx);
lvel = lvel(moving_idx);
path = path(moving_idx);
ptime = ptime(moving_idx);

% % useful variables
dev_thold_warn = 1;
dev_thold_crit = 2;
one_vec = ones(1,length(ptime));

clear('n','moving_idx','end_idx','begin_idx','valid_ptime_idx','valid_ptime')
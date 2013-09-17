% % % 
% % % 
clear all; close all; clc

logs = {...
{'MOOSLog_7_4_2013_____17_00_33', 'earth', 'track'},... %precision following - earth
{'MOOSLog_7_4_2013_____17_23_37', 'monolith', 'track'},...% precision following - monolith
{'MOOSLog_7_4_2013_____16_47_54', 'control', 'track'},...% precision following - control
{'MOOSLog_16_4_2013_____21_23_31', 'earth', 'skidpad'},... zero landmark -earth
{'MOOSLog_16_4_2013_____21_15_08', 'monolith', 'skidpad'},...zerolandmark - monolith
{'MOOSLog_16_4_2013_____21_38_43', 'control', 'skidpad'},... zero landmark - control
};
% log_name = {'MOOSLog_16_4_2013_____20_59_11', 'earth};

% % cumulative data
dev_avg = [];
dev_warn_pct = [];
dev_crit_pct = [];
dev_var = [];
dev_std = [];
dst_avg = [];
dst_warn_pct = [];
dst_crit_pct = [];
dst_var = [];
dst_std = [];
dst_dev_cov = {};

fid = fopen('./data.txt','w+');

fvels = {};
dists = {};

for log_n = 1:length(logs)
    log_name = logs{log_n};
    fprintf(fid, '\n\n\n%s -- %s, @ %s\n', logs{log_n}{1}, logs{log_n}{2}, logs{log_n}{3});
    input_data
    
%     if log_n == 1
%         dev = dev(1:149);
%         dst = dst(1:149);
%         dst_thold_crit = dst_thold_crit(1:149);
%         dst_thold_warn = dst_thold_warn(1:149);
%         ftime = ftime(1:149);
%         fvel = fvel(1:149);
%         ltime = ltime(1:149);
%         lvel = lvel(1:149);
%         path = path(1:149);
%         ptime = ptime(1:149);
% 
%         % useful variables
%         dev_thold_warn = 1;
%         dev_thold_crit = 2;
%         one_vec = ones(1,length(ptime));
%     end

    
    plot_data
    calc_data
%     pause
%     close all
    fvels{log_n} = fvel;
    dists{log_n} = dst;

    
    
end


% find the best runs for each data
fprintf(fid, '\n\n\n-------- Best --------\n\n');
% 
% [best_dev_avg best_dev_avg_idx] = min(dev_avg);
% [best_dev_warn_pct best_dev_warn_pct_idx] = min(dev_warn_pct);
% [best_dev_crit_pct best_dev_crit_pct_idx] = min(dev_crit_pct);
% [best_dev_var best_dev_var_idx] = min(dev_var);
% [best_dev_std best_dev_std_idx] = min(dev_std);
% [best_dst_avg best_dst_avg_idx] = min(dst_avg);
% [best_dst_warn_pct best_dst_warn_pct_idx] = min(dst_warn_pct);
% [best_dst_crit_pct best_dst_crit_pct_idx] = min(dst_crit_pct);
% [best_dst_var best_dst_var_idx] = min(dst_var);
% [best_dst_std best_dst_std_idx] = min(dst_std);
% 
% 
mu_req = {};
mu_dst = {};
for n = 1:6
%     mu_req{n} = [];
    for idx = 1:length(fvels{n})
        mu_req{n} = fvels{n}.^2./(2*dists{n}*9.81);
        [f,x] = ksdensity(mu_req{n}, 'function','pdf');
        mu_dst{n} = [x-min(x);f];
    end
end


fig_pf_mu = figure('Name','PF mu');
plot(mu_dst{1}(1,:), mu_dst{1}(2,:),'b',...
     mu_dst{2}(1,:), mu_dst{2}(2,:),'g',...
     mu_dst{3}(1,:), mu_dst{3}(2,:),'r',...
     'LineWidth',3);
hold on
plot([0.5 0.5],[0 4.75],'k',...
     [1 1],[0 4.75],'k',...
     'LineWidth',3)
title('PDF comparison for required \mu to stop - Precision Following'); xlabel('\mu_{required}'); ylabel('Probability mass')
legend('Earth','Monolith','Control','Warning','Critical'); grid on
set(findall(gcf,'type','text'),'fontSize',14,'fontWeight','bold')



fig_zl_mu = figure('Name','ZL mu');
plot(mu_dst{4}(1,:), mu_dst{4}(2,:),'b',...
     mu_dst{5}(1,:), mu_dst{5}(2,:),'g',...
     mu_dst{6}(1,:), mu_dst{6}(2,:),'r',...
     'LineWidth',3);
hold on
plot([0.5 0.5],[0 18],'k',...
     [1 1],[0 18],'k',...
     'LineWidth',3)
title('PDF comparison for required \mu to stop - Zero Landmark'); xlabel('\mu_{required}'); ylabel('Probability mass')
legend('Earth','Monolith','Control','Warning','Critical'); grid on
set(findall(gcf,'type','text'),'fontSize',14,'fontWeight','bold')



fclose(fid);


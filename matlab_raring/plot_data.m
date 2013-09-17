% % % Do plotting
scnsz = get(0, 'ScreenSize');

% % % dst dev % %
% fig_dst_dev = figure('Name',strcat('Distace and Deviation (',log_name{2},') @ ',log_name{3}));
% subplot(2,1,1)
% plot(ptime, dev,'-b',...
%      ptime, one_vec*dev_thold_warn, '-y',...
%      ptime, one_vec*dev_thold_crit, '-r',...
%      ptime, -one_vec*dev_thold_crit, '-r',...
%      ptime, -one_vec*dev_thold_warn, '-y',...
%      'LineWidth',2)
% title(strcat('Deviation - ',log_name{2})); xlabel('Time (s)'); ylabel('Deviation (m)'); legend('Dev.','Warn','Crit.', 'Location','Best'); grid on
% subplot(2,1,2)
% plot(ptime, dst,'-b',...
%      ptime, dst_thold_warn, '-y',...
%      ptime, dst_thold_crit, '-r',...
%      'LineWidth',2)
% title(get(gcf,'Name')); xlabel('Time (s)'); ylabel('Distance(m)'); legend('Dst.','Warn','Crit.', 'Location','BestOutside'); grid on
% set(findall(gcf,'type','text'),'fontSize',14,'fontWeight','bold')
% 
% saveas(fig_dst_dev, strcat('./fig/dst_dev/',log_name{1},'-',log_name{2},'.fig'))
% set(fig_dst_dev, 'Position', [0 0 scnsz(3) scnsz(4) ] );
% saveas(fig_dst_dev, strcat('./png/dst_dev/',log_name{1},'-',log_name{2},'.png'))
% 
% 
% 
% % % velocities % %
% fig_vel = figure('Name',strcat('Velocities (',log_name{2},') @ ',log_name{3}));
% plot(ptime, fvel,...
%      ptime, lvel,...
%      'LineWidth',2)
% title(get(gcf,'Name')); xlabel('Time (s)'); ylabel('Speed (m/s)'); legend('Foll.','Lead', 'Location','BestOutside'); grid on
% set(findall(gcf,'type','text'),'fontSize',14,'fontWeight','bold')
% 
% saveas(fig_vel, strcat('./fig/vel/',log_name{1},'-',log_name{2},'.fig'))
% set(fig_vel, 'Position', [0 0 scnsz(3) scnsz(4)]);
% saveas(fig_vel, strcat('./png/vel/',log_name{1},'-',log_name{2},'.png'))

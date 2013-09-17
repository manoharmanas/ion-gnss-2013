clear all; close all; clc

% inc = 0.01;
% normal_dist = @(x,s,m) 1/(s*sqrt(2*pi)) * exp(-(x-m).^2/(2*s^2));
% sample_vec = @(x) min(x):inc:max(x);

% % Precision Following
% Earth
pfe = load('./parsed/earth/precision_following_dev.mat');
[pfe_d,pfe_x] = ksdensity(pfe.dev, 'function','pdf');
% pfe_mean = mean(pfe.dev);
% pfe_std = std(pfe.dev);
% pfe_smp = sample_vec(pfe.dev);
% pfe_dist = normal_dist(pfe_smp, pfe_std, pfe_mean);

% Monolith
pfm = load('./parsed/monolith/precision_following_dev.mat');
% pfm_mean = mean(pfm.dev);
% pfm_std = std(pfm.dev);
[pfm_d,pfm_x] = ksdensity(pfm.dev, 'function','pdf');

% Control
pfc = load('./parsed/control/precision_following_dev.mat');
% pfc_mean = mean(pfc.dev);
% pfc_std = std(pfc.dev);
[pfc_d,pfc_x] = ksdensity(pfc.dev, 'function','pdf');

fig_pf = figure('Name','PF');
plot(pfe_x, pfe_d, 'b',...
     pfm_x, pfm_d, 'g',...
     pfc_x, pfc_d, 'r',...
     'LineWidth',3); 
grid on; title('PDF of Lateral Path Deviation - Precision Following'); xlabel('Deviation (m)'); ylabel('Probability');
hold on; plot([0 0],[0 1.9],'k','LineWidth',2.5)
legend('Earth','Monolith','Control','Zero')
set(findall(gcf,'type','text'),'fontSize',14,'fontWeight','bold')


% % Zero Landmark
% Earth
zle = load('./parsed/earth/zero_landmark_dev.mat');
% zle_mean = mean(zle.dev);
% zle_std = std(zle.dev);
[zle_d,zle_x] = ksdensity(zle.dev, 'function','pdf');

% Monolith
zlm = load('./parsed/monolith/zero_landmark_dev.mat');
% zlm_mean = mean(zlm.dev);
% zlm_std = std(zlm.dev);
[zlm_d,zlm_x] = ksdensity(zlm.dev, 'function','pdf');

% control
zlc = load('./parsed/control/zero_landmark_dev.mat');
% zlc_mean = mean(zlc.dev);
% zlc_std = std(zlc.dev);
[zlc_d,zlc_x] = ksdensity(zlc.dev, 'function','pdf');

fig_pf = figure('Name','PF');
plot(zle_x, zle_d, 'b',...
     zlm_x, zlm_d, 'g',...
     zlc_x, zlc_d, 'r',...
     'LineWidth',3); 
grid on; title('PDF of Lateral Path Deviation - Zero Landmark'); xlabel('Deviation (m)'); ylabel('Probability');
hold on; plot([0 0],[0 .55],'k','LineWidth',2.5)
legend('Earth','Monolith','Control','Zero')
set(findall(gcf,'type','text'),'fontSize',14,'fontWeight','bold')


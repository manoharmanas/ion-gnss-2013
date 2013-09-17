% plot lane-change replication
clear all; close all; clc


leader = [1 3 2 5];
follower = [3 4 3 5];


x = 1;
while length(x) < length(leader)
   x(x+1) = x(x)+1;
end
fig_lane_change = figure('Name','Lane Change');
plot(x,leader,'b.',...
     x,follower,'g.','MarkerSize', 20);
hold on
for n=x
    plot(n,[leader(n) follower(n)],'--r','LineWidth',5);    
end
set(gca, 'XTick', 1:x(end), 'YTick', 1:5);
xlim([0 length(x)+1]); ylim([0 6]);
xlabel('Attempt #'); ylabel('Cone Pair'); title('Lane Change Replication Results')
legend('Leader', 'Follower','Location','Best')

saveas(fig_lane_change, '/home/rgcofield/thesis/hon_thesis/figs/lane_change_results.png');
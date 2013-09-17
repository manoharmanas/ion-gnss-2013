%%% Calculations

dev_avg(log_n) = mean(abs(dev));
dev_warn_pct(log_n) = length(find(dev>dev_thold_warn))/length(dev);
dev_crit_pct(log_n) = length(find(dev>dev_thold_crit))/length(dev);
dev_var(log_n) = var(dev);
dev_std(log_n) = std(dev);

dst_avg(log_n) = mean(dst);
dst_warn_pct(log_n) = length(find(dst<dst_thold_warn))/length(dst);
dst_crit_pct(log_n) = length(find(dst<dst_thold_crit))/length(dst);
dst_var(log_n) = var(dst);
dst_std(log_n) = std(dst);

dst_dev_cov{log_n} = cov([dst,dev]);


fprintf(fid, '\tDeviation\n');
fprintf(fid, '\t\tMean Abs:   %.2f\n',dev_avg(log_n));
fprintf(fid, '\t\tWarn State: %.2f %%\n', dev_warn_pct(log_n)*100);
fprintf(fid, '\t\tCrit State: %.2f %%\n', dev_crit_pct(log_n)*100);
fprintf(fid, '\t\tVariance:   %f\n', dev_var(log_n));
fprintf(fid, '\t\tStd Dev:    %f\n', dev_std(log_n));
fprintf(fid, '\tDistance\n');
fprintf(fid, '\t\tMean:       %.2f\n',dst_avg(log_n));
fprintf(fid, '\t\tWarn State: %.2f %%\n', dst_warn_pct(log_n)*100);
fprintf(fid, '\t\tCrit State: %.2f %%\n', dst_crit_pct(log_n)*100);
fprintf(fid, '\t\tVariance:   %f\n', dst_var(log_n));
fprintf(fid, '\t\tStd Dev:    %f\n', dst_std(log_n));
fprintf(fid, '\tCovariance of Distance/Deviation:\n');
fprintf(fid, '\t\t[%7.2f  %7.2f]\n',dst_dev_cov{log_n});


save(strcat('./parsed/',log_name{2},'/',log_name{1},'.mat'))
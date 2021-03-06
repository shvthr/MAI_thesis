clear all;
clc;
load ('exp01_10_23_21.mat');

kernel_names = {'RBF_kernel', 'poly_kernel','lin_kernel'};

steps = 1;

entries = [];
for Y_lags = 1:20
    for k =1:length(kernel_names)
        current_entry.Ylags = Y_lags;
        current_entry.kernel = kernel_names{k};
        sse = 0;
        mae = 0;
        mape = 0;
        for i = 1:size(outputs, 2)
            if outputs(i).lags == Y_lags && ...
                    strcmp(outputs(i).kernel, kernel_names{k})
                sse = sse + outputs(i).mse;
                mae = mae + outputs(i).mae;
                mape = mape + outputs(i).mape;
            end
        end
        current_entry.mse = sse/10;
        current_entry.mae = mae/10;
        current_entry.mape = mape/10;
        entries = [entries current_entry];
    end
end

min_mse = inf;
best_ind = -1;
for i = 1 : size(entries, 2)
    if entries(i).mse < min_mse
        best_ind = i;
        min_mse = entries(i).mse;
    end
end

fprintf('Ylags:\t%d\n', entries(best_ind).Ylags);
fprintf('kernel:\t%s\n', entries(best_ind).kernel);
fprintf('mse:\t%f\n', entries(best_ind).mse);
fprintf('mae:\t%f\n', entries(best_ind).mae);
fprintf('mape:\t%f\n', entries(best_ind).mape);


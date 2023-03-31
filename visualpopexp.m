figs = 20; % no. of sample figures for each set size in each search
trials = figs*4*2; % 4 set sizes for 2 different search types
right = zeros(2,4); wrong = zeros(2,4);
avgtime_target_present = zeros(2,4);
avgtime_target_absent = zeros(2,4);

prt_target_present = []; prt_target_absent = [];

%% Pop-Out Searches
for counter = 4:4:16
    
    start = figure; 
    text(0.1,0.7,'Press Any Key to Continue & Load Focus Screen');
    text(0.1,0.6,'Target is Green O, Press P for Present, Press A for Absent');
    pause; close;
    text(0.5,0.5,'+', 'FontSize', 25);
    pause; close;
    x = randperm(figs);
    for i = 1:figs
        % creating equal number of trials with/without target
        if (x(i) <= (figs/2))
            target = 'p';
        else
            target = 'a';
        end
        % randomly assign no. of x's and o's figure
        nx = randi([0 counter]);
        no = counter - nx;
        pl = figure;
        % plots with target present
        if (target == 'p')
            for c1 = 1:nx
                text(rand(), rand(), 'x', 'FontSize', 25, 'Color', 'r');
            end
            for c2 = 1:(no-1)
                text(rand(), rand(), 'o', 'FontSize', 25, 'Color', 'r');
            end
            text(rand(), rand(), 'o', 'FontSize', 25, 'Color', 'g');
        % plots with target absent    
        elseif (target == 'a')
            for c1 = 1:nx
                text(rand(), rand(), 'x', 'FontSize', 25, 'Color', 'r');
            end
            for c2 = 1:no
                text(rand(), rand(), 'o', 'FontSize', 25, 'Color', 'r');
            end
        end
        tic;
        pause; time = toc;
        user_ans = get(pl, 'CurrentCharacter');
        close;
        % compare user inputs with plots to measure reaction times & guess
        % accuracy
        if((strcmp(target, 'p') && strcmp(user_ans, 'p'))) 
            prt_target_present = [prt_target_present,time];
            right(1,counter/4) = right(1,counter/4) + 1;
        elseif((strcmp(target, 'a') && strcmp(user_ans, 'a')))
            prt_target_absent = [prt_target_absent,time];
            right(1,counter/4) = right(1,counter/4) + 1;
        else
            wrong(1,counter/4) = wrong(1,counter/4) + 1;
        end
    end
    % store average time taken for right/wrong predictions
    avgtime_target_present(1,counter/4) = mean(prt_target_present);
    avgtime_target_absent(1,counter/4) = mean(prt_target_absent);
    
    
end

crt_target_present = []; crt_target_absent = [];

%% Conjunction Search
for counter = 4:4:16
    
    start = figure; 
    text(0.1,0.7,'Press Any Key to Continue & Load Focus Screen');
    text(0.1,0.6,'Target is Green O, Press P for Present, Press A for Absent');
    pause; close;
    text(0.5,0.5,'+', 'FontSize', 25);
    pause; close;
    x = randperm(figs);
    for i = 1:figs
        % creating equal number of trials with/without target
        if (x(i) <= (figs/2))
            target = 'p';
        else
            target = 'a';
        end
        % assign equal no. of x's and o's figure
        nx = counter / 2;
        ngx = nx/2;
        nrx = nx - ngx;
        no = counter - nx;
        pl = figure;
        % plots with target present
        if (target == 'p')
            text(rand(), rand(), 'o', 'FontSize', 25, 'Color', 'g');
            for c1 = 1:nrx
                text(rand(), rand(), 'x', 'FontSize', 25, 'Color', 'r');
            end
            for c1 = 1:(ngx)
                text(rand(), rand(), 'x', 'FontSize', 25, 'Color', 'g');
            end
            for c2 = 1:(no-1)
                text(rand(), rand(), 'o', 'FontSize', 25, 'Color', 'r');
            end
        % plots with target absent    
        elseif (target == 'a')
            for c1 = 1:nrx
                text(rand(), rand(), 'x', 'FontSize', 25, 'Color', 'r');
            end
            for c2 = 1:no
                text(rand(), rand(), 'o', 'FontSize', 25, 'Color', 'r');
            end
            for c1 = 1:ngx
                text(rand(), rand(), 'x', 'FontSize', 25, 'Color', 'g');
            end
        end
        tic;
        pause; time = toc;
        user_ans = get(pl, 'CurrentCharacter');
        close;
        % compare user inputs with plots to measure reaction times & guess
        % accuracy
        if((strcmp(target, 'p') && strcmp(user_ans, 'p'))) 
            crt_target_present = [crt_target_present,time];
            right(2,counter/4) = right(2,counter/4) + 1;
        elseif((strcmp(target, 'a') && strcmp(user_ans, 'a')))
            crt_target_absent = [crt_target_absent,time];
            right(2,counter/4) = right(2,counter/4) + 1;
        else
            wrong(2,counter/4) = wrong(2,counter/4) + 1;
        end
    end
    % store average time taken for right/wrong predictions
    avgtime_target_present(2,counter/4) = mean(crt_target_present);
    avgtime_target_absent(2,counter/4) = mean(crt_target_absent);
    
    
end

%% Correlation Parameters
% set sizes
n = [4, 8, 12, 16]';

% reaction times for Pop Out search
p_target_present = [avgtime_target_present(1,1), avgtime_target_present(1,2),...
    avgtime_target_present(1,3), avgtime_target_present(1,4)]';
p_target_absent = [avgtime_target_absent(1,1), avgtime_target_absent(1,2),...
    avgtime_target_absent(1,3), avgtime_target_absent(1,4)]';

% reaction times for Conjunction Visual search
c_target_present = [avgtime_target_present(2,1), avgtime_target_present(2,2),...
    avgtime_target_present(2,3), avgtime_target_present(2,4)]';
c_target_absent = [avgtime_target_absent(2,1), avgtime_target_absent(2,2),...
    avgtime_target_absent(2,3), avgtime_target_absent(2,4)]';

%% Pearson Correlation Coefficients
% coefficient M's and p-value p's

% Pop-Out when Target Present
[M1,p1] = corrcoef(n,p_target_present);
M1 = M1(1,2); p1 = p1(1,2);
% Conjunction when Target Present
[M2,p2] = corrcoef(n,c_target_present);
M2 = M2(1,2); p2 = p2(1,2);
% Pop-Out when Target Absent
[M3,p3] = corrcoef(n,p_target_absent);
M3 = M3(1,2); p3 = p3(1,2);
% Conjunction when Target Absent
[M4,p4] = corrcoef(n,c_target_absent);
M4 = M4(1,2); p4 = p4(1,2);

%% Analyses Plots

% Set Size vs RT when Target Present
figure;
plot(n,p_target_present);
hold on;
plot(n,c_target_present, 'r');
title(sprintf('Accurately Detected Presence of Target for %d Trials', trials));
legend('Pop-Out', 'Conjunction');
xlabel('Set Size');
ylabel('Average Reaction Time (s)'); ylim([0 2]);
hold off;
% Set Size vs RT when Target Absent
figure;
plot(n,p_target_absent);
hold on;
plot(n,c_target_absent, 'r');
title(sprintf('Accurately Detected Absence of Target for %d Trials', trials));
legend('Pop-Out', 'Conjunction');
xlabel('Set Size');
ylabel('Average Reaction Time (s)'); ylim([0 2]);
hold off;



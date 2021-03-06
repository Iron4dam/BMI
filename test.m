data = load('monkeydata_training.mat');

for d = 1:8
    X = ones(30000, 99);
    y = ones(30000, 2);
    start = 1;
    win_len = 20;
    
    for t = 1:100
        for c = 1:98 
            t0 = data.trial(t, d).spikes(c, 300-win_len:end-100);
            t0_ = zeros(1, length(t0));
            for i = win_len:length(t0)
                t0_(i) = mean(t0(1, i-win_len+1:i));
            end
            t0_ = t0_(win_len:end)';
    %         X(start:start+length(t0_)-1, 1+c+c:2+c+c) = [t0_, t0_.*t0_*10];
            X(start:start+length(t0_)-1, 1+c) = t0_;
            
            target = data.trial(t,d).handPos(1:2,300:end-99)';
            y(start:start+length(t0_)-1, :) = target;
        end
%         a0 = data.trial(t, d).handPos(1, 299:end-100);
%         a1 = data.trial(t, d).handPos(1, 300:end-99);
%         y(start:start+length(t0_)-1, :) = a1 - a0;
    %     y(start:start+length(t0_)-1, :) = data.trial(t, d).r_theta();
        start = start + length(t0_);
    end
    X = X(1:start-1, :);
    y = y(1:start-1, :);
%     [beta,Sigma,E,CovB,logL] = mvregress(y, X);

    disp(logL)
%     disp(stats(1));
end

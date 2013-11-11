%% Distance estimator based on RSSI
% The equation is derived from the log-distance formula. This can be done
% with the following commands.
% > syms p p_d0 d beta
% > solve(p == p_d0 - 10*beta*log(d), d)
function distance = predict_distance(p, p_d0, beta)
    distance = exp(-(p - p_d0)/(10*beta));
end
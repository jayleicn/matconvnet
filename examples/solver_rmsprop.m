function [weights, g_sqr] = solver_rmsprop(weights, g_sqr, grad, opts, lr)
%SOLVER_RMSPROP
%   Example RMSProp solver, for use with CNN_TRAIN and CNN_TRAIN_DAG.
%
%   Set the initial learning rate for RMSProp in the options for
%   CNN_TRAIN and CNN_TRAIN_DAG. Note that a learning rate that works for
%   SGD may be inappropriate for RMSProp; the default is 0.001.
%
%   Solver options: (opts.train.solverOpts)
%
%   `epsilon`:: 1e-8
%      Small additive constant to regularize variance estimate.
%
%   `rho`:: 0.99
%      Moving average window for variance update, between 0 and 1 (larger
%      values result in slower/more stable updating).

% Copyright (C) 2016 Joao F. Henriques.
% All rights reserved.
%
% This file is part of the VLFeat library and is made available under
% the terms of the BSD license (see the COPYING file).

if isempty(g_sqr)
  g_sqr = 0 ;
end

g_sqr = g_sqr * opts.rho + grad.^2 * (1 - opts.rho) ;

weights = weights - lr * grad ./ (sqrt(g_sqr) + opts.epsilon) ;
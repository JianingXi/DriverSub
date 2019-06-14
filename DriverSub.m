function [Mutation_Score,SubgroupSpecificity] = ...
    DriverSub(X_mat,K_dim,lambda_Z,lambda_W)

    [N_sample, P_gene] = size(X_mat);
    % X: genes x samples
    
    eps_temp = 10^(-5);
    W_init = max(randn(N_sample,K_dim),eps_temp); % init W
    Z_init = max(pinv(X_mat'*W_init),eps_temp); % init Z
    W_prev = W_init; Z_prev = Z_init;

    res_W = 2; res_Z = 2;
    while res_W >= 10^-3 || res_Z >= 10^-3 
        Z_mat = Z_prev.*(W_prev'*X_mat) ...
            ./((W_prev'*W_prev)*Z_prev + 0.5*lambda_Z + eps_temp);

        W_mat = W_prev.*(X_mat*Z_mat') ...
            ./(W_prev*(Z_mat*Z_mat') + lambda_W*W_prev + eps_temp);

        diag_w = sum(W_mat,1);
        diag_w(diag_w <= 0) = 1;
        W_mat = W_mat*diag(diag_w.^(-1));
        Z_mat = diag(diag_w)*Z_mat;

        res_W = (norm(W_mat-W_prev)/norm(W_prev))^2;
        res_Z = (norm(Z_mat-Z_prev)/norm(Z_prev))^2;

        W_prev = W_mat; Z_prev = Z_mat;
    end

    Z_mat = Z_mat';
    sigma_vec = sqrt(sum(Z_mat.^2,1)/P_gene)';
    Mutation_Score = (Z_mat.^2)*(sigma_vec.^-2);
    
    quantile_cur = 0.01*max(max(Z_mat));
    SubgroupSpecificity = (Z_mat > quantile_cur);
end % function
function x = mashup_heterogeneous(network_files, ngene, nodenum1,ndim,lanmda,svd_approx)
%network_files: The file path
%ngene: Number of nodes entered in the network
%nodenum1:Number of nodes in the first part of the network
%ndim:The dimension of the output vector
%lanmda:The weight of the internal hop of the subnet
%svd_approx:Whether to use svd approximation
if svd_approx
    RR_sum = zeros(ngene);
    a = dlmread(network_files);
    b =[];
    for i = 3:size(a,2)
        b(:,1) = a(:,1);
        b(:,2) = a(:,2);
        b(:,3) = a(:,i);
        A = load_network_heterogeneous(b,ngene,nodenum1,lanmda);
        fprintf('Running diffusion\n');
        Q = rwr(A, 0.5);
        R = log(Q + 1/ngene);
        RR_sum = RR_sum + R * R';
    end
    clear R Q A
    fprintf('All networks loaded. Learning vectors via SVD...\n');
    [V, d] = eigs(RR_sum, ndim);
    x = diag(sqrt(sqrt(diag(d)))) * V';
else
     Q_concat = [];
     a = dlmread(network_files);
     b =[];
     for i = 3:size(a,2)
         b(:,1) = a(:,1);
         b(:,2) = a(:,2);
         b(:,3) = a(:,i);
         A = load_network_heterogeneous(b,ngene,nodenum1,lanmda);
         fprintf('Running diffusion\n');
         Q = rwr(A, 0.5);
         Q_concat = [Q_concat; Q];
     end
     clear Q A
    Q_concat = Q_concat / length(network_files);

    fprintf('All networks loaded. Learning vectors via iterative optimization...\n');
    x = vector_embedding(Q_concat, ndim, 1000);
end
fprintf('Mashup features obtained.\n');
end
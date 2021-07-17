function A = load_network_eterogeneous(M, ngene,n,q)
    A = full(sparse(M(:,1), M(:,2), M(:,3), ngene, ngene));
    if ~isequal(A, A')
      A = A + A';
    end
    A = A + diag(sum(A, 2) == 0);
    A11 = A(1:n,1:n);
    A12 = A(1:n,n+1:end);
    A21 = A(n+1:end,1:n);
    A22 = A(n+1:end,n+1:end);
    A = [q*A11,(1-q)*A12;(1-q)*A21,q*A22];
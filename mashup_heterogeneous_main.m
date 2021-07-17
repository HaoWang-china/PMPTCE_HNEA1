function mashup_heterogeneous_main(network_files, ngene, nodenum1,ndim,lanmda,save,svd_approx,f)
%network_files: The file path
%ngene: Number of nodes entered in the network
%nodenum1:Number of nodes in the first part of the network
%ndim:The dimension of the output vector
%lanmda:The weight of the internal hop of the subnet
%svd_approx:Whether to use svd approximation
%save:save = 1 means to save the generated results, save = 0 means not to save the generated results
%f:The path of the file to be saved (txt file is recommended)
a = mashup_heterogeneous(network_files, ngene, nodenum1,ndim,lanmda,svd_approx);
if save == 1
    num = 1:ngene;
    save = [];
    save(1,:) = num;
    for i = 1:ndim
        save((i+1),:) = a(i,:);
    end 
    b = size(save,2);
    fid = fopen(f,'w');
    for i = 1:b
        y = save(:,i);
       fprintf(fid,'%f\t',[y]) ;
       fprintf(fid,'\n');
    end
end

function [A]=OMPerr(D,X,errorGoal); 
%=============================================
% Sparse coding of a group of signals based on a given 
% dictionary and specified number of atoms to use. 
% input arguments: D - the dictionary
%                  X - the signals to represent
%                  errorGoal - the maximal allowed representation error for
%                  each siganl.
% output arguments: A - sparse coefficient matrix.
%=============================================
[n,P]=size(X);
[n,K]=size(D);
E2 = errorGoal^2*n;
% E2 = errorGoal;
maxNumCoef = 0.5*n;
A = sparse(size(D,2),size(X,2));
for k=1:1:P,
    a=[];
    x=X(:,k);
    residual=x;
	indx = [];
	a = [];
	currResNorm2 = sum(residual.^2);
% currResNorm2 = max(abs(residual));
	j = 0;
%     while currResNorm2>E2 & j < maxNumCoef,
 while currResNorm2>E2 
		j = j+1;
        proj=D'*residual;
        pos=find(abs(proj)==max(abs(proj)));
        pos=pos(1);
        indx(j)=pos;
        a=pinv(D(:,indx(1:j)))*x;
        residual=x-D(:,indx(1:j))*a;
		currResNorm2 = sum(residual.^2);
% currResNorm2 = max(abs(residual));
   end;
   if (length(indx)>0)
       A(indx,k)=a;
   end
end;
return;

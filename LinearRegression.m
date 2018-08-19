function [a1,a0] = LinearRegression( x,y )
%Function file for linear regression

%Calculating the length of n
n=length(x);

%Validating whether the two matice sizes match
if n ~= length(y)
    %If it doesnt match displaying error message
    error('Matrix sizes do not match. Terminating Program ')    
end

%Calculating the a0 and a1(coefficients) values
a1=(n*sum(x.*log(y))-sum(x)*sum(log(y)))/(n*sum(x.^2)- sum(x)^2);
a0=mean(log(y))-a1*mean(x);

end


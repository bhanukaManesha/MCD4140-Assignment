% Question 2
% ------------------------------------------------------------------------
% Name: BHANUKA MANESHA SAMARASEKARA VITHARANA GAMAGE
% ID: 28993373
% Last Modified: 07-05-2017 10:20
% ========================================================================
%
% Note: 
% Insert your question 2 code in this m-file. 
 
%% Q2a
%% Import data from text file.
 
% Importing the LightTransmit.txt file into MATLAB
filename = 'LightTransmit.txt';
 
% Opening the file in read only mode
file_id = fopen(filename ,'r');
 
% Importing the data under corresponding variables
%L = length
%Intensity = Intensity of light transmitted through specimens of a transparent solid 
values = importdata('LightTransmit.txt');
L=values.data(1:end,1);
Intensity=values.data(1:end,3);
 
%Filtering the noisy data
for i= 1:length(Intensity)
    if Intensity(i)>10
       noisy(i)=i;  
    end
end
 
%Removing the unwanted noisy data
noisy(noisy==0)=[];
 
%Removing noisy data from the Intensity matrix and its corresponding L data value
Intensity(noisy) = [];
L(noisy) = [];
 
%Creating a matrix named 'transmission_data' with the filtered data
transmission_data = [L ,Intensity;];
 
%Converting Length from centimeter (cm) to meter(m)
for i = 1:length(L)
    L_meter(i) = L(i)/100;
end
 
%Transposing the matrix
L_meter = (L_meter)';
 
 
% Creating a new figure window to subplot (***Changing the default figure size so that all the data points can be seen clearly***)
FigHandle = figure('position',[100,100,1049,895]);
 
% Subplot for Intensity of light transmission vs Thickness
subplot(2,2,1)
 
%Plotting the scatter plot
scatter(L_meter,Intensity);
 
%Adding a title and labeling the axis
title('Intensity of Light Transmission vs Thickness (in metres)');
xlabel('Thickness(m)')
ylabel('Intensity of Light Transmission(watts/m2)')
 
%Adding a legend
legend('Data Points','location','NorthEast')
 
%Holding on to the graph
hold all
 
% Pausing the command until key press before starting next part
pause
 
%% Q2b
 
%Using polyfit to calculate the coefficients of the third order polynomial fit equation
p = polyfit(L_meter,Intensity,3);
 
%Creating a matrix for the x axis interpolated 50 data points
L_interpolated = linspace(min(L_meter), max(L_meter), 50);
 
%Using polyval to find the Interpolated Intensity data points that are 
%corresponding to the L_inter data points
Intensity_interpolated = polyval(p,L_interpolated);
 
%Plotting the interpolated data points on the previous graph in q1a
plot(L_interpolated,Intensity_interpolated,'r.')
 
%Updating the legend
legend('Data Points','Interpolated Data Points');
 
%Holding off the graph
hold off
 
% Calculating the extrapolated L_meter data points up to 0.16 m
L_extra = linspace(min(L_meter), 0.16, 50);
 
%Using the extrapolated L_meter data points and polyval function calculate
%the Extrapolated Intensity data points
Intensity_extrapolated = polyval(p,L_extra);
 
 
%Creating a subplot to plot the extrapolated data points
subplot(2,2,2)
 
%Plotting the scatter plot
scatter(L_meter,Intensity);
 
%Holding on to the graph
hold all
 
%Plotting the Extrapolated line
plot(L_extra,Intensity_extrapolated,'r.')
 
%Adding a title and labeling the axis
title('Intensity of Light Transmission vs Thickness (in meters)');
xlabel('Thickness(m)')
ylabel('Intensity of Light Transmission(watts/m2)')
 
%Adding a legend
legend('Data Points','Extrapolated Data Points','location','NorthEast');
 
%Using fprintf to print the conclusion
fprintf('Q2b) As the curve fitted is a 2nd order polynomial (quadratic function)\n     the intensity decreases with the thickness and again increases after a certain point. \n     There is a problem as the intensity cannot increase, so using polyfit we cannot get an accurate best fit line.\n')
 
%Holding off the graph
hold off
 
% Pausing the command until key press before starting next part
pause
 
%% Q2c
 
%Defining the variables
%I0 = Intensity of the incident beam
Io = 5;
 
%Using linear regression to get the two coefficients
[a1,a0] = LinearRegression(L_meter,transmission_data(:,2));
 
%Calculating the unknown variables beta and R using the coefficients
beta = -a1;                 %Calculating beta
R = 1 - sqrt(exp(a0)/Io);   %Calculating R
 
%Using fprintf to print the beta and R values on the command window
fprintf('Q2c) The absorption coefficient is %g\n     The fraction of light which is reflected at the interface is %g\n ',beta,R)
 
 
%% Q2d
 
%Defining the function for the transmission of light through a transparent
%solid 
IT = @(L) Io*(1-R)^2*exp(-beta*L);
 
%Creating a subplot to plot the fitted the curve
subplot(2,2,3)
 
%Plotting the graph for the fitted curve
plot(L_meter,IT(L_meter),'r-')
 
%Holding on to the graph
hold on
 
%Scatter plot of the data points in q1a
scatter(L_meter,transmission_data(:,2));
 
%Adding a title and labeling the axis
title('Intensity of Light Transmission vs Thickness (in meters)');
xlabel('Thickness(m)')
ylabel('Intensity of Light Transmission(watts/m2)')
 
%Adding a legend
legend('Interpolated Data','Data Points','location','NorthEast');
 
%Calculating coefficient of determination
x = L_meter;
y = Intensity;
alpha1=exp(a0);
beta1=a1;
st=sum((y-mean(y)).^2);
sr=sum((y-(alpha1*exp(beta1*x))).^2);
r2=(st-sr)/st;
 
%Using text label to display the coefficient on the graph
r2_string = num2str(r2);                        %Converting number to string
text(0.02,4.0,'Coefficient of Determination');  %Using text to print the label on the graph
text(0.03,3.9,r2_string);                         %Using text to print the value on the graph
 
%Holding off the graph
hold off
 
%Using subplot to plot the extrapolated plot for the fitted curve
subplot(2,2,4)
 
%Plotting the scatter plot
scatter(L_meter,Intensity);
 
%Holding on to the graph
hold all
 
%Plotting the extrapolated points using the points created in q2b
plot(L_extra,IT(L_extra),'r-')
 
%Adding a title and labeling the axis
title('Intensity of Light Transmission vs Thickness (in meters)');
xlabel('Thickness(m)')
ylabel('Intensity of Light Transmission(watts/m2)')
 
%Adding a legend
legend('Data Points','Extrapolated Data','location','NorthEast');


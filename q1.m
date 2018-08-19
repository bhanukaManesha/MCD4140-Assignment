% ========================================================================
% Question 1
% ------------------------------------------------------------------------
% Name: BHANUKA MANESHA SAMARASEKARA VITHARANA GAMAGE
% ID: 28993373
% Last Modified: 07-05-2017 10:20
% ========================================================================
%
% Note: 
% Insert your question 1 codes in this m-file. Hints and extra information
% are provided in this m-file as comments. The code to read image and 
% create subplots are given below. Include your plotting code after each of
% the subplot() function. Fill in your solutions where indicated by "...".
 
%% Part a
% ======
% Latitudinal Acceleration is the acceleration along the north-south/vertical axis. 
% Longitudinal Acceleration is the acceleration along the east-west/horizontal axis.
% The Latitudinal Acceleration and Longitudinal Acceleration is measured with respect to the starting point of the track
%
% Lateral G is the acceleration created when a vehicle corners that tends to push a vehicle sideways. 
% Accelerating/Braking G is associated to throttle input and brake input.
% The Lateral G and Accelerating/Braking G is measured with respect to the race car.
 
%% Import data from text file.
 
% Importing the race_data file into MATLAB
filename = 'race_data.dat';
% Opening the file in read only mode
file_id = fopen(filename ,'r');
 
% Importing the data under corresponding variables
% time = race time
% A_long = Longitudinal acceleration
% A_lat = Latitudinal acceleration 
% G_ab = Forward acceleration and Braking acceleration
% G_lat = Lateral G-force acceleration 
values = importdata('race_data.dat');
time=values.data(:,1);
A_long=values.data(:,2) ;
A_lat=values.data(:,3);
G_ab=values.data(:,4) ;
G_lat=values.data(:,5);
 
%% Plotting the graphs in one plot
 
% Creating a new figure window to subplot
figure
 
% Plotting time vs Longitudinal acceleration and holding on to the graph 
plot(time,A_long,'r-')
hold on
% Plotting time vs Latitudinal acceleration and holding on to the graph 
plot(time,A_lat,'b-')
hold on
% Plotting time vs Lateral G-force acceleration and holding on to the graph 
plot(time,G_lat,'k-')
hold on
% Plotting time vs Forward acceleration and Braking acceleration and holding on to the graph 
plot(time,G_ab,'g-')
hold on
 
% Labelling the x and y axis as time and acceleration
xlabel('time (s)');
ylabel('acceleration/G(m/s-2)');
 
% Adding a title to the plot
title('Acceleration vs Time Plot');
 
% Adding a legend to the plot
legend('Longitudinal Acceleration','Latitudinal Acceleration','Lateral G-force Acceleration','Forward and Braking G-force Acceleration','location','Northeast');
 
%% Verifying that the acceleration values are between -1.5 and 1.5
 
% Calculating the maximum and minimum Latitudinal acceleration
max_A_lat = max(A_lat);
min_A_lat = min(A_lat);
 
% Calculating the maximum and minimum Longitudinal acceleration
max_A_long = max(A_long);
min_A_long = min(A_long);
 
% Calculating the maximum and minimum Lateral G-force acceleration
max_G_lat = max(G_lat);
min_G_lat = min(G_lat);
 
% Calculating the maximum and minimum Forward acceleration and Braking acceleration
max_G_ab = max(G_ab);
min_G_ab = min(G_ab);
 
% Calculating the maximum and minimum time
time_max = max(time);
time_min = min(time);
 
% Using fprintf to output all the maximum and minimum values to the command window
fprintf('Q1a) The range of Latitudinal Acceleration is %g to %g \n',max_A_lat,min_A_lat)
fprintf('     The range of Longitudinal Acceleration is %g to %g \n',max_A_long,min_A_long)
fprintf('     The range of Lateral G-force Acceleration is %g to %g \n',max_G_lat,min_G_lat)
fprintf('     The range of Forward and Braking G-force Acceleration is %g to %g \n\n',max_G_ab,min_G_ab)
 
fprintf('     The range of Time is %g to %g \n',time_min,time_max)
 
% Verifying that all the acceleration values are between -1.5 to 1.5 and time is within the range 1 to 180
fprintf('     Therefore we can verify that all the accelerations are within the range 1.5 to -1.5 and the time is between 0 and 180\n\n')
 
% Pausing the command until key press before starting next part
pause
 
%% Part b
% ======
% Google map reference of The Glen : http://share.traqmate.com/tracks/united-states/new-york/watkins-glen-international-the-glen/5848#info 
 
%% Intergrating the A_lat and A_long to get V_lat and V_long
 
V_long = cumtrapz(A_long);
V_lat = cumtrapz(A_lat);
 
%% Intergrating the A_lat and A_long to get V_lat and V_long
 
d_lat = cumtrapz(V_lat);
d_long= cumtrapz(V_long);
 
%% Plotting the map and the track image side by side
 
% Creating a new figure window to subplot
figure
 
% Subplot for google map track image
subplot(1,2,1)
 
% Importing the track_map.pmng to MATLAB
track = imread('track_map.png');
 
% Displaying the image
imshow(track)
 
% Adding title for the image
title('Satellite image of "The Glen" from Google Maps');
 
% Subplot for the race car displacement
subplot(1,2,2)
 
% Plotting the Latitudinal distance vs Longitudinal distance
plot(d_long,d_lat)
 
%Labeling the axis and adding a title
xlabel('Longitudinal Distance (m)');
ylabel('Latitudinal Distance (m)');
title('Latitudinal Distance vs Longitudinal Distance');
 
% Pausing the command until key press before starting next part
pause
%% Part c
% ======
% The lateral Gs are above zero at left turning corners and
% are below zero at right turning corners. You are required to manually
% find a negative threshold value (increment of 0.1) where all points below this value 
% identifies the right turning corners correctly. You are also required to
% find a positive threshold value (increment of 0.1) where all points above this value
% identifies the left turning corners correctly. 
 
 
%% Sorting the left turning and right turning values and plotting the graph
 
% Creating a new figure window to subplot (***Changing the default figure size so that all the data points can be seen clearly***)
FigHandle = figure('position',[100,100,1049,895]);
 
% Subplot for lateral Gs
subplot(1,2,1)
 
% Turning thresholds
threshold_lr = 0.2;
 
% Data rows (indices a.k.a. _idx) that are outside the thresholds
% These contain data from the time when the vehicle is turning
 
% Plot everything
 
% Using a for loop to plot the graph
for i = 1:length(G_lat)
    if (G_lat(i)> threshold_lr)
           plot(time(i),G_lat(i),'b.') % Plotting the values greater than the threshold value as blue dots
           hold on                     % Holding on to the graph
    else if(G_lat(i) < -threshold_lr)
           plot(time(i),G_lat(i),'y.') % Plotting the values less than the threshold value as yellow dots
           hold on                     % Holding on to the graph
        end 
    end
end
 
 
%Labeling the axis and adding a title
xlabel('Time (s)');
ylabel('Lateral G-force Acceleration (ms-2)');
title('Time vs Lateral G-force Acceleration');
 
%Adding a legend
lege = zeros(2,1);
lege(1) = plot(NaN,NaN,'b.','markersize',25);
lege(2) = plot(NaN,NaN,'y.','markersize',25);
legend(lege,'Left Turns','Right Turns');
 
% Turning on the grid
grid on
 
%% Plotting the left and right turns on the race track
 
% Subplot for left and right turns on the race track
subplot(1,2,2);
 
% Plot race track as in Part (b) earlier
% Plotting the race track line in a black solid line
plot(d_long,d_lat,'k-')
 
% Holding on to the previous graph
hold on;   
 
% Only plot left and right turn displacements using the _idx variables
% Also setting markers
 
% Using a for loop to plot the points on the track
for i = 1:length(G_lat)
    if (G_lat(i)> threshold_lr)
           plot(d_long(i),d_lat(i),'b.','markersize',25) % Plotting the values as blue 25 marker size dots
           hold on                                       % Holding on to the graph
    else if(G_lat(i) < -threshold_lr)
            plot(d_long(i),d_lat(i),'y.','markersize',25)% Plotting the values as yellow 25 marker size dots
            hold on                                      % Holding on to the graph
        end
    end  
end
 
%Adding a legend
lege = zeros(3,1);
lege(1) = plot(NaN,NaN,'k-');
lege(2) = plot(NaN,NaN,'b.','markersize',25);
lege(3) = plot(NaN,NaN,'y.','markersize',25);
legend(lege,'Race Track','Left Turns','Right Turns');
 
hold off;   % Release plot
 
%Labeling the axis and adding a title
xlabel('Longitudinal Distance (m)');
ylabel('Latitudinal Distance (m)');
title('Left and Right Turning Points');
 
% Printing thresholds
% Displaying the threshold values used in determining the left and right turns
fprintf('Q1c) The Threshold use to find the turns are %g and %g\n',-threshold_lr,threshold_lr)
 
% Pausing the command until key press before starting next part
pause
%% Part d
% ======
% The accelerating/braking Gs are above zero when braking and are below
% zero when accelerating. You are required to manually find a negative
% threshold value (increment of 0.1) where all points below this value identifies the braking 
% zones correctly. You are also required to find a positive threshold value (increment of 0.1)
% where all points above this value identifies the accelerating zones correctly.
% You may verify your threshold values from the velocities graph. Note that
% velocity increases when accelerating and decreases when braking.
 
 
%% Sorting the acceleration and braking points and plotting the graph
 
% Creating a new figure window to subplot (***Changing the default figure size so that all the data points can be seen clearly***)
FigHandle = figure('position',[100,100,1049,895]);
 
% Subplot for accelerating/braking Gs
subplot(2,2,1)
 
% Considered thresholds
threshold_ab = 0.1;
 
% Plot everything
% Using a for loop to plot the graph
for i = 1:length(G_ab)
    if (G_ab(i)> threshold_ab)
           plot(time(i),G_ab(i),'r.')  % Plotting the values as red dots
           hold on                     % Holding on to the graph
    else if(G_ab(i) < -threshold_ab)
            plot(time(i),G_ab(i),'g.')  % Plotting the values as green dots
            hold on                     % Holding on to the graph
        end       
    end  
end
 
%Labeling the axis and adding a title
xlabel('Time (s)');
ylabel('G-force Acceleration (ms-2)');
title('Time vs G-force Acceleration');
 
%Adding a legend
lege = zeros(2,1);
lege(1) = plot(NaN,NaN,'r.','markersize',25);
lege(2) = plot(NaN,NaN,'g.','markersize',25);
legend(lege,'Braking points','Accelerating points');
% Printing thresholds
fprintf('Q1d) The Threshold use to find the accelerating and braking are %g and %g\n\n',-threshold_ab,threshold_ab)
 
 
%% Plotting the velocity vs time graph
 
% Subplot for race car velocity
subplot(2,2,3)
 
% Velocities
% Calculating the Velocity of the race car
v = abs(sqrt((V_long).^2+(V_lat).^2));
 
% Plotting the velocity of the race car
plot(time,v);
 
% Turning on the grid
grid on
 
%Labeling the axis and adding a title
xlabel('Time(s)');
ylabel('Velocity (ms-1)');
title('Velocity vs Time');
 
%% Plotting the race track and all the left, right, forward and braking points
 
% Subplot for accelerating and braking zones on the race track
subplot(2,2,[2,4])
 
% Plot race track as in Part (b) earlier
% Plotting the race track line in a black solid line
plot(d_long,d_lat,'k-')
 
% Holding on to the previous graph
hold on;
 
% Turns
% Plotting the turns on the black solid race track line
for i = 1:length(G_lat)
    if (G_lat(i)> threshold_lr)
           plot(d_long(i),d_lat(i),'b.','markersize',25) % Plotting the values as blue 25 marker size dots
           hold on                                       % Holding on to the graph
    else if(G_lat(i) < -threshold_lr)
           plot(d_long(i),d_lat(i),'y.','markersize',25) % Plotting the values as yellow 25 marker size dots
           hold on                                       % Holding on to the graph
        end
    end  
end
 
% Accel/Brake
% Plotting the acceleration and braking graph
for i = 1:length(G_ab)
    if (G_ab(i)> threshold_ab)
           plot(d_long(i),d_lat(i),'r.') % Plotting the values as red dots
           hold on                       % Holding on to the graph
    else if(G_ab(i) < -threshold_ab)
           plot(d_long(i),d_lat(i),'g.') % Plotting the values as green dots
           hold on                       % Holding on to the graph
        end      
    end  
end
 
%Adding a legend
lege = zeros(5,1);
lege(1) = plot(NaN,NaN,'k-');
lege(2) = plot(NaN,NaN,'b.','markersize',25);
lege(3) = plot(NaN,NaN,'y.','markersize',25);
lege(4) = plot(NaN,NaN,'r.','markersize',25);
lege(5) = plot(NaN,NaN,'g.','markersize',25);
legend(lege,'Race Track','Left Turns','Right Turns','Braking Points','Accelerating Points');
 
hold off;   % Release plot
 
%Labeling the axis and adding a title
xlabel('Longitudinal Distance (m)');
ylabel('Latitudinal Distance (m)');
title('Left, Right, Forward & Braking Points');


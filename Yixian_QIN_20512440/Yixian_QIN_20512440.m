%Yixian Qin
%ssyyq4@nottingham.edu.cn

%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

a = arduino;                      % Connect the Arduino

LED= 'D2';                        % Define LED

writeDigitalPin(a, LED, 1);       % Power the LED

writeDigitalPin(a, LED, 0);       % Switch off the LED

% Create a loop to make the LED blink
for i = 1:10 
    writeDigitalPin(a, LED, 1);   % Turn on the LED
    pause(0.5); 
    writeDigitalPin(a, LED, 0);   % Turn off the LED 
    pause(0.5); 
end

clear

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
%b)
a = arduino;    % Connect the Arduino

% Data acquisition loop setup
duration = 600;                                     % The acquisition time in seconds
time_interval = 1;                                  % Read the voltage values every 1 second for 10 minutes
temperature_measurement = zeros(1, duration);       % Array to store temperature values
time = 0:1:(duration/time_interval-1);              % Array to store time values in seconds

% Define sensor
sensor = 'A0';

% Start the data acquisition and control loop
for i = 1:duration
    voltage = readVoltage(a, sensor);               % Read voltage from sensor
    temperature = voltage_to_temperature(voltage);  % Convert voltage to temperature
    temperature_measurement(i) = temperature;       % Store temperature in array
end
 
% Calculate three statistical quantities over the full dataset acquired
Temp_max = max(temperature_measurement);
Temp_min = min(temperature_measurement);
Temp_avg = mean(temperature_measurement);

%c)
% A temperature/time plot
plot(time, temperature_measurement);
xlabel('Time (seconds)');
ylabel('Temperature (°C)');

%d)
% Output the results in format in matlab
disp('Table 1 - Output to screen formatting example\n');
date=fprintf('Data logging initiated - %s\n', datestr(now, 'dd/mmm/yyyy HH:MM:SS'));
location=fprintf('Location - Nottingham\n\n');

% Output the initial data
time_initial=0;
temerature_initial=temperature_measurement(1);
fprintf('Minute\t\t%d\nTemperature\t%.2fC\n\n', time_initial, temerature_initial);

% Defined the time minute
time_minutes=1;   
% Defined the loop to output the data
for i = 1:duration
    if mod(time(i), 60) == 0
        fprintf('Minute\t\t%d\nTemperature\t%.2fC\n\n', time_minutes, temperature_measurement(i));
        time_minutes=time_minutes+1
    end
end

fprintf('Max temp\t\t%.2f C\n', Temp_max);
fprintf('Min temp\t\t%.2f C\n', Temp_min);
fprintf('Average temp\t%.2f C\n\n', Temp_avg);

fprintf('Data logging terminated');

%e)
% Output the results in a new file
% Open the file
file_id = fopen('Cabin_temperature.txt', 'w');

% Output the data
fprintf(file_id, 'Table 1 - Output to screen formatting example\n\n');
fprintf(file_id, 'Data logging initiated - %s\n', datestr(now, 'dd/mm/yyyy HH:MM:SS'));
fprintf(file_id, 'Location - Nottingham\n\n');

% Output the initial data
time_initial=0;
temerature_initial=temperature_measurement(1);
fprintf(file_id,'Minute\t\t%d\nTemperature\t%.2fC\n\n', time_initial, temerature_initial);

% Defined the time minute
time_minutes=1;   

% Defined the loop to output the data
for i = 1:duration
    if mod(time(i), 60) == 0
        fprintf(file_id,'Minute\t\t%d\nTemperature\t%.2fC\n\n', time_minutes, temperature_measurement(i));
        time_minutes=time_minutes+1;
    end
end

fprintf(file_id, 'Max temp\t\t%.2f °C\n', Temp_max);
fprintf(file_id, 'Min temp\t\t%.2f °C\n', Temp_min);
fprintf(file_id, 'Average temp\t%.2f °C\n\n', Temp_avg);

% Write the data in a formatted table
fprintf(file_id, 'Data logging terminated');

% Close the file
fclose(file_id);

clear

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
a = arduino;    % Connect the Arduino

%b)
% Create the loop 

% Define the LED
green_LED = 'D2';
yellow_LED = 'D3';
red_LED = 'D4';

% Define sensor
sensor = 'A0';

while duration>1
voltage = readVoltage(a, sensor);               % Read voltage from sensor
temperature = voltage_to_temperature(voltage); % Convert voltage to temperature

% Turn on the LED according to the temperature
    if temperature >= 18 && temperature <= 24      % Control LEDs based on temperature
        writeDigitalPin(a, green_LED, 1);          % Turn on the green LED
        writeDigitalPin(a, yellow_LED, 0);
        writeDigitalPin(a, red_LED, 0);
    elseif temperature > 24
        writeDigitalPin(a, red_LED, 1);            % Turn on the red LED
        pause(0.25);
        writeDigitalPin(a, green_LED, 0);         
        writeDigitalPin(a, yellow_LED, 0);
    else %when temperature < 18
        writeDigitalPin(a, yellow_LED, 1);         % Turn on the yellow LED
        pause(0.5);
        writeDigitalPin(a, green_LED, 0);          
        writeDigitalPin(a, red_LED, 0);
    end

% Turn off all LEDs after the data acquisition loop
writeDigitalPin(a, green_LED, 0);
writeDigitalPin(a, yellow_LED, 0);
writeDigitalPin(a, red_LED, 0);
end

%c)
a = arduino;                                        % Connect the Arduino
duration = 600;                                     % The acquisition time in seconds
time_interval = 1;                                  % Read the voltage values every 1 second for 10 minutes
temperature_measurement = zeros(1, duration);       % Array to store temperature values
time = 0:1:(duration/time_interval-1);              % Array to store time values in seconds
temp_monitor(a)

% Detailed code about task 2 are showed
for i = 1:duration
    voltage = readVoltage(a, sensor);               % Read voltage from sensor
    temperature = voltage_to_temperature(voltage);  % Convert voltage to temperature
    temperature_measurement(i) = temperature;       % Store temperature in array
end

%plotting the temperature
plot(time, temperature_measurement);
xlabel('Time (seconds)');
ylabel('Temperature (°C)');
drawnow

%e)
% Turn on the LED according to the temperature
    if temperature >= 18 && temperature <= 24      % Control LEDs based on temperature
        writeDigitalPin(a, green_LED, 1);          % Turn on the green LED
        writeDigitalPin(a, yellow_LED, 0);
        writeDigitalPin(a, red_LED, 0);
    elseif temperature > 24
        writeDigitalPin(a, red_LED, 1);            % Turn on the yellow LED
        pause(0.25);
        writeDigitalPin(a, green_LED, 0);         
        writeDigitalPin(a, yellow_LED, 0);
    else %when temperature < 18
        writeDigitalPin(a, yellow_LED, 1);         % Turn on the red LED
        pause(0.5);
        writeDigitalPin(a, green_LED, 0);          
        writeDigitalPin(a, red_LED, 0);
    end

% Turn off all LEDs after the data acquisition loop
writeDigitalPin(a, green_LED, 0);
writeDigitalPin(a, yellow_LED, 0);
writeDigitalPin(a, red_LED, 0);

%g)
doc temp_monitor
%This function is to control the state of the LED lamp under different temperature conditions:
% 1)whether it is less than 18 degrees
% 2)whether it is between 18 and 24 degrees
% 3)whether it is greater than 24 degrees

clear


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
a = arduino;                                     % Connect the Arduino
duration = 600;                                 % The acquisition time in seconds
time_interval = 1;                              % Read the voltage values every 1 second for 10 minutes
temperature_measurement = zeros(1, duration);   % Array to store temperature values
time = 0:1:(duration/time_interval);            % Array to store time values in seconds
temp_prediction(a)

% Detailed code about the task3 are showed
%{
%b)&c)
% Define the LED
green_LED = 'D2'
yellow_LED = 'D3';
red_LED = 'D4';

% Define sensor
sensor = 'A0';

voltage = readVoltage(a, 'A0');                 % Read the sensor value from analog pin A0

    % Start measuring the temperature
while duration>1
    for i=1:duration
    voltage = readVoltage(a, sensor); % Read voltage from sensor
    temperature = voltage_to_temperature(voltage); % Convert voltage to temperature
    temperature_measurement(i) = temperature; % Store temperature in array
    if i>1
        rate_temp_change=(temperature_measurement(i)-temperature_measurement(i-1))/time_interval
    end

    % Define the tempreture expected in 5 minitues
    temp_expected=temperature_measurement(i)+rate_temp_change*300;
    % Display the results
    fprintf('Rate of change\t\t\t%.2f°C/s\n', rate_temp_change);
    fprintf('Predicted temperature in 5 minutes\t%.2f°C\n', temp_expected);
    end
end

 %(d
 if temperature >= 18 && temperature <= 24 && rate_temp_change<=4 && rate_temp_change>=-4
    writeDigitalPin(a, green_LED, 1);          % Turn on the green LED
    writeDigitalPin(a, yellow_LED, 0);
    writeDigitalPin(a, red_LED, 0);
 elseif rate_temp_change>4
    writeDigitalPin(a, red_LED, 1);            % Turn on the red LED
    writeDigitalPin(a, yellow_LED, 0);          
    writeDigitalPin(a, green_LED, 0);
 else %rate_temp_change<-4;
    writeDigitalPin(a, yellow_LED, 1);         % Turn on the yellow LED
    writeDigitalPin(a, green_LED, 0);          
    writeDigitalPin(a, red_LED, 0);
 end

% Turn off all LEDs after the data acquisition loop
writeDigitalPin(a, green_LED, 0);
writeDigitalPin(a, yellow_LED, 0);
writeDigitalPin(a, red_LED, 0);

%}

 %e)
 doc temp_prediction
%This function is to measure the change in temperature and predict the temperature in the next five minutes

clear

%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

%{
The challenge in this project was mainly how to accurately measure the temperature, because 
the measurement data may be inaccurate due to the noise generated by the microcontroller 
power supply and sensor, requiring further algorithms to make the data accurate.

The main advantage of this project is that it can get the feedback in time through the 
powering on the LED, which can help to further adjust the temperature of environment.

The limitation of this project may be that it is only tested on a small circuit rather than 
a real temperature-measured machine, and the factor of different environment is different, 
which may produce some deviations in the results.

In the future, this project can be further optimized the accuracy of measurement data and 
prediction data by simulating different machine environments and different environments in 
the circuit, so that temperature can be measured more accurately and adjust the temperature 
better in reality.
%}

%% Define the function of changing voltage to tempreture 
function temperature=voltage_to_temperature(voltage)
         temperature=(voltage-0.5)/0.01;
end

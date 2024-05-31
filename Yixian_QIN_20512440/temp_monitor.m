function temp_monitor(a)

%This function is to control the state of the LED lamp under different temperature conditions:
% 1)whether it is less than 18 degrees
% 2)whether it is between 18 and 24 degrees
% 3)whether it is greater than 24 degrees

    % Define the LED
    green_LED = 'D2';
    yellow_LED = 'D3';
    red_LED = 'D4';

    % Defined the function of converting the voltage to the temperature
    voltage = readVoltage(a, 'A0');              % Read the sensor value from analog pin A0

% Define the function of changing voltage to tempreture 
function temperature=voltage_to_temperature(voltage)
         temperature=(voltage-0.5)/0.01
end

    
while duration>1
    % Start measuring the temperature
    for i = 1:duration
    voltage = readVoltage(a, sensor); % Read voltage from sensor
    temperature = voltage_to_temperature(voltage); % Convert voltage to temperature
    temperature_measurement(i) = temperature; % Store temperature in array

    %plotting the temperature
    plot(time, temperature_measurement);
    xlabel('Time (seconds)');
    ylabel('Temperature (°C)');
    drawnow

    % Defined the monitoring of the LED
    if temperature >= 18 && temperature <= 24      % Control LEDs based on temperature
        writeDigitalPin(a, green_LED, 1);          % Turn on the green LED
        writeDigitalPin(a, yellow_LED, 0);
        writeDigitalPin(a, red_LED, 0);
    elseif temperature > 24
        writeDigitalPin(a, red_LED, 1);         % Turn on the yellow LED
         pause(0.25);
        writeDigitalPin(a, green_LED, 0);         
        writeDigitalPin(a, yellow_LED, 0);
    else %when temperature < 18
        writeDigitalPin(a, yellow_LED, 1);          % Turn on the red LED
        pause(0.5);
        writeDigitalPin(a, green_LED, 0);          
        writeDigitalPin(a, red_LED, 0);
    end
    end
    end
      
    % Turn off all LEDs
writeDigitalPin(a, green_LED, 0);
writeDigitalPin(a, yellow_LED, 0);
writeDigitalPin(a, red_LED, 0);

end


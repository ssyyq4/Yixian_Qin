function temp_prediction(a)
    % Define the LED
    green_LED = 'D2';
    yellow_LED = 'D3';
    red_LED = 'D4';

    % Defined the function of converting the voltage to the temperature
    voltage = readVoltage(a, 'A0');              % Read the sensor value from analog pin A0    
    time_interval=1;
    temperature_measurement = zeros(1, duration); % Array to store temperature values

    % Define the function of changing voltage to tempreture 
function temperature=voltage_to_temperature(voltage)
         temperature=(voltage-0.5)/0.01;
end

    % Start measuring the temperature
    while duration>1
    for i = 1:duration
    voltage = readVoltage(a, sensor); % Read voltage from sensor
    temperature = voltage_to_temperature(voltage); % Convert voltage to temperature
    temperature_measurement(i) = temperature; % Store temperature in array

    if i>1
        rate_temp_change=(temperature_measurement(i)-temperature_measurement(i-1))/time_interval;
    end

    % Define the tempreture expected in 5 minitues
    temp_expected=temperature_measurement(i)+rate_temp_change*300;
    % Display the results
    fprintf('Rate of change\t\t%.2f°C/s\n', rate_temp_change);
    fprintf('Predicted temperature in 5 minutes\t%.2f°C\n', temp_expected);
    end
    
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
    end
    end


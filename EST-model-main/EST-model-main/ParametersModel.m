R_air = 287;
Temp = 293.15;      %roomtemp assumed
P_atm = 101325;
P_max = 10000000;
P_tank = 132516;

V = 5; 

m_initial = (P_atm * V) / (R_air * Temp);


DataFromSupply = readtable('data/Team43_supply.csv', 'CommentStyle', '#');  % Skip the comment lines starting with #
TimeVector = DataFromSupply.Var1;
PowerFromSupply = DataFromSupply.Var2;


DataFromDemand = readtable('data/Team43_demand.csv', 'CommentStyle', '#');  % Skip the comment lines starting with #
PowerFromDemand = DataFromDemand.Var2;

Surplus = PowerFromSupply - PowerFromDemand;
Deficit = PowerFromDemand - PowerFromSupply;

Surplus(Surplus < 0) = 0;       %Since surplus becomes deficit below 0
Deficit(Deficit < 0) = 0;       %Since deficit becomes surplus below 0

SurplusWatts = Surplus * 1e6;
DeficitWatts = Deficit * 1e6;


E_surplus = [TimeVector, SurplusWatts];
E_deficit = [TimeVector, DeficitWatts];


assignin('base', 'E_surplus', E_surplus);
assignin('base', 'E_deficit', E_deficit);

